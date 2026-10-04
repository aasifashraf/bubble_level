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

    test('clamps long gaps (e.g. after a pause)', () {
      filter
        ..addAccel(const Vec3(0, 0, 9.81), 0)
        ..addAccel(const Vec3(0, 9.81, 0), 1000);
      // One clamped 0.1 s step, not a jump straight to the new value.
      expect(tiltDeg(filter.value!), lessThan(60));
    });
  });

  test('VectorLowPass smooths toward the input', () {
    final f = VectorLowPass(0.25)..add(const Vec3(0, 0, 0), 0);
    f.add(const Vec3(10, 0, 0), 0.25);
    expect(f.value!.x, closeTo(5, 1e-9));
  });
}
