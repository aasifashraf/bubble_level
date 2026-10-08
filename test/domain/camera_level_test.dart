import 'dart:math' as math;

import 'package:bubble_level/domain/angles.dart';
import 'package:bubble_level/domain/camera_level.dart';
import 'package:flutter_test/flutter_test.dart';

/// "Up" on the screen's axes for a phone turned [turn]° counter-clockwise
/// in its own plane and leaning [lean]° with its top towards the user.
Vec3 _up(double turn, {double lean = 0}) {
  final t = turn * math.pi / 180, l = lean * math.pi / 180;
  return Vec3(
    math.sin(t) * math.cos(l),
    math.cos(t) * math.cos(l),
    math.sin(l),
  );
}

void main() {
  test('upright and level: no tilt, no lean', () {
    final p = cameraPose(_up(0))!;
    expect(p.rotation, closeTo(0, 1e-9));
    expect(p.tilt, closeTo(0, 1e-9));
    expect(p.pitch, closeTo(0, 1e-9));
  });

  test('tilt is how far from the nearest level or plumb', () {
    expect(cameraPose(_up(2.5))!.tilt, closeTo(2.5, 1e-9));
    expect(cameraPose(_up(-1.2))!.tilt, closeTo(-1.2, 1e-9));
    // Held sideways: measured from landscape.
    expect(cameraPose(_up(88))!.tilt, closeTo(-2, 1e-9));
    expect(cameraPose(_up(-91))!.tilt, closeTo(-1, 1e-9));
    expect(cameraPose(_up(178))!.tilt, closeTo(-2, 1e-9));
    // The grid turns with the whole rotation.
    expect(cameraPose(_up(88))!.rotation, closeTo(88, 1e-9));
  });

  test('leaning doesn\'t change the tilt', () {
    final p = cameraPose(_up(3, lean: 25))!;
    expect(p.tilt, closeTo(3, 1e-9));
    expect(p.pitch, closeTo(25, 1e-9));
  });

  test('the Level\'s on-edge calibration is taken off', () {
    expect(cameraPose(_up(0.4), offset: 0.4)!.tilt, closeTo(0, 1e-9));
  });

  test('too flat to tell', () {
    expect(cameraPose(_up(0, lean: 70)), isNull);
    expect(cameraPose(_up(0, lean: -65)), isNull);
    expect(cameraPose(_up(0, lean: 55)), isNotNull);
  });

  test('an edge against true level, with the side that is low', () {
    // Phone level: true level is flat on the screen.
    expect(edgeReading(0, 0, 100, 0, 0)!.offset, closeTo(0, 1e-9));
    final right = edgeReading(0, 0, 100, 3.49, 0)!;
    expect(right.offset, closeTo(2, 0.01));
    expect(right.plumb, isFalse);
    expect(edgeReading(0, 3.49, 100, 0, 0)!.offset, closeTo(-2, 0.01));
    // Which point is which doesn't matter.
    expect(edgeReading(100, 3.49, 0, 0, 0)!.offset, closeTo(2, 0.01));
    // The phone turned 3°: true level runs at 3° on the screen.
    expect(edgeReading(0, 0, 100, 5.24, 3)!.offset, closeTo(0, 0.01));
    expect(edgeReading(0, 0, 100, 0, 3)!.offset, closeTo(-3, 1e-9));
  });

  test('an upright edge is read against plumb', () {
    final e = edgeReading(0, 0, 3.49, 100, 0)!;
    expect(e.plumb, isTrue);
    expect(e.offset.abs(), closeTo(2, 0.01));
    // Held sideways, an edge flat on the screen is a plumb edge.
    expect(edgeReading(0, 0, 100, 0, 90)!.plumb, isTrue);
    expect(edgeReading(0, 0, 0.5, 0, 0), isNull);
  });
}
