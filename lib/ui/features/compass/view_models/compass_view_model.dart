import 'package:flutter/foundation.dart';

import '../../../../data/repositories/orientation_repository.dart';
import '../../../../domain/angles.dart';
import '../../../core/sensor_view_model.dart';

@immutable
class CompassState {
  const CompassState({
    required this.heading,
    required this.flat,
    required this.reliable,
  });

  /// Magnetic heading in [0, 360).
  final double heading;

  /// True: heading of the top edge (phone flat). False: of the back camera.
  final bool flat;

  /// False when the magnetic field looks disturbed or uncalibrated.
  final bool reliable;

  /// Compass sector 0–7 (N, NE, … NW).
  int get sector => cardinalSector(heading);
}

class CompassViewModel extends SensorViewModel {
  CompassViewModel({required OrientationRepository orientation})
    : super(orientation);

  LevelMode _mode = LevelMode.flat;
  CompassState? _state;

  CompassState? get state => _state;

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
    return CompassState(
      heading: heading,
      flat: flat,
      reliable: reading.magneticReliable,
    );
  }
}
