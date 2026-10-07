import 'dart:math' as math;

import 'package:bubble_level/domain/angles.dart';
import 'package:bubble_level/domain/height.dart';
import 'package:flutter_test/flutter_test.dart';

Vec3 _pitched(double deg) {
  final r = deg * math.pi / 180;
  return Vec3(0, math.sin(r), math.cos(r));
}

void main() {
  test('sight angle is the top edge above or below level', () {
    expect(sightAngleDeg(_pitched(0)), closeTo(0, 1e-9));
    expect(sightAngleDeg(_pitched(30)), closeTo(30, 1e-9));
    expect(sightAngleDeg(_pitched(-12)), closeTo(-12, 1e-9));
    // Rolling the phone about the top edge doesn't change it.
    final r = 30 * math.pi / 180;
    expect(
      sightAngleDeg(Vec3(0.6 * math.cos(r), math.sin(r), 0.8 * math.cos(r))),
      closeTo(30, 1e-6),
    );
    // Upright, the top edge points at the sky: not a sight line.
    expect(sightAngleDeg(_pitched(85)), isNull);
    expect(sightAngleDeg(_pitched(-85)), isNull);
  });

  test('distance from the eye height and the angle down to the base', () {
    expect(distanceToBase(1.6, -45), closeTo(1.6, 1e-9));
    expect(distanceToBase(1.6, -6), closeTo(15.223, 1e-3));
    // At or above level, or too shallow to tell distances apart.
    expect(distanceToBase(1.6, 2), isNull);
    expect(distanceToBase(1.6, -minBaseAngle + 0.1), isNull);
    expect(distanceToBase(0, -10), isNull);
  });

  test('height is the eye height plus the rise to the top', () {
    expect(heightOf(1.6, 10, 45), closeTo(11.6, 1e-9));
    expect(heightOf(1.6, 10, 0), closeTo(1.6, 1e-9));
    // A top below eye level (a low wall).
    expect(
      heightOf(1.6, 10, -5),
      closeTo(1.6 - 10 * math.tan(5 * math.pi / 180), 1e-9),
    );
    // Below the ground, or no distance.
    expect(heightOf(1.6, 10, -20), isNull);
    expect(heightOf(1.6, 0, 30), isNull);
  });

  test('advice', () {
    expect(adviseBase(-10), SightAdvice.ok);
    expect(adviseBase(-1), SightAdvice.tooFar);
    expect(adviseTop(40), SightAdvice.ok);
    expect(adviseTop(75), SightAdvice.stepBack);
  });

  test('median', () {
    expect(median([]), isNull);
    expect(median([3, 1, 2]), 2);
    expect(median([4, 1, 3, 2]), 2.5);
    // A tap's jolt at the end doesn't move it.
    expect(median([10, 10.1, 9.9, 10, 30]), 10);
  });
}
