import 'dart:math' as math;

import 'package:bubble_level/domain/angles.dart';
import 'package:bubble_level/domain/vibration_frequency.dart';
import 'package:flutter_test/flutter_test.dart';

/// [seconds] of a vibration sampled at [rate] Hz: [shake] gives the
/// acceleration at a time, plus a little deterministic sensor noise.
FrequencyAnalyzer _record(
  Vec3 Function(double t) shake, {
  double rate = 200,
  double seconds = 3,
  double noise = 0.01,
  double jitter = 0,
}) {
  final a = FrequencyAnalyzer();
  final random = math.Random(7);
  for (var i = 0; i < seconds * rate; i++) {
    final t = i / rate + (random.nextDouble() - 0.5) * jitter;
    double n() => (random.nextDouble() - 0.5) * 2 * noise;
    a.add(shake(t) + Vec3(n(), n(), n()), t);
  }
  return a;
}

void main() {
  test('finds a motor\'s frequency, between the FFT bins', () {
    for (final hz in [7.3, 24.0, 61.7, 88.0]) {
      final s = _record((t) => Vec3(0, 0.5 * math.sin(2 * math.pi * hz * t), 0))
          .analyze()!;
      expect(s.peakHz, closeTo(hz, 0.1), reason: '$hz Hz');
      expect(s.rpm, closeTo(hz * 60, 6));
    }
  });

  test('works whichever way it shakes, and with uneven sample times', () {
    final s = _record(
      (t) =>
          const Vec3(0.6, 0.3, 0.74) * (0.4 * math.sin(2 * math.pi * 33 * t)),
      jitter: 0.0015,
    ).analyze()!;
    expect(s.peakHz, closeTo(33, 0.15));
  });

  test('the strongest of several frequencies wins', () {
    final s = _record(
      (t) => Vec3(
        0.2 * math.sin(2 * math.pi * 12 * t),
        0.6 * math.sin(2 * math.pi * 47 * t),
        0,
      ),
    ).analyze()!;
    expect(s.peakHz, closeTo(47, 0.1));
    // The spectrum shows both, strongest at 1.
    double at(double hz) => s.levels[(hz / s.step).round()];
    expect(at(47), greaterThan(0.9));
    expect(at(12), greaterThan(0.2));
  });

  test('no clear frequency in noise, or below the sensor noise', () {
    expect(
      _record((t) => const Vec3(0, 0, 0), noise: 0.3).analyze()!.peakHz,
      isNull,
    );
    expect(
      _record(
        (t) => Vec3(0.004 * math.sin(2 * math.pi * 20 * t), 0, 0),
        noise: 0.001,
      ).analyze()!.peakHz,
      isNull,
    );
  });

  test('the limit follows the sampling rate, at most 100 Hz', () {
    final slow = _record(
      (t) => Vec3(0.5 * math.sin(2 * math.pi * 10 * t), 0, 0),
      rate: 50,
    ).analyze()!;
    expect(slow.maxHz, closeTo(22.5, 0.5));
    expect(slow.peakHz, closeTo(10, 0.15));
    final fast = _record((t) => const Vec3(0, 0, 0), rate: 500).analyze()!;
    expect(fast.maxHz, FrequencyAnalyzer.ceiling);
  });

  test('waits for most of a window, and starts again on clear', () {
    final a = _record(
      (t) => Vec3(0.5 * math.sin(2 * math.pi * 20 * t), 0, 0),
      seconds: 1,
    );
    expect(a.analyze(), isNull);
    final b = _record((t) => Vec3(0.5 * math.sin(2 * math.pi * 20 * t), 0, 0));
    expect(b.analyze(), isNotNull);
    b.clear();
    expect(b.analyze(), isNull);
  });

  test('below 3 Hz is ignored: hand movement, not a machine', () {
    final s = _record((t) => Vec3(2 * math.sin(2 * math.pi * 1.2 * t), 0, 0))
        .analyze()!;
    expect(s.peakHz, isNull);
  });
}
