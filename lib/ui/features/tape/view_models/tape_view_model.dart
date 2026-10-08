import 'dart:async';

import 'package:flutter/widgets.dart';

import '../../../../data/repositories/settings_repository.dart';
import '../../../../data/services/ar_service.dart';
import '../../../../domain/angles.dart';
import '../../../../domain/ruler.dart';
import '../../../../domain/tape_measure.dart';
import '../../../core/sensor_view_model.dart';

/// Where the tape measure stands before it can measure.
enum TapeAccess {
  /// Finding out, or starting AR.
  checking,

  /// The camera isn't allowed yet: explain, then ask.
  needed,

  /// The camera was refused: point to Settings.
  denied,

  /// Google Play Services for AR needs installing or updating.
  install,

  /// This phone can't run ARCore.
  unsupported,

  /// The camera is busy or AR stopped.
  failed,
  granted,
}

/// Tape measure: ARCore follows the phone in 3D; each tap adds a point
/// where the aim meets a surface. Points chain into pieces, and coming
/// back to the first point closes the shape for its area. Every reading is
/// worked out from ARCore's points, so it is approximate. AR runs only
/// while the tool is open and in front.
class TapeViewModel extends ActiveViewModel {
  TapeViewModel({
    required SettingsRepository settings,
    ArService ar = const ArService(),
    VoidCallback? onPlaced,
  }) : this._(ValueNotifier(ArFrame.none), settings, ar, onPlaced);

  TapeViewModel._(this._frame, this._settings, this._ar, this._onPlaced)
    : super(_frame);

  final ValueNotifier<ArFrame> _frame;
  final SettingsRepository _settings;
  final ArService _ar;
  final VoidCallback? _onPlaced;

  TapeAccess _access = TapeAccess.checking;
  int? _texture;
  bool _closed = false, _missed = false, _starting = false;
  StreamSubscription<ArFrame>? _frames;
  AppLifecycleListener? _lifecycle;
  Timer? _missTimer;

  /// Bumped on each start and stop, so a late start is dropped.
  int _session = 0;

  /// The view's size (logical pixels) and its pixel ratio, where AR runs.
  Size _view = Size.zero;
  double _ratio = 1;

  /// The aim, as a fraction of the view (the middle of the picture).
  static const aimAt = Offset(0.5, 0.45);

  /// The aim snaps onto the first point within this many logical pixels.
  static const snapWithin = 36.0;

  TapeAccess get access => _access;

  /// The camera picture's texture once AR runs.
  int? get texture => _texture;

  ArFrame get frame => _frame.value;

  /// The tapped points, joined; closed once back at the first.
  TapeShape get shape =>
      TapeShape(frame.points, closed: _closed && frame.points.length >= 3);

  /// The aim is on the first point: the next tap closes the shape.
  bool get snapping {
    final s = shape, aim = frame.aim, m = frame.viewProj;
    if (!s.canClose || aim == null || m == null || _view.isEmpty) return false;
    final a = project(m, aim, _view.width, _view.height);
    final f = project(m, s.points.first, _view.width, _view.height);
    if (a == null || f == null) return false;
    return (Offset(a.x, a.y) - Offset(f.x, f.y)).distance < snapWithin;
  }

  /// The end of the piece being measured: the aim, or the first point when
  /// snapping; null when closed or nothing is under the aim.
  Vec3? get live {
    if (shape.closed) return null;
    return snapping ? shape.points.first : frame.aim;
  }

  /// The last tap found no surface under the aim (shown for a moment).
  bool get missed => _missed;

  /// Inches, when the user measures in inches (shared with the ruler).
  bool get inches => _settings.rulerUnit == LengthUnit.inch;

  void toggleUnit() => unawaited(
    _settings.setRulerUnit(inches ? LengthUnit.cm : LengthUnit.inch),
  );

  /// The view AR draws into; starts AR once it is known.
  void layout(Size view, double pixelRatio) {
    if (view == _view && pixelRatio == _ratio) return;
    final restart = _texture != null && view != _view;
    _view = view;
    _ratio = pixelRatio;
    if (restart) {
      _stop();
      _ready = true;
      _access = TapeAccess.checking;
    }
    _maybeStart();
  }

