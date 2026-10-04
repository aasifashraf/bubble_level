import 'dart:typed_data';

import 'package:bubble_level/domain/tone.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('wavTone', () {
    final wav = wavTone(const [
      (hz: 880, seconds: 0.1),
      (hz: 1320, seconds: 0.1),
    ]);
    final data = ByteData.sublistView(wav);
    String ascii(int at) => String.fromCharCodes(wav.sublist(at, at + 4));

    test('is a 16-bit mono 44.1 kHz WAV of the right length', () {
      expect(ascii(0), 'RIFF');
      expect(ascii(8), 'WAVE');
      expect(ascii(36), 'data');
      expect(data.getUint16(22, Endian.little), 1); // mono
      expect(data.getUint32(24, Endian.little), 44100);
      expect(data.getUint16(34, Endian.little), 16);
      // 0.2 s of 2-byte samples.
      expect(data.getUint32(40, Endian.little), 8820 * 2);
      expect(wav.length, 44 + 8820 * 2);
    });

    test('fades in and out (no click) and stays within the volume', () {
      int sample(int i) => data.getInt16(44 + i * 2, Endian.little);
      final count = (wav.length - 44) ~/ 2;
      expect(sample(0).abs(), lessThan(200));
      expect(sample(count - 1).abs(), lessThan(200));
      var peak = 0;
      for (var i = 0; i < count; i++) {
        if (sample(i).abs() > peak) peak = sample(i).abs();
      }
      expect(peak, lessThanOrEqualTo(0.5 * 32767 + 1));
      expect(peak, greaterThan(0.3 * 32767));
    });
  });
}
