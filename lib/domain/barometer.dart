import 'dart:math' as math;

import 'package:flutter/foundation.dart';

import 'orientation_reading.dart';

/// Standard sea-level pressure, hPa.
const standardPressure = 1013.25;

/// Altitude in metres for [pressure] hPa from the international standard
/// atmosphere. Absolute values drift with the weather; differences over
/// minutes are reliable (about 8 m per hPa near sea level).
double altitudeFromPressure(double pressure, {double sea = standardPressure}) =>
    44330 * (1 - math.pow(pressure / sea, 0.1903).toDouble());

/// A snapshot of the barometer.
@immutable
class BarometerReading {
  const BarometerReading({this.pressure, this.state = SensorState.waiting});

  /// Smoothed air pressure, hPa.
  final double? pressure;
  final SensorState state;

  double? get altitude =>
      pressure == null ? null : altitudeFromPressure(pressure!);
}
