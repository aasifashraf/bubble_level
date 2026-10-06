import 'dart:math' as math;

import 'package:flutter/foundation.dart';

import 'orientation_reading.dart';

/// Lux per foot-candle (lumens per ft² vs per m²).
const luxPerFootCandle = 10.7639;

/// What a light level is like, from the usual lighting guides: under 10
/// lx is dark, 300–500 lx suits reading and desk work, daylight is tens of
/// thousands.
enum LightBand {
  dark,
  dim,
  livingRoom,
  reading,
  bright,
  overcast,
  daylight,
  sun;

  static LightBand of(double lux) => switch (lux) {
    < 10 => dark,
    < 100 => dim,
    < 300 => livingRoom,
    < 750 => reading,
    < 2000 => bright,
    < 10000 => overcast,
    < 50000 => daylight,
    _ => sun,
  };
}

/// How far the sky has come for [lux], 0 (night, 1 lx or less) to 1
/// (full sun, 100 000 lx): a fifth per tenfold, so dim rooms and sunlight
/// both show.
double skyLevel(double lux) =>
    (math.log(math.max(lux, 1)) / math.ln10 / 5).clamp(0.0, 1.0);

/// A snapshot of the light sensor.
@immutable
class LightReading {
  const LightReading({this.lux, this.state = SensorState.waiting});

  /// Illuminance on the screen, lux.
  final double? lux;
  final SensorState state;

  double? get footCandles => lux == null ? null : lux! / luxPerFootCandle;
}
