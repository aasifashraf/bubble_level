import 'dart:math' as math;
import 'dart:typed_data';

/// One note of a tone: a frequency held for a duration.
typedef Note = ({double hz, double seconds});

/// A soft tone as a 16-bit mono WAV file: each note is a sine with a little
/// second harmonic for warmth, faded in and out so it never clicks.
Uint8List wavTone(List<Note> notes, {double volume = 0.5, int rate = 44100}) {
  final samples = <int>[];
  for (final note in notes) {
    final n = (note.seconds * rate).round();
    // Short attack, longer release: a gentle "pip" rather than a square beep.
    final attack = math.min(n ~/ 4, (0.006 * rate).round());
    final release = math.min(n ~/ 2, (0.04 * rate).round());
    for (var i = 0; i < n; i++) {
      final t = i / rate;
      final envelope = i < attack
          ? i / attack
          : i >= n - release
          ? (n - 1 - i) / release
          : 1.0;
      final wave =
          0.85 * math.sin(2 * math.pi * note.hz * t) +
          0.15 * math.sin(4 * math.pi * note.hz * t);
      samples.add(
        (wave * envelope * volume * 32767).round().clamp(-32768, 32767),
      );
    }
  }

  final data = samples.length * 2;
  final bytes = ByteData(44 + data);
  void ascii(int at, String s) {
    for (var i = 0; i < s.length; i++) {
      bytes.setUint8(at + i, s.codeUnitAt(i));
    }
  }

  ascii(0, 'RIFF');
  bytes.setUint32(4, 36 + data, Endian.little);
  ascii(8, 'WAVE');
  ascii(12, 'fmt ');
  bytes
    ..setUint32(16, 16, Endian.little) // PCM chunk size
    ..setUint16(20, 1, Endian.little) // PCM
    ..setUint16(22, 1, Endian.little) // mono
    ..setUint32(24, rate, Endian.little)
    ..setUint32(28, rate * 2, Endian.little) // byte rate
    ..setUint16(32, 2, Endian.little) // block align
    ..setUint16(34, 16, Endian.little); // bits per sample
  ascii(36, 'data');
  bytes.setUint32(40, data, Endian.little);
  for (final (i, s) in samples.indexed) {
    bytes.setInt16(44 + i * 2, s, Endian.little);
  }
  return bytes.buffer.asUint8List();
}
