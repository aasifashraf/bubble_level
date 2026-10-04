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

/// How suitable light is for reading and desk work, for the dial's
/// colours: too dark below [tooDarkLux], dim below [readingLux], good up to
/// [glareLux], then glare.
const tooDarkLux = 50.0, readingLux = 300.0, glareLux = 10000.0;

/// Where [lux] sits on the dial: 60° per tenfold, from 1 lx at the top to
/// 100 000 lx at 300°, so dim rooms and sunlight both fit.
double lightSweep(double lux) {
  final decades = math.log(math.max(lux, 1)) / math.ln10;
  return (decades * 60).clamp(0.0, 359.9);
}

/// A snapshot of the light sensor.
@immutable
class LightReading {
  const LightReading({this.lux, this.state = SensorState.waiting});

  /// Illuminance on the screen, lux.
  final double? lux;
  final SensorState state;

  double? get footCandles => lux == null ? null : lux! / luxPerFootCandle;
}
