import 'package:flutter/foundation.dart';

import '../../../../data/repositories/orientation_repository.dart';
import '../../../../data/repositories/settings_repository.dart';
import '../../../../domain/angles.dart';
import '../../../core/sensor_view_model.dart';

@immutable
class AngleState {
  const AngleState({
    required this.tilt,
    required this.rotation,
    this.moved,
    this.forwardBack,
    this.leftRight,
    this.screenRotation,
    this.turn,
  });

  /// Angle of the screen from horizontal (0° flat, 90° upright).
  final double tilt;

  /// Rotation in the screen plane relative to gravity, null when flat.
  final double? rotation;

  /// Since "Set zero": total angle moved, null when not zeroed.
  final double? moved;

  /// Since "Set zero": rotation about each screen axis, null when that axis
  /// is too close to vertical to measure it.
  final double? forwardBack, leftRight, screenRotation;

  /// Since "Set zero": turn about the vertical (compass) axis, null without a
  /// reliable magnetometer.
  final double? turn;

  bool get zeroed => moved != null;
}

class AngleViewModel extends SensorViewModel {
  AngleViewModel({
    required OrientationRepository orientation,
    required this._settings,
  }) : super(orientation);

  final SettingsRepository _settings;
  Vec3? _zeroGravity;
  double? _zeroHeading;
  LevelMode _zeroMode = LevelMode.flat;
  LevelMode _mode = LevelMode.flat;
  AngleState? _state;

  AngleState? get state => _state;

  void setZero() {
    final g = reading.gravity;
    if (g == null) return;
    _zeroGravity = g;
    _zeroMode = _mode;
    _zeroHeading = _deviceHeading(_mode);
    update();
  }

  void clearZero() {
    _zeroGravity = null;
    _zeroHeading = null;
    update();
  }

  /// Heading of a device-fixed axis, so the turn doesn't jump when the UI
  /// rotates. Null without a trustworthy magnetometer.
  double? _deviceHeading(LevelMode mode) => reading.magneticReliable
      ? reading.heading(flat: mode == LevelMode.flat, screen: false)
      : null;

  @override
  void update() {
    _state = _compute();
    notifyListeners();
  }

  AngleState? _compute() {
    final g = reading.gravity, gs = reading.screenGravity;
    if (g == null || gs == null) return null;
    // "From level" honours the Level tab's flat calibration.
    final tilt = tiltDeg(rotateFromTo(g, _settings.flatRef, Vec3.up));
    _mode = nextMode(_mode, tilt);
    final rotation = planeAngleDeg(gs.x, gs.y);

    final g0 = _zeroGravity;
    if (g0 == null) return AngleState(tilt: tilt, rotation: rotation);

    final g0s = deviceToScreen(g0, reading.quarterTurns);
    final h0 = _zeroHeading;
    final h = _mode == _zeroMode ? _deviceHeading(_mode) : null;
    return AngleState(
      tilt: tilt,
      rotation: rotation,
      moved: angleBetweenDeg(g0, g),
      forwardBack: axisDeltaDeg(g0s, gs, DeviceAxis.x),
      leftRight: axisDeltaDeg(g0s, gs, DeviceAxis.y),
      screenRotation: axisDeltaDeg(g0s, gs, DeviceAxis.z),
      turn: h0 == null || h == null ? null : wrap180(h - h0),
    );
  }
}
