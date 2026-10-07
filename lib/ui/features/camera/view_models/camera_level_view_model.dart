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

/// Camera level: a grid that follows gravity over the back camera's
/// picture. The camera runs only while the tool is open and in front;
/// Freeze holds the picture and the reading together.
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

  /// 0 small, 1 medium, 2 large squares.
  int get gridSize => _settings.cameraGrid;
  void setGridSize(int size) => unawaited(_settings.setCameraGrid(size));

  /// Starts the camera after the explanation (the system asks first).
  Future<void> allow() => _start();

  Future<void> openSettings() => _camera.openAppSettings();

  Future<void> toggleFreeze() async {
    _frozen = !_frozen;
    _held = _frozen ? _pose : null;
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
