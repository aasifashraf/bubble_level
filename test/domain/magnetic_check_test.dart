import 'dart:math' as math;

import 'package:bubble_level/domain/angles.dart';
import 'package:bubble_level/domain/magnetic_check.dart';
import 'package:flutter_test/flutter_test.dart';

/// The field a flat phone sees facing [heading]: the Earth's (30 µT
/// horizontal, 40 µT down), plus [offset] fixed to the phone.
Vec3 _field(double heading, {Vec3 offset = const Vec3(0, 0, 0)}) {
  final h = heading * math.pi / 180;
  // North in the phone's frame when its top faces [heading].
  final earth = Vec3(-math.sin(h) * 30, math.cos(h) * 30, -40);
  return earth + offset;
}

void main() {
  test('a healthy compass holds its strength as the phone turns', () {
    final check = MagneticCheck();
    for (var i = 0; i <= 60; i++) {
      final heading = i * 3.0;
      check.add(_field(heading), heading, i * 0.1);
    }
    expect(check.consistent, isTrue);
  });

  test('a field fixed to the phone swings with the turn: miscalibrated', () {
    final check = MagneticCheck();
    const offset = Vec3(12, 0, 0); // left magnetised by a magnet
    for (var i = 0; i <= 60; i++) {
      final heading = i * 3.0;
      check.add(_field(heading, offset: offset), heading, i * 0.1);
    }
    expect(check.consistent, isFalse);

    // After a figure 8 the system has corrected it: clear again.
    for (var i = 0; i <= 60; i++) {
      final heading = 180 + i * 3.0;
      check.add(_field(heading), heading, 20 + i * 0.1);
    }
    expect(check.consistent, isTrue);
  });

  test('no verdict until the phone has turned far enough', () {
    final check = MagneticCheck();
    for (var i = 0; i <= 20; i++) {
      final heading = i * 2.0; // 40° only
      check.add(
        _field(heading, offset: const Vec3(12, 0, 0)),
        heading,
        i * 0.1,
      );
    }
    expect(check.consistent, isNull);
  });
}
