import 'dart:math' as math;

import 'package:bubble_level/domain/angles.dart';
import 'package:bubble_level/domain/sensor_filters.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('GravityFilter', () {
    late GravityFilter filter;

    setUp(() => filter = GravityFilter());

    test('starts empty and takes the first accelerometer sample as-is', () {
      expect(filter.value, isNull);
      filter.addAccel(const Vec3(0, 0, 9.81), 0);
      expect(filter.value!.z, closeTo(1, 1e-9));
    });

    test('integrates gyroscope rotation (top edge raised)', () {
      filter.addAccel(const Vec3(0, 0, 9.81), 0);
      // 1 rad/s about +x for 0.1 s.
      for (var i = 0; i <= 10; i++) {
        filter.addGyro(const Vec3(1, 0, 0), i * 0.01);
      }
      expect(pitchDeg(filter.value!), closeTo(0.1 * 180 / math.pi, 0.1));
    });

    test('without a gyroscope, converges to the accelerometer', () {
      filter.addAccel(const Vec3(0, 0, 9.81), 0);
      for (var i = 1; i <= 100; i++) {
        filter.addAccel(const Vec3(0, 9.81, 0), i * 0.02);
      }
      expect(tiltDeg(filter.value!), closeTo(90, 0.5));
    });

    test('with a gyroscope, mostly ignores shaking', () {
      filter
        ..addAccel(const Vec3(0, 0, 9.81), 0)
        ..addGyro(Vec3.up * 0, 0);
      // A hard sideways jolt: magnitude far from 1 g.
      for (var i = 1; i <= 5; i++) {
        filter
          ..addGyro(Vec3.up * 0, i * 0.02)
          ..addAccel(const Vec3(20, 0, 9.81), i * 0.02);
      }
      expect(tiltDeg(filter.value!), lessThan(2));
    });

    test(
      'turned face down while the gyroscope missed it: still turns over',
      () {
        filter
          ..addAccel(const Vec3(0, 0, 9.81), 0)
          ..addGyro(const Vec3(0, 0, 0), 0);
        // Exactly opposite: a straight blend would never change direction.
        for (var i = 1; i <= 250; i++) {
          filter
            ..addGyro(const Vec3(0, 0, 0), i * 0.02)
            ..addAccel(const Vec3(0, 0, -9.81), i * 0.02);
        }
        expect(tiltDeg(filter.value!), closeTo(180, 1));
      },
    );

    test('clamps long gaps (e.g. after a pause)', () {
      filter
        ..addAccel(const Vec3(0, 0, 9.81), 0)
        ..addAccel(const Vec3(0, 9.81, 0), 1000);
      // One clamped 0.1 s step, not a jump straight to the new value.
      expect(tiltDeg(filter.value!), lessThan(60));
    });
  });

  group('MagneticFilter', () {
    test('the gyroscope turns it with the phone, at once and at full '
        'strength', () {
      final f = MagneticFilter()
        ..add(const Vec3(0, 30, -40), 0)
        ..addGyro(const Vec3(0, 0, 0), 0);
      // A quarter turn about z in 0.5 s, with no magnetometer sample.
      for (var i = 1; i <= 50; i++) {
        f.addGyro(const Vec3(0, 0, math.pi), i * 0.01);
      }
      // Turning the phone left turns north to its right.
      expect(f.value!.x, closeTo(30, 0.5));
      expect(f.value!.y, closeTo(0, 0.5));
      expect(f.value!.length, closeTo(50, 1e-6));
    });

    test('a jump the gyroscope missed turns it over without shrinking it', () {
      final f = MagneticFilter()..add(const Vec3(0, 30, -40), 0);
      var weakest = double.infinity;
      for (var i = 1; i <= 100; i++) {
        f.add(const Vec3(0, -30, 40), i * 0.02);
        weakest = math.min(weakest, f.value!.length);
      }
      expect(weakest, closeTo(50, 1e-6));
      expect(f.value!.y, closeTo(-30, 0.5));
    });
  });

  test('VectorLowPass smooths toward the input', () {
    final f = VectorLowPass(0.25)..add(const Vec3(0, 0, 0), 0);
    f.add(const Vec3(10, 0, 0), 0.25);
    expect(f.value!.x, closeTo(5, 1e-9));
  });
}
