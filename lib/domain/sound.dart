import 'dart:collection';
import 'dart:math' as math;

import 'package:flutter/foundation.dart';

import 'orientation_reading.dart';

/// Phone microphones aren't calibrated; full scale reads roughly this many
/// decibels of sound pressure, a common estimate for phone sound meters.
const fullScaleDb = 90.0;

/// The quietest level shown: below this a phone microphone hears only its
/// own noise.
const floorDb = 20.0;

/// Estimated sound level, dB, for a mean square of samples on a 0–1 scale.
double soundDb(double meanSquare) => meanSquare <= 0
    ? floorDb
    : math.max(floorDb, fullScaleDb + 10 * math.log(meanSquare) / math.ln10);

/// Splits 16-bit little-endian mono PCM into blocks of [samplesPerBlock]
/// and gives each block's mean square (0 silence, 1 full scale). Bytes that
/// don't make up a whole block wait for the next chunk.
class Pcm16Blocks {
  Pcm16Blocks(this.samplesPerBlock);

  final int samplesPerBlock;
  double _sum = 0;
  int _count = 0;
  int? _lowByte;

  /// Mean squares of the blocks completed by [bytes].
  List<double> add(Uint8List bytes) {
    final done = <double>[];
    for (final b in bytes) {
      final low = _lowByte;
      if (low == null) {
        _lowByte = b;
        continue;
      }
      _lowByte = null;
      var v = low | (b << 8);
      if (v >= 0x8000) v -= 0x10000;
      final x = v / 32768;
      _sum += x * x;
      if (++_count == samplesPerBlock) {
        done.add(_sum / _count);
        _sum = 0;
        _count = 0;
      }
    }
    return done;
  }
}

/// A sound level meter's three readings from blocks of microphone energy:
/// the level with Slow time weighting (1 s, steady enough to read), the
/// maximum with Fast weighting (125 ms, catches claps), and the average
/// (energy mean, Leq) since the last reset. Energy, not decibels, is
/// averaged, as sound meters do.
class SoundMeter {
  static const slowTau = 1.0, fastTau = 0.125;

  /// How many levels [history] keeps (3 s of 100 ms blocks).
  static const historyLength = 30;

  double? _slow, _fast;
  double _maxFast = 0, _energy = 0, _time = 0;
  final _history = Queue<double>();

  /// Adds a block's mean square that lasted [seconds].
  void add(double meanSquare, double seconds) {
    if (seconds <= 0) return;
    double step(double? v, double tau) {
      if (v == null) return meanSquare;
      final k = 1 - math.exp(-seconds / tau);
      return v + (meanSquare - v) * k;
    }

    _slow = step(_slow, slowTau);
    _fast = step(_fast, fastTau);
    _maxFast = math.max(_maxFast, _fast!);
    _energy += meanSquare * seconds;
    _time += seconds;
    _history.addLast(soundDb(_slow!));
    while (_history.length > historyLength) {
      _history.removeFirst();
    }
  }

  /// Forgets everything, for a fresh start.
  void clear() {
    _slow = _fast = null;
    _maxFast = _energy = _time = 0;
    _history.clear();
  }

  /// Starts Max and Average again; the level carries on.
  void reset() {
    _maxFast = _fast ?? 0;
    _energy = 0;
    _time = 0;
  }

  double? get level => _slow == null ? null : soundDb(_slow!);
  double? get max => _slow == null ? null : soundDb(_maxFast);
  double? get average => _time == 0 ? level : soundDb(_energy / _time);

  /// The level after each recent block, oldest first.
  List<double> get history => List.unmodifiable(_history);
}

/// From here sound is moderate (a conversation).
const moderateDb = 50.0;

/// From here sound is loud (busy traffic); take care.
const loudDb = 70.0;

/// From here long exposure can harm hearing (85 dB over a working day is
/// the usual limit).
const harmfulDb = 85.0;

/// From here sound is dangerous: protect your ears.
const dangerousDb = 100.0;

/// What a level is like, and when it starts to harm hearing.
enum SoundBand {
  veryQuiet,
  quiet,
  moderate,
  loud,
  veryLoud,
  dangerous;

  static SoundBand of(double db) => switch (db) {
    < 30 => veryQuiet,
    < moderateDb => quiet,
    < loudDb => moderate,
    < harmfulDb => loud,
    < dangerousDb => veryLoud,
    _ => dangerous,
  };

  /// The band for [db] after [previous]: it changes only once the level is
  /// clearly past the edge ([margin] dB), so a level sitting on a boundary
  /// doesn't flicker between two descriptions.
  static SoundBand settle(
    SoundBand? previous,
    double db, {
    double margin = 1.5,
  }) {
    final now = of(db);
    if (previous == null || now == previous) return now;
    final up = now.index > previous.index;
    return of(up ? db - margin : db + margin) == previous ? previous : now;
  }

  bool get harmful => index >= veryLoud.index;
}

/// A snapshot of the sound meter.
@immutable
class SoundReading {
  const SoundReading({
    this.level,
    this.max,
    this.average,
    this.history = const [],
    this.state = SensorState.waiting,
  });

  /// Slow-weighted level, estimated dB.
  final double? level;
  final double? max, average;

  /// The last few seconds of levels, oldest first.
  final List<double> history;
  final SensorState state;
}
