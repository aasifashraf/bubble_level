import 'dart:async';

import 'package:flutter/widgets.dart';

import '../../../../data/repositories/orientation_repository.dart';
import '../../../../data/repositories/settings_repository.dart';
import '../../../../data/services/camera_service.dart';
import '../../../../domain/camera_level.dart';
import '../../../core/sensor_view_model.dart';
import '../../level/view_models/level_view_model.dart';

/// Where the camera stands for the camera level.
enum CameraAccess {
  /// Finding out, or starting the camera.
  checking,

  /// Not asked yet: explain, then ask.
  needed,

  /// Refused: point to Settings.
  denied,

  /// No camera to use.
  missing,
  granted,
}

/// Camera level: true level and plumb lines (following gravity) and the
/// phone's own lines over the back camera's picture. Freeze holds the
/// picture and the pose; two handles then mark an edge in it, read against
/// true level. The camera runs only while the tool is open and in front.
class CameraLevelViewModel extends SensorViewModel {
  CameraLevelViewModel({
    required OrientationRepository orientation,
    required this._settings,
    this._camera = const CameraService(),
    this._onLevelReached,
  }) : super(orientation);

  final SettingsRepository _settings;
  final CameraService _camera;
  final VoidCallback? _onLevelReached;

  CameraAccess _access = CameraAccess.checking;
  CameraFeed? _feed;
  CameraPose? _pose, _held;
  bool _frozen = false, _torch = false, _noTorch = false, _wasLevel = false;
  AppLifecycleListener? _lifecycle;

  /// Bumped on each open/close, so a late camera start is dropped.
  int _session = 0;

  CameraAccess get access => _access;
  CameraFeed? get feed => _feed;

  /// The pose now, or the one held by Freeze; null while held too flat.
  CameraPose? get pose => _frozen ? _held : _pose;

  bool get frozen => _frozen;
  bool get torch => _torch;

  /// The light failed once: its button is hidden.
  bool get torchAvailable => !_noTorch;

  bool get level => pose != null && _wasLevel;

  bool _showPhone = true, _showTrue = true;
  List<Offset>? _handles;

  /// Where the overlay is drawn, logical pixels: set by the view, used to
  /// place the handles when the picture is frozen.
  Size area = Size.zero;

  /// The lines fixed to the screen, and the lines that follow gravity.
  bool get showPhone => _showPhone;
  bool get showTrue => _showTrue;

  void togglePhoneLines() {
    _showPhone = !_showPhone;
    notifyListeners();
  }

  void toggleTrueLines() {
    _showTrue = !_showTrue;
    notifyListeners();
  }

  /// Frozen: the two ends of the edge line, in the overlay.
  List<Offset>? get handles => _handles;

  void moveHandle(int i, Offset to) {
    final h = _handles;
    if (h == null) return;
    _handles = [...h]
      ..[i] = Offset(
        to.dx.clamp(0.0, area.width),
        to.dy.clamp(0.0, area.height),
      );
    notifyListeners();
  }

  /// The marked edge against true level or plumb; null unless frozen.
  EdgeReading? get edge {
    final h = _handles, pose = _held;
    if (!_frozen || h == null || pose == null) return null;
    return edgeReading(h[0].dx, h[0].dy, h[1].dx, h[1].dy, pose.rotation);
  }

  /// Leaning towards or away from the wall more than this, an edge in the
  /// picture is skewed by perspective.
  static const squareWithin = 5.0;

  /// Starts the camera after the explanation (the system asks first).
  Future<void> allow() => _start();

  Future<void> openSettings() => _camera.openAppSettings();

  Future<void> toggleFreeze() async {
    _frozen = !_frozen;
    _held = _frozen ? _pose : null;
    // The edge line starts level across the middle, a little above it.
    final c = area.center(Offset.zero) - const Offset(0, 80);
    _handles = _frozen && _held != null
        ? [c - const Offset(90, 0), c + const Offset(90, 0)]
        : null;
    notifyListeners();
    await _feed?.setFrozen(_frozen);
  }

  Future<void> toggleTorch() async {
    final feed = _feed;
    if (feed == null) return;
    final on = !_torch;
    if (await feed.setTorch(on)) {
      _torch = on;
    } else {
      _noTorch = true;
    }
    notifyListeners();
  }

  Future<void> _start() async {
    final session = ++_session;
    _access = CameraAccess.checking;
    notifyListeners();
    try {
      final feed = await _camera.open();
      if (session != _session || !active) {
        await feed.dispose();
        return;
      }
      _feed = feed;
      _access = CameraAccess.granted;
      unawaited(_settings.setCameraAllowed(true));
    } on CameraDenied {
      if (session != _session) return;
      _access = CameraAccess.denied;
    } on CameraMissing {
      if (session != _session) return;
      _access = CameraAccess.missing;
    }
    if (active) notifyListeners();
  }

  /// Lets the camera go (the light goes off with it).
  void _stop() {
    _session++;
    final feed = _feed;
    _feed = null;
    _torch = false;
    _frozen = false;
    _held = null;
    _handles = null;
    if (feed != null) unawaited(feed.dispose());
  }

  @override
  void onActivate() {
    _wasLevel = false;
    _lifecycle = AppLifecycleListener(
      onShow: () {
        if (_access == CameraAccess.granted ||
            _access == CameraAccess.checking) {
          unawaited(_start());
        }
      },
      onHide: () {
        if (_feed != null) {
          _stop();
          _access = CameraAccess.checking;
          notifyListeners();
        }
      },
    );
    if (_settings.cameraAllowed) {
      unawaited(_start());
    } else {
      _access = CameraAccess.needed;
    }
  }

  @override
  void onDeactivate() {
    _lifecycle?.dispose();
    _lifecycle = null;
    _stop();
  }

  @override
  void update() {
    final g = reading.screenGravity;
    _pose = g == null ? null : cameraPose(g, offset: _settings.edgeOffset);
    if (!_frozen) {
      final tilt = _pose?.tilt.abs();
      const t = LevelViewModel.tolerance, h = LevelViewModel.hysteresis;
      final now = tilt != null && tilt < (_wasLevel ? t + h : t);
      if (now && !_wasLevel) _onLevelReached?.call();
      _wasLevel = now;
    }
    notifyListeners();
  }
}
