import 'dart:math' as math;
import 'dart:typed_data';

import 'package:bubble_level/domain/sound.dart';
import 'package:flutter_test/flutter_test.dart';

/// [samples] of 16-bit little-endian PCM.
Uint8List pcm(Iterable<int> samples) {
  final data = ByteData(samples.length * 2);
  var i = 0;
  for (final s in samples) {
    data.setInt16(i, s, Endian.little);
    i += 2;
  }
  return data.buffer.asUint8List();
}

void main() {
  group('PCM blocks', () {
    test('a full-scale sine has a mean square of ½ (−3 dBFS)', () {
      final blocks = Pcm16Blocks(4410);
      final sine = [
        for (var n = 0; n < 4410; n++)
          (32767 * math.sin(2 * math.pi * 1000 * n / 44100)).round(),
      ];
      final out = blocks.add(pcm(sine));
      expect(out.single, closeTo(0.5, 0.001));
      expect(soundDb(out.single), closeTo(fullScaleDb - 3.01, 0.05));
    });

    test('silence reads at the floor, never minus infinity', () {
      final out = Pcm16Blocks(100).add(pcm(List.filled(100, 0)));
      expect(out.single, 0);
      expect(soundDb(0), floorDb);
    });

    test('chunks split anywhere, even mid-sample, add up to whole blocks', () {
      final blocks = Pcm16Blocks(4);
      final bytes = pcm([16384, -16384, 16384, -16384, 0, 0, 0, 0]);
      final out = [
        ...blocks.add(bytes.sublist(0, 3)),
        ...blocks.add(bytes.sublist(3, 9)),
        ...blocks.add(bytes.sublist(9)),
      ];
      expect(out, [closeTo(0.25, 1e-9), 0]);
    });
  });

  group('meter', () {
    /// Mean square for a level of [db].
    double ms(double db) => math.pow(10, (db - fullScaleDb) / 10).toDouble();

    test('keeps the last three seconds of levels for the bars', () {
      final m = SoundMeter();
      for (var i = 0; i < 40; i++) {
        m.add(ms(40), 0.1);
      }
      expect(m.history, hasLength(SoundMeter.historyLength));
      expect(m.history.last, closeTo(40, 1e-9));
      m.reset();
      expect(m.history, isNotEmpty, reason: 'Reset keeps the picture');
      m.clear();
      expect(m.history, isEmpty);
    });

    test('Slow weighting settles in about a second', () {
      final m = SoundMeter()..add(ms(40), 0.1);
      expect(m.level, closeTo(40, 1e-9));
      // A step up to 80 dB: not there after 0.1 s, nearly after 3 s.
      m.add(ms(80), 0.1);
      expect(m.level, lessThan(72));
      for (var i = 0; i < 30; i++) {
        m.add(ms(80), 0.1);
      }
      expect(m.level, closeTo(80, 0.5));
    });

    test('Max catches a short loud sound; Average is the energy mean', () {
      final m = SoundMeter();
      for (var i = 0; i < 10; i++) {
        m.add(ms(50), 0.1);
      }
      // A 0.3 s clap at 90 dB.
      for (var i = 0; i < 3; i++) {
        m.add(ms(90), 0.1);
      }
      expect(m.max, greaterThan(85));
      expect(m.level, lessThan(m.max!));
      // Energy mean of 1 s at 50 dB and 0.3 s at 90 dB.
      final leq =
          fullScaleDb +
          10 * math.log((1.0 * ms(50) + 0.3 * ms(90)) / 1.3) / math.ln10;
      expect(m.average, closeTo(leq, 1e-6));
    });

    test('Reset restarts Max and Average; clear forgets everything', () {
      final m = SoundMeter()..add(ms(90), 0.5);
      // Quiet for 6 s, in the service's 100 ms blocks.
      for (var i = 0; i < 60; i++) {
        m.add(ms(40), 0.1);
      }
      expect(m.max, closeTo(90, 0.1));
      m.reset();
      // Max restarts from the Fast level (quiet by now); the Slow level is
      // still falling (about 4.3 dB a second after a 50 dB drop).
      expect(m.max, closeTo(40, 0.5));
      expect(m.level, greaterThan(50));
      m.add(ms(40), 0.1);
      expect(m.average, closeTo(40, 1e-6));
      m.clear();
      expect(m.level, isNull);
    });
  });

  test('bands, and from 85 dB a hearing warning', () {
    expect(SoundBand.of(25), SoundBand.veryQuiet);
    expect(SoundBand.of(45), SoundBand.quiet);
    expect(SoundBand.of(60), SoundBand.moderate);
    expect(SoundBand.of(80), SoundBand.loud);
    expect(SoundBand.of(80).harmful, isFalse);
    expect(SoundBand.of(85), SoundBand.veryLoud);
    expect(SoundBand.of(85).harmful, isTrue);
    expect(SoundBand.of(105), SoundBand.dangerous);
  });

  test('on a boundary the band holds until clearly past it', () {
    // Moderate, then hovering around 70 dB: still moderate.
    var band = SoundBand.settle(null, 65);
    for (final db in [70.4, 69.2, 71.0, 69.8, 70.9]) {
      band = SoundBand.settle(band, db);
      expect(band, SoundBand.moderate, reason: '$db dB');
    }
    band = SoundBand.settle(band, 71.6);
    expect(band, SoundBand.loud);
    // And back down: loud until clearly under.
    expect(SoundBand.settle(band, 69), SoundBand.loud);
    expect(SoundBand.settle(band, 68.4), SoundBand.moderate);
    // A big jump goes straight there.
    expect(SoundBand.settle(SoundBand.quiet, 95), SoundBand.veryLoud);
  });
}
