import 'dart:async';

import 'package:flutter/widgets.dart';

import '../../../../data/repositories/settings_repository.dart';
import '../../../../data/services/bluetooth_service.dart';
import '../../../../data/services/location_service.dart';
import '../../../../domain/speed.dart';
import '../../../../domain/tracker.dart';
import '../../../core/sensor_view_model.dart';

/// What the Tracker check is doing.
enum TrackerMode {
  idle,

  /// A short scan where the phone is.
  here,

  /// Listening on a walk or drive, noting the places passed.
  moving,

  /// Following one tracker's signal to find it.
  find,
}

/// The Tracker check: lists the Bluetooth trackers nearby that are away
/// from their owners, and on the move warns about any heard at several
/// places (see [FollowRules]). Only while open and in front: nothing
/// runs in the background, and nothing is kept after it closes except the
/// trackers the user marked as their own.
class TrackerViewModel extends ActiveViewModel {
  TrackerViewModel({
    required this._settings,
    this._bluetooth = const BluetoothService(),
    this._location = const LocationService(),
    this._now = DateTime.now,
  }) : super(_settings);

  final SettingsRepository _settings;
  final BluetoothService _bluetooth;
  final LocationService _location;
  final DateTime Function() _now;

  /// How long "Scan here" listens.
  static const hereTime = Duration(seconds: 30);

  /// A tracker not heard for this long is no longer drawn as nearby.
  static const recentTime = Duration(seconds: 60);

  /// Finding: a tracker not heard for this long is "not heard".
  static const lostTime = Duration(seconds: 15);

  /// A GPS fix older than this (by when it arrived) doesn't say where a
  /// tracker was heard, and on the move the user is told GPS is lost.
  static const _fixAge = Duration(seconds: 30);

  /// A stopped scan lingers this long before it is really stopped, so
  /// quick Stop and Scan taps reuse it: Android ignores a sixth scan start
  /// within 30 seconds without saying so.
  static const _scanGrace = Duration(seconds: 6);

  final _check = FollowCheck();
  final _placesPassed = <({Place place, double accuracy})>[];

  BluetoothAccess? _access;
  bool _asked = false;
  TrackerMode _mode = TrackerMode.idle;
  TrackerMode _beforeFind = TrackerMode.idle;
  LocationAccess? _locationProblem;
  String? _finding;
  bool _hidden = false;
  bool _scanFailed = false;
  Set<String> _mine = const {};

  /// Time actually spent listening (the check on the move, or the last
  /// short scan), not counting pauses.
  Duration _listened = Duration.zero;
  DateTime? _listeningSince;

  LocationFix? _fix;
  DateTime? _fixAt;
  StreamSubscription<BleSignal>? _scan;
  StreamSubscription<LocationFix>? _fixes;
  Timer? _hereTimer, _tick, _grace, _accessPoll;
  bool _dirty = false;
  AppLifecycleListener? _lifecycle;

  /// Null while finding out.
  BluetoothAccess? get access => _access;
  TrackerMode get mode => _mode;

  /// Set when "Check while I move" needs location it doesn't have.
  LocationAccess? get locationProblem => _locationProblem;

  /// Paused because the app is hidden (or the screen went off).
  bool get paused => _hidden && _mode != TrackerMode.idle;

  /// Listening, as the user asked (not a scan lingering after Stop).
  bool get scanning => _mode != TrackerMode.idle && _scan != null && !_hidden;

  /// The scan stopped by itself (Bluetooth trouble).
  bool get scanFailed => _scanFailed;

  /// Every tracker heard this time, followers first, then closest; the
  /// user's own and those next to their owners left out.
  List<TrackerTrail> get trackers => _check.sorted(mine: _mine);

  /// Those heard in the last [recentTime], and every follower: what the
  /// rings show as near you now.
  List<TrackerTrail> get nearby => [
    for (final t in trackers)
      if (FollowCheck.follows(t) || !isStale(t)) t,
  ];

  int get followingCount => trackers.where(FollowCheck.follows).length;

  /// Not heard for a while (moved off, or out of range).
  bool isStale(TrackerTrail t) => _now().difference(t.lastSeen) > recentTime;

  /// Heard trackers the user marked as their own (to unmark them).
  List<TrackerTrail> get mineHeard => [
    for (final t in _check.trails)
      if (isMine(t.id)) t,
  ];

  /// Listened long enough that "nothing heard" means something.
  bool get listenedEnough =>
      listenedFor >= hereTime - const Duration(seconds: 5);

  /// How long it has actually listened (pauses not counted).
  Duration get listenedFor {
    final since = _listeningSince;
    return since == null ? _listened : _listened + _now().difference(since);
  }

  /// On the move with no recent GPS fix: places aren't being noted.
  bool get gpsLost {
    if (_mode != TrackerMode.moving || _hidden) return false;
    final at = _fixAt;
    return at == null
        ? listenedFor > const Duration(seconds: 45)
        : _now().difference(at) > _fixAge;
  }

