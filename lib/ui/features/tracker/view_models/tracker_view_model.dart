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

  /// A GPS fix older than this doesn't say where a tracker was heard.
  static const _fixAge = Duration(seconds: 20);

  final _check = FollowCheck();
  final _placesPassed = <Place>[];

  BluetoothAccess? _access;
  bool _asked = false;
  TrackerMode _mode = TrackerMode.idle;
  TrackerMode _beforeFind = TrackerMode.idle;
  LocationAccess? _locationProblem;
  String? _finding;
  DateTime? _since;
  bool _hidden = false;
  bool _everScanned = false;

  LocationFix? _fix;
  StreamSubscription<BleSignal>? _scan;
  StreamSubscription<LocationFix>? _fixes;
  Timer? _hereTimer, _repaint;
  bool _dirty = false;
  AppLifecycleListener? _lifecycle;

  /// Null while finding out.
  BluetoothAccess? get access => _access;
  TrackerMode get mode => _mode;

  /// Set when "Check while I move" needs location it doesn't have.
  LocationAccess? get locationProblem => _locationProblem;

  /// Paused because the app is hidden (or the screen went off).
  bool get paused => _hidden && _mode != TrackerMode.idle;

  /// Trackers heard, followers first, then closest; the user's own and
  /// those next to their owners left out.
  List<TrackerTrail> get trackers => _check.sorted(mine: _settings.trackerMine);

  int get followingCount => trackers.where(FollowCheck.follows).length;

  /// Heard trackers the user marked as their own (to unmark them).
  List<TrackerTrail> get mineHeard => [
    for (final t in _check.trails)
      if (isMine(t.id)) t,
  ];

  /// Listening right now.
  bool get scanning => _scan != null;

  /// A scan has run since the tool opened (so "nothing heard" means it).
  bool get everScanned => _everScanned;

  /// How long the check on the move has run.
  Duration get movingFor =>
      _since == null ? Duration.zero : _now().difference(_since!);

  /// Separate places passed so far on the move.
  int get placesPassed => _placesPassed.length;

  /// The tracker being found, while it is still heard.
  TrackerTrail? get finding => _finding == null
      ? null
      : _check.trails.where((t) => t.id == _finding).firstOrNull;

  bool isMine(String id) => _settings.trackerMine.contains(id);

  @override
  void onActivate() {
    _access = null;
    _asked = false;
    _hidden = false;
    _lifecycle = AppLifecycleListener(onShow: _shown, onHide: _hide);
    unawaited(_checkAccess());
  }

  @override
  void onDeactivate() {
    _everScanned = false;
    _lifecycle?.dispose();
    _lifecycle = null;
    _stopListening();
    _mode = TrackerMode.idle;
    _finding = null;
    _since = null;
    _locationProblem = null;
    _check.clear();
    _placesPassed.clear();
  }

  @override
  void update() => notifyListeners();

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
    _access = a;
    if (a != BluetoothAccess.granted) _stopListening();
    notifyListeners();
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
    _stopListening();
    notifyListeners();
  }

  // ---- Scanning

  /// Listens for [hereTime] where the phone is.
  void scanHere() {
    if (_access != BluetoothAccess.granted || _mode == TrackerMode.moving) {
      return;
    }
    _mode = TrackerMode.here;
    _check.clear();
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
    _hereTimer?.cancel();
    _check.clear();
    _placesPassed.clear();
    _mode = TrackerMode.moving;
    _since = _now();
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
    _since = null;
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
    final mine = {..._settings.trackerMine};
    if (!mine.remove(id)) mine.add(id);
    return _settings.setTrackerMine(mine);
  }

  void _resume() {
    if (_mode != TrackerMode.idle) _listen();
  }

  void _listen() {
    if (_hidden) return;
    _everScanned = true;
    _scan ??= _bluetooth.signals().listen(
      _heard,
      onError: (Object _) {
        _scan = null;
        unawaited(_checkAccess());
      },
      onDone: () => _scan = null,
    );
    final moving =
        _mode == TrackerMode.moving ||
        (_mode == TrackerMode.find && _beforeFind == TrackerMode.moving);
    if (moving) {
      _fixes ??= _location.fixes().listen(
        _moved,
        onError: (Object _) => _fixes = null,
        onDone: () => _fixes = null,
      );
    }
    unawaited(_bluetooth.keepScreenOn(moving));
    // Many adverts a second: redraw a few times a second, not for each.
    _repaint ??= Timer.periodic(const Duration(milliseconds: 250), (_) {
      if (!_dirty) return;
      _dirty = false;
      notifyListeners();
    });
  }

  void _stopListening() {
    _hereTimer?.cancel();
    unawaited(_scan?.cancel());
    unawaited(_fixes?.cancel());
    _scan = null;
    _fixes = null;
    _repaint?.cancel();
    _repaint = null;
    unawaited(_bluetooth.keepScreenOn(false));
  }

  void _moved(LocationFix fix) {
    _fix = fix;
    if (fix.accuracy > FollowRules.worstAccuracyM) return;
    final p = (latitude: fix.latitude, longitude: fix.longitude);
    if (_placesPassed.every(
      (q) => metresBetween(p, q) >= FollowRules.placeApartM,
    )) {
      _placesPassed.add(p);
      _dirty = true;
    }
  }

  void _heard(BleSignal s) {
    final ad = recognise(s);
    if (ad == null) return;
    final fix = _fix;
    final fresh =
        _mode != TrackerMode.here &&
        fix != null &&
        _now().difference(fix.time).abs() <= _fixAge;
    _check.add(
      ad,
      place: fresh ? (latitude: fix.latitude, longitude: fix.longitude) : null,
      accuracyM: fresh ? fix.accuracy : null,
    );
    _dirty = true;
  }

  @override
  void dispose() {
    _stopListening();
    super.dispose();
  }
}
