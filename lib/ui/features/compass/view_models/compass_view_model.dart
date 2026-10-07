import 'package:flutter/foundation.dart';

import '../../../../data/repositories/orientation_repository.dart';
import '../../../../domain/angles.dart';
import '../../../../domain/magnetic_check.dart';
import '../../../core/sensor_view_model.dart';

@immutable
class CompassState {
  const CompassState({
    required this.heading,
    required this.flat,
    required this.fieldOk,
    required this.calibrated,
  });

  /// Magnetic heading in [0, 360).
  final double heading;

  /// True: heading of the top edge (phone flat). False: of the back camera.
  final bool flat;

  /// False when the field is far from the Earth's: metal or a magnet
  /// nearby, or a calibration thrown off by one.
  final bool fieldOk;

  /// False while the system asks for the magnetometer to be calibrated,
  /// or the field's strength swings as the phone turns (see
  /// [MagneticCheck]): either way, a figure 8 fixes it.
  final bool calibrated;

  /// Whether the heading can be trusted.
  bool get reliable => fieldOk && calibrated;

  /// Compass sector 0 to 7 (N, NE, … NW).
  int get sector => cardinalSector(heading);
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

  final _check = MagneticCheck();
  LevelMode _mode = LevelMode.flat;
  CompassState? _state;

  CompassState? get state => _state;

  /// A fresh judgement each time the compass opens.
  @override
  void onActivate() => _check.clear();

  @override
  void update() {
    _state = _compute();
    notifyListeners();
  }

  CompassState? _compute() {
    final g = reading.gravity;
    if (g == null) return null;
    _mode = nextMode(_mode, tiltDeg(g));
    final flat = _mode == LevelMode.flat;
    final heading = reading.heading(flat: flat);
    if (heading == null) return null;
    final field = reading.magnetic;
    if (field != null) {
      _check.add(field, heading, _clock().inMicroseconds / 1e6);
    }
    return CompassState(
      heading: heading,
      flat: flat,
      fieldOk: reading.magneticFieldOk,
      calibrated: reading.magneticCalibrated && _check.consistent != false,
    );
  }
}