  /// Separate places passed so far on the move.
  int get placesPassed => _placesPassed.length;

  /// The tracker being found.
  TrackerTrail? get finding => _finding == null
      ? null
      : _check.trails.where((t) => t.id == _finding).firstOrNull;

  /// The tracker being found has been heard lately.
  bool get findingHeard {
    final t = finding;
    return t != null && _now().difference(t.lastSeen) < lostTime;
  }

  bool isMine(String id) => _mine.contains(id);

  @override
  void onActivate() {
    _access = null;
    _asked = false;
    _hidden = false;
    _mine = _settings.trackerMine;
    _lifecycle = AppLifecycleListener(onShow: _shown, onHide: _hide);
    unawaited(_checkAccess());
  }

  @override
  void onDeactivate() {
    _lifecycle?.dispose();
    _lifecycle = null;
    _accessPoll?.cancel();
    _accessPoll = null;
    _stopListening(now: true);
    _mode = TrackerMode.idle;
    _finding = null;
    _locationProblem = null;
    _scanFailed = false;
    _listened = Duration.zero;
    _check.clear();
    _placesPassed.clear();
  }

  @override
  void update() {
    _mine = _settings.trackerMine;
    notifyListeners();
  }

  // ---- Access

  /// Shows the system prompt (the explanation has been read).
  Future<void> allow() async {
    _asked = true;
    final a = await _bluetooth.request();
    // Refused: point to Settings rather than explain again.
    _setAccess(a == BluetoothAccess.needed ? BluetoothAccess.denied : a);
  }

  Future<void> openSettings() => switch (_access) {
    BluetoothAccess.bluetoothOff => _bluetooth.openBluetoothSettings(),
    BluetoothAccess.locationOff => _location.openLocationSettings(),
    _ => _bluetooth.openAppSettings(),
  };

  Future<void> _checkAccess() async {
    final a = await _bluetooth.check();
    _setAccess(
      a == BluetoothAccess.needed && _asked ? BluetoothAccess.denied : a,
    );
  }

  void _setAccess(BluetoothAccess a) {
    if (!active) return;
    final was = _access;
    _access = a;
    if (a != BluetoothAccess.granted) {
      _mode = TrackerMode.idle;
      _stopListening(now: true);
    }
    // Bluetooth or location switched off from the quick settings doesn't
    // hide the app: look again every couple of seconds until it's back.
    final switchedOff =
        a == BluetoothAccess.bluetoothOff || a == BluetoothAccess.locationOff;
    if (switchedOff) {
      _accessPoll ??= Timer.periodic(
        const Duration(seconds: 2),
        (_) => unawaited(_checkAccess()),
      );
    } else {
      _accessPoll?.cancel();
      _accessPoll = null;
    }
    if (a != was) notifyListeners();
  }

  void _shown() {
    _hidden = false;
    unawaited(
      _checkAccess().then((_) {
        if (active && _access == BluetoothAccess.granted) _resume();
      }),
    );
  }

  void _hide() {
    _hidden = true;
    // A short scan doesn't carry on later: it simply ends.
    if (_mode == TrackerMode.here) _mode = TrackerMode.idle;
    _stopListening(now: true);
    notifyListeners();
  }

  // ---- Scanning

  /// Listens for [hereTime] where the phone is.
  void scanHere() {
    if (_access != BluetoothAccess.granted || _mode == TrackerMode.moving) {
      return;
    }
    _mode = TrackerMode.here;
    _scanFailed = false;
    _check.clear();
    _listened = Duration.zero;
    _listen();
    _hereTimer?.cancel();
    _hereTimer = Timer(hereTime, () {
      if (_mode != TrackerMode.here) return;
      _mode = TrackerMode.idle;
      _stopListening();
      notifyListeners();
    });
    notifyListeners();
  }

  /// Listens on a walk or drive, with the screen kept on, noting places.
  Future<void> checkWhileMoving() async {
    if (_access != BluetoothAccess.granted) return;
    var l = await _location.check();
    if (l == LocationAccess.needed) l = await _location.request();
    if (!active) return;
    if (l != LocationAccess.granted) {
      _locationProblem = l == LocationAccess.needed ? LocationAccess.denied : l;
      notifyListeners();
      return;
    }
    _locationProblem = null;
    _scanFailed = false;
    _hereTimer?.cancel();
    _check.clear();
    _placesPassed.clear();
    _listened = Duration.zero;
    _mode = TrackerMode.moving;
    _listen();
    notifyListeners();
  }

  void openLocationSettings() => _locationProblem == LocationAccess.serviceOff
      ? unawaited(_location.openLocationSettings())
      : unawaited(_location.openAppSettings());

  void dismissLocationProblem() {
    _locationProblem = null;
    notifyListeners();
  }

