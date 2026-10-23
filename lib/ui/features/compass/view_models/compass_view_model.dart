import 'package:flutter/foundation.dart';

import '../../../../data/repositories/orientation_repository.dart';
import '../../../../domain/angles.dart';
import '../../../../domain/magnetic_check.dart';
import '../../../core/sensor_view_model.dart';

@immutable
class CompassState {
  const CompassState({
    required this.heading,
    required this.shown,
    required this.flat,
    required this.fieldOk,
    required this.calibrated,
  });

  /// Magnetic heading in [0, 360).
  final double heading;

  /// The whole degrees to show: [heading] rounded, held until it has
  /// moved clearly past the next degree so the number doesn't flicker.
  final int shown;

  /// True: heading of the top edge. False: of the back camera (the top
  /// edge points up or down, phone upright).
  final bool flat;

  /// False when the field is far from the Earth's (metal or a magnet
  /// nearby, or a calibration it threw off), or so close to vertical that
  /// there's no direction to read from it.
  final bool fieldOk;

  /// False while the system asks for the magnetometer to be calibrated,
  /// or the field's strength swings as the phone turns (see
  /// [MagneticCheck]): either way, a figure 8 fixes it.
  final bool calibrated;

  /// Whether the heading can be trusted.
  bool get reliable => fieldOk && calibrated;

  /// Compass sector 0 to 7 (N, NE, … NW), of the number shown.
  int get sector => cardinalSector(shown.toDouble());
}

class CompassViewModel extends SensorViewModel {
  CompassViewModel({
    required OrientationRepository orientation,
    Duration Function()? clock,
  }) : _clock = clock ?? _running(),
       super(orientation);

  final Duration Function() _clock;

  static Duration Function() _running() {
    final watch = Stopwatch()..start();
    return () => watch.elapsed;
  }

  /// Below this level field (µT) the heading is mostly noise: near the
  /// magnetic poles, or a field bent straight down by a magnet. The
  /// Earth's is 5 to 40 µT nearly everywhere people live.
  static const minLevelField = 4.0;

  /// How far (degrees) the heading must move past the shown number before
  /// it changes.
  static const _hold = 0.75;

  /// How long the system must keep saying "low" accuracy before the
  /// compass asks for a figure 8: many phones say it for a moment as the
  /// compass starts, then settle. "Unreliable" asks at once.
  static const lowFor = Duration(seconds: 3);

  final _check = MagneticCheck();
  LevelMode _mode = LevelMode.flat;
  int? _shown, _accuracy;
  Duration? _lowSince;
  CompassState? _state;

  CompassState? get state => _state;

  /// A fresh start each time the compass opens.
  @override
  void onActivate() {
    _check.clear();
    _mode = LevelMode.flat;
    _shown = _accuracy = null;
    _lowSince = null;
    _state = null;
    orientation.useMagnetometer(true);
  }

  @override
  void onDeactivate() => orientation.useMagnetometer(false);

  @override
  void update() {
    _state = _compute() ?? _state;
    notifyListeners();
  }

  CompassState? _compute() {
    final g = reading.screenGravity, m = reading.magnetic;
    if (g == null) return null;
    // The top edge while it is anywhere near level, as on a map; the back
    // camera only when the top edge points up (phone upright), where it
    // has no direction. Turning the phone onto its side keeps the top edge,
    // so the reading doesn't jump a quarter turn.
    _mode = nextMode(_mode, topEdgeRiseDeg(g));
    final flat = _mode == LevelMode.flat;
    // Null when the field is straight up or down: keep the last state.
    final heading = reading.heading(flat: flat);
    if (heading == null || m == null) return null;
    // The system recalibrated: judge afresh, not against the old samples.
    if (reading.magneticAccuracy != _accuracy) {
      _accuracy = reading.magneticAccuracy;
      _check.clear();
    }
    final now = _clock();
    if (reading.magneticStrength case final strength?) {
      _check.add(strength, heading, now.inMicroseconds / 1e6);
    }
    final low = reading.magneticAccuracy == 1;
    _lowSince = low ? (_lowSince ?? now) : null;
    final systemOk =
        reading.magneticCalibrated || (low && now - _lowSince! < lowFor);
    final shown = _shown;
    if (shown == null || wrap180(heading - shown).abs() > _hold) {
      _shown = heading.round() % 360;
    }
    return CompassState(
      heading: heading,
      shown: _shown!,
      flat: flat,
      fieldOk:
          reading.magneticFieldOk &&
          horizontalField(reading.gravity!, m) >= minLevelField,
      calibrated: systemOk && _check.consistent != false,
    );
  }
}
