import 'dart:collection';
import 'dart:math' as math;

import 'package:flutter/foundation.dart';

import 'angles.dart';
import 'orientation_reading.dart';

/// A snapshot of the vibration meter.
@immutable
class VibrationReading {
  const VibrationReading({
    this.current = 0,
    this.peak = 0,
    this.rms = 0,
    this.history = const [],
    this.state = SensorState.waiting,
  });

  /// Magnitude of the latest acceleration without gravity, m/s².
  final double current;

  /// Largest [current] since the last reset, m/s².
  final double peak;

  /// Root mean square over about the last second, m/s².
  final double rms;

  /// Recent magnitudes, oldest first, for the live graph.
  final List<double> history;

  final SensorState state;
}

/// Accumulates linear-acceleration samples into current, peak, RMS and a
/// short history.
class VibrationMeter {
  VibrationMeter({this.window = 1.0, this.historyLength = 150});

  /// Seconds the RMS averages over.
  final double window;
  final int historyLength;

  final _recent = Queue<(double, double)>(); // (seconds, magnitude²)
  final _history = Queue<double>();
  double _sumSquares = 0;
  double _current = 0;
  double _peak = 0;

  double get current => _current;
  double get peak => _peak;
  double get rms => _recent.isEmpty
      ? 0
      : math.sqrt(math.max(0, _sumSquares) / _recent.length);
  List<double> get history => List.unmodifiable(_history);

  void add(Vec3 acceleration, double seconds) {
    final m = acceleration.length;
    _current = m;
    _peak = math.max(_peak, m);
    _recent.addLast((seconds, m * m));
    _sumSquares += m * m;
    while (_recent.isNotEmpty && seconds - _recent.first.$1 > window) {
      _sumSquares -= _recent.removeFirst().$2;
    }
    _history.addLast(m);
    while (_history.length > historyLength) {
      _history.removeFirst();
    }
  }

  void resetPeak() => _peak = _current;
}