  /// Ends whatever check is running; what was heard stays listed.
  void stop() {
    _hereTimer?.cancel();
    _mode = TrackerMode.idle;
    _stopListening();
    notifyListeners();
  }

  /// Follows [id]'s signal to find it.
  void find(String id) {
    if (_mode != TrackerMode.find) _beforeFind = _mode;
    _finding = id;
    _hereTimer?.cancel();
    _mode = TrackerMode.find;
    _listen();
    notifyListeners();
  }

  /// Back from finding: a check on the move carries on; anything else stops.
  void doneFinding() {
    _finding = null;
    _mode = _beforeFind == TrackerMode.moving
        ? TrackerMode.moving
        : TrackerMode.idle;
    if (_mode == TrackerMode.idle) _stopListening();
    notifyListeners();
  }

  /// Marks [id] as the user's own (never listed again), or not.
  Future<void> toggleMine(String id) {
    final mine = {..._mine};
    if (!mine.remove(id)) mine.add(id);
    _mine = mine;
    notifyListeners();
    return _settings.setTrackerMine(mine);
  }

  bool get _onTheMove =>
      _mode == TrackerMode.moving ||
      (_mode == TrackerMode.find && _beforeFind == TrackerMode.moving);

  void _resume() {
    if (_mode != TrackerMode.idle) _listen();
  }

  void _listen() {
    if (_hidden) return;
    _grace?.cancel();
    _grace = null;
    _listeningSince ??= _now();
    _scan ??= _bluetooth.signals().listen(
      _heard,
      onError: (Object _) => _scanStopped(),
      onDone: _scanStopped,
    );
    if (_onTheMove) {
      _fixes ??= _location.fixes().listen(
        _moved,
        // GPS switched off or lost: [gpsLost] says so on screen.
        onError: (Object _) => _dropFixes(),
        onDone: _dropFixes,
      );
    }
    unawaited(_bluetooth.keepScreenOn(_onTheMove));
    // Many adverts a second: redraw a few times a second, not for each,
    // and every second anyway so minutes, staleness and "lost" stay true.
    var ticks = 0;
    _tick ??= Timer.periodic(const Duration(milliseconds: 250), (_) {
      if (!_dirty && ++ticks % 4 != 0) return;
      _dirty = false;
      notifyListeners();
    });
  }

  /// Stops listening. A user's Stop leaves the scan running a few seconds
  /// in case they start again; leaving the tool or hiding the app stops it
  /// [now].
  void _stopListening({bool now = false}) {
    _hereTimer?.cancel();
    final since = _listeningSince;
    if (since != null) _listened += _now().difference(since);
    _listeningSince = null;
    _dropFixes();
    _fix = null;
    _fixAt = null;
    _tick?.cancel();
    _tick = null;
    unawaited(_bluetooth.keepScreenOn(false));
    _grace?.cancel();
    if (now) {
      _grace = null;
      _cancelScan();
    } else {
      _grace = Timer(_scanGrace, () {
        _grace = null;
        if (_mode == TrackerMode.idle) _cancelScan();
      });
    }
  }

  void _cancelScan() {
    final s = _scan;
    _scan = null;
    unawaited(s?.cancel());
  }

  void _dropFixes() {
    final f = _fixes;
    _fixes = null;
    unawaited(f?.cancel());
  }

  /// The scan ended on its own: Bluetooth off, permission withdrawn, or a
  /// scan error. Say so rather than look as if it were still listening.
  void _scanStopped() {
    _cancelScan();
    if (!active) return;
    if (_mode != TrackerMode.idle) _scanFailed = true;
    _mode = TrackerMode.idle;
    _stopListening(now: true);
    notifyListeners();
    unawaited(_checkAccess());
  }

  void _moved(LocationFix fix) {
    _fix = fix;
    // When it arrived, by the phone's clock: GPS time can differ from it.
    _fixAt = _now();
    if (fix.accuracy > FollowRules.worstAccuracyM) return;
    final p = (latitude: fix.latitude, longitude: fix.longitude);
    if (FollowCheck.isNewPlace(_placesPassed, p, fix.accuracy)) {
      _placesPassed.add((place: p, accuracy: fix.accuracy));
      _dirty = true;
    }
  }

  void _heard(BleSignal s) {
    final ad = recognise(s, now: _now());
    if (ad == null) return;
    final fix = _fix, at = _fixAt;
    final fresh =
        _onTheMove &&
        fix != null &&
        at != null &&
        _now().difference(at) <= _fixAge;
    _check.add(
      ad,
      place: fresh ? (latitude: fix.latitude, longitude: fix.longitude) : null,
      accuracyM: fresh ? fix.accuracy : null,
    );
    _dirty = true;
  }

  @override
  void dispose() {
    _accessPoll?.cancel();
    _stopListening(now: true);
    super.dispose();
  }
}