  /// Adds a point at the aim, or closes the shape when snapping.
  Future<void> add() async {
    if (shape.closed) return;
    if (snapping) {
      _closed = true;
      _onPlaced?.call();
      notifyListeners();
      return;
    }
    final ok = await _ar.add();
    if (!active) return;
    if (ok) {
      _onPlaced?.call();
    } else {
      _missed = true;
      _missTimer?.cancel();
      _missTimer = Timer(const Duration(seconds: 2), () {
        _missed = false;
        notifyListeners();
      });
    }
    notifyListeners();
  }

  /// Opens a closed shape, or takes the last point away.
  Future<void> undo() async {
    if (shape.closed) {
      _closed = false;
      notifyListeners();
      return;
    }
    await _ar.undo();
  }

  Future<void> clear() async {
    _closed = false;
    notifyListeners();
    await _ar.clear();
  }

  /// Shows the system camera prompt (the explanation has been read).
  Future<void> allow() async {
    final ok = await _ar.requestCamera();
    if (!active) return;
    if (ok) {
      unawaited(_settings.setCameraAllowed(true));
      _access = TapeAccess.checking;
      notifyListeners();
      _maybeStart(ready: true);
    } else {
      _access = TapeAccess.denied;
      notifyListeners();
    }
  }

  /// Installs Google Play Services for AR (opens the Play Store).
  Future<void> install() async {
    final r = await _ar.install();
    if (!active) return;
    if (r == 'installed') {
      unawaited(_check());
    } else if (r == 'unsupported') {
      _access = TapeAccess.unsupported;
      notifyListeners();
    }
    // "requested": the Play Store is open; checked again on return.
  }

  Future<void> openSettings() => _ar.openAppSettings();

  /// Tries again after the camera was busy.
  Future<void> retry() => _check();

  Future<void> _check() async {
    final session = ++_session;
    _access = TapeAccess.checking;
    notifyListeners();
    final support = await _ar.support();
    if (session != _session || !active) return;
    if (support == ArSupport.unsupported) {
      _access = TapeAccess.unsupported;
    } else if (support == ArSupport.install) {
      _access = TapeAccess.install;
    } else if (!await _ar.hasCamera()) {
      if (session != _session || !active) return;
      // Asked before and since refused: point to Settings.
      _access = _settings.cameraAllowed ? TapeAccess.denied : TapeAccess.needed;
    } else {
      _access = TapeAccess.checking;
      _maybeStart(ready: true);
    }
    notifyListeners();
  }

  bool _ready = false;

  /// Starts AR once allowed and laid out.
  void _maybeStart({bool ready = false}) {
    if (ready) _ready = true;
    if (!_ready || !active || _starting || _texture != null || _view.isEmpty) {
      return;
    }
    unawaited(_start());
  }

  Future<void> _start() async {
    final session = ++_session;
    _starting = true;
    try {
      final id = await _ar.start(
        width: (_view.width * _ratio).round(),
        height: (_view.height * _ratio).round(),
        aimX: aimAt.dx,
        aimY: aimAt.dy,
      );
      if (session != _session || !active) {
        await _ar.stop();
        return;
      }
      _texture = id;
      _access = TapeAccess.granted;
      _frames = _ar.frames().listen((f) {
        if (f.error != null) {
          _stop();
          _access = TapeAccess.failed;
          notifyListeners();
          return;
        }
        _frame.value = f;
      });
    } on ArStartFailed catch (e) {
      if (session != _session) return;
      _access = switch (e.reason) {
        'install' => TapeAccess.install,
        'denied' => TapeAccess.denied,
        'unsupported' => TapeAccess.unsupported,
        _ => TapeAccess.failed,
      };
    } finally {
      _starting = false;
    }
    if (active) notifyListeners();
  }

  void _stop() {
    _session++;
    _ready = false;
    unawaited(_frames?.cancel());
    _frames = null;
    if (_texture != null) unawaited(_ar.stop());
    _texture = null;
    _closed = false;
    _frame.value = ArFrame.none;
  }

  @override
  void onActivate() {
    _lifecycle = AppLifecycleListener(
      onShow: () {
        if (_access != TapeAccess.unsupported) unawaited(_check());
      },
      onHide: () {
        _stop();
        if (_access == TapeAccess.granted) _access = TapeAccess.checking;
        notifyListeners();
      },
    );
    unawaited(_check());
  }

  @override
  void onDeactivate() {
    _lifecycle?.dispose();
    _lifecycle = null;
    _missTimer?.cancel();
    _missed = false;
    _stop();
    _view = Size.zero;
  }

  @override
  void update() => notifyListeners();

  @override
  void dispose() {
    super.dispose();
    _frame.dispose();
  }
}
