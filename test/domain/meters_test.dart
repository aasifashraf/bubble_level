import 'package:bubble_level/domain/angles.dart';
import 'package:bubble_level/domain/barometer.dart';
import 'package:bubble_level/domain/sensor_filters.dart';
import 'package:bubble_level/domain/vibration.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('VibrationMeter', () {
    test('tracks current magnitude and peak', () {
      final m = VibrationMeter()
        ..add(const Vec3(3, 4, 0), 0)
        ..add(const Vec3(0, 0, 1), 0.02);
      expect(m.current, closeTo(1, 1e-9));
      expect(m.peak, closeTo(5, 1e-9));
    });

    test('RMS covers only the last window', () {
      final m = VibrationMeter()..add(const Vec3(10, 0, 0), 0);
      for (var i = 1; i <= 100; i++) {
        m.add(const Vec3(2, 0, 0), 1 + i * 0.02);
      }
      // The 10 m/s² spike is older than a second and no longer counts.
      expect(m.rms, closeTo(2, 1e-9));
    });

    test('history is bounded and oldest-first', () {
      final m = VibrationMeter(historyLength: 3);
      for (var i = 1; i <= 5; i++) {
        m.add(Vec3(i.toDouble(), 0, 0), i * 0.02);
      }
      expect(m.history, [3, 4, 5]);
    });

    test('reset peak starts again from the current value', () {
      final m = VibrationMeter()
        ..add(const Vec3(9, 0, 0), 0)
        ..add(const Vec3(1, 0, 0), 0.02)
        ..resetPeak();
      expect(m.peak, closeTo(1, 1e-9));
    });
  });

  group('barometer', () {
    test('standard pressure is sea level', () {
      expect(altitudeFromPressure(standardPressure), closeTo(0, 1e-9));
    });

    test('about 8 m per hPa near sea level, and known reference points', () {
      expect(
        altitudeFromPressure(1012.25) - altitudeFromPressure(1013.25),
        closeTo(8.4, 0.3),
      );
      // ISA: ~899 hPa at 1000 m.
      expect(altitudeFromPressure(898.75), closeTo(1000, 5));
    });

    test('ScalarLowPass smooths toward the input', () {
      final f = ScalarLowPass(0.5)..add(1000, 0);
      f.add(1010, 0.5);
      expect(f.value, closeTo(1005, 1e-9));
    });
  });
}
