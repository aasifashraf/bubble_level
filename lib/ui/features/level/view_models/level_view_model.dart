import 'dart:math' as math;
import 'dart:ui' show Offset;

import 'package:flutter/foundation.dart';

import '../../../../data/repositories/orientation_repository.dart';
import '../../../../data/repositories/settings_repository.dart';
import '../../../../domain/angles.dart';
import '../../../../domain/status.dart';
import '../../../core/sensor_view_model.dart';

enum CalibrationResult { done, notLevel, noData }

@immutable
class LevelState {
  const LevelState.flat({
    required this.angle,
    required this.roll,
    required this.pitch,
    required this.bubble,
    required this.status,
  }) : mode = LevelMode.flat,
       deviation = 0,
       quadrant = 0;

  const LevelState.edge({
    required this.deviation,
    required this.quadrant,
    required this.status,
  }) : mode = LevelMode.edge,
       angle = deviation < 0 ? -deviation : deviation,
       roll = 0,
       pitch = 0,
       bubble = Offset.zero;

  final LevelMode mode;

  /// Main reading in degrees ≥ 0: total tilt when flat, distance from the
  /// nearest level/plumb line when on an edge.
  final double angle;

  /// Flat only: left/right and forward/back tilt.
  final double roll, pitch;

  /// Flat only: bubble position, each axis in [-1, 1].
  final Offset bubble;

  /// Edge only: signed deviation from the [quadrant] (multiple of 90°).
  final double deviation;
  final int quadrant;

  final Status status;

  bool get isLevel => status == Status.level;
}

class LevelViewModel extends SensorViewModel {
  LevelViewModel({
    required OrientationRepository orientation,
    required this._settings,
    required this._onLevelReached,
    this._onChime = _silent,
    this._onSuccess = _silent,
  }) : super(orientation) {
    _settings.addListener(_onSettingsChanged);
  }

  /// Within this many degrees counts as level.
  static const tolerance = 0.5;

  /// Within this many degrees counts as nearly level.
  static const nearTolerance = 2.0;

  /// Once level, it must drift this much further before it counts as off
  /// level again, so sensor noise at the boundary doesn't flicker or buzz.
  static const hysteresis = 0.2;

  /// Tilt at which the bubble reaches the rim.
  static const bubbleRange = 10.0;

  /// Calibration is refused if the phone is further than this from level.
  static const maxCalibrationError = 5.0;

  final SettingsRepository _settings;
  final void Function() _onLevelReached;

  /// Plays the "level" chime.
  final void Function() _onChime;

  /// The level was reached: counts toward asking for a store review.
  final void Function() _onSuccess;

  static void _silent() {}

  LevelMode _mode = LevelMode.flat;
  int _quadrant = 0;
  bool _held = false;
  bool _wasLevel = false;
  LevelState? _state;

  LevelState? get state => _state;
  bool get held => _held;
  AngleUnit get unit => _settings.unit;

  /// Dial or tube, remembered across launches.
  LevelStyle get style => _settings.levelStyle;

  void setStyle(LevelStyle style) {
    _settings.setLevelStyle(style);
    notifyListeners();
  }

  void toggleHold() {
    _held = !_held;
    update();
  }

  void _onSettingsChanged() {
    if (active) update();
  }

  @override
  void update() {
    if (!_held) _state = _compute();
    final level = _state?.isLevel ?? false;
    // Once per arrival at level (with hysteresis), never while held.
    if (level && !_wasLevel && !_held) {
      if (_settings.haptics) _onLevelReached();
      if (_settings.sounds) _onChime();
      _onSuccess();
    }
    _wasLevel = level;
    notifyListeners();
  }

  Status _status(double angle) =>
      angle < (_wasLevel ? tolerance + hysteresis : tolerance)
      ? Status.level
      : angle < nearTolerance
      ? Status.near
      : Status.off;

  LevelState? _compute() {
    final g = reading.gravity;
    if (g == null) return null;
    _mode = nextMode(_mode, tiltDeg(g));

    if (_mode == LevelMode.flat) {
      final gs = deviceToScreen(
        rotateFromTo(g, _settings.flatRef, Vec3.up),
        reading.quarterTurns,
      );
      final tilt = tiltDeg(gs);
      // The bubble floats toward the high side: the horizontal part of "up".
      final high = Offset(gs.x, -gs.y);
      final bubble = high.distance == 0
          ? Offset.zero
          : high / high.distance * math.min(1, tilt / bubbleRange);
      return LevelState.flat(
        angle: tilt,
        roll: rollDeg(gs),
        pitch: pitchDeg(gs),
        bubble: bubble,
        status: _status(tilt),
      );
    }

    final edge = wrap180(
      edgeDeg(reading.screenGravity!) - _settings.edgeOffset,
    );
    _quadrant = nextQuadrant(_quadrant, edge);
    final deviation = wrap180(edge - _quadrant);
    return LevelState.edge(
      deviation: deviation,
      quadrant: _quadrant,
      status: _status(deviation.abs()),
    );
  }

  /// Treats the current position as perfectly level for the current mode.
  /// Releases Hold first so the mode and quadrant reflect the live position.
  Future<CalibrationResult> calibrate() async {
    final g = reading.gravity;
    if (g == null) return CalibrationResult.noData;
    _held = false;
    _state = _compute();
    if (_mode == LevelMode.flat) {
      if (tiltDeg(g) > maxCalibrationError) {
        update();
        return CalibrationResult.notLevel;
      }
      await _settings.calibrateFlat(g);
    } else {
      final offset = wrap180(edgeDeg(reading.screenGravity!) - _quadrant);
      if (offset.abs() > maxCalibrationError) {
        update();
        return CalibrationResult.notLevel;
      }
      await _settings.calibrateEdge(offset);
    }
    return CalibrationResult.done;
  }

  @override
  void dispose() {
    _settings.removeListener(_onSettingsChanged);
    super.dispose();
  }
}
