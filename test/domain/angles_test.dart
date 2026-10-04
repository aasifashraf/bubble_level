import 'dart:math' as math;

import 'package:bubble_level/domain/angles.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/fakes.dart';

Vec3 _tiltedUp(double deg, {bool aboutX = true}) {
  final r = deg * math.pi / 180;
  return aboutX
      ? Vec3(0, math.sin(r), math.cos(r))
      : Vec3(math.sin(r), 0, math.cos(r));
}

void main() {
  const eps = 1e-6;

  group('wrap180', () {
    test('wraps into (-180, 180]', () {
      expect(wrap180(190), closeTo(-170, eps));
      expect(wrap180(-190), closeTo(170, eps));
      expect(wrap180(-180), 180);
      expect(wrap180(180), 180);
      expect(wrap180(360), closeTo(0, eps));
      expect(wrap180(725), closeTo(5, eps));
    });
  });

  group('tilt, roll, pitch', () {
    test('flat is 0°, upright is 90°, face down is 180°', () {
      expect(tiltDeg(Vec3.up), closeTo(0, eps));
      expect(tiltDeg(const Vec3(0, 1, 0)), closeTo(90, eps));
      expect(tiltDeg(const Vec3(0, 0, -1)), closeTo(180, eps));
    });

    test('works on non-unit vectors', () {
      expect(tiltDeg(const Vec3(0, 9.81, 9.81)), closeTo(45, eps));
    });

    test('pitch is positive when the top edge is raised', () {
      expect(pitchDeg(_tiltedUp(12)), closeTo(12, eps));
      expect(rollDeg(_tiltedUp(12)), closeTo(0, eps));
    });

    test('roll is positive when the right edge is raised', () {
      expect(rollDeg(_tiltedUp(-7, aboutX: false)), closeTo(-7, eps));
      expect(rollDeg(_tiltedUp(7, aboutX: false)), closeTo(7, eps));
    });
  });

  group('edgeDeg', () {
    test('portrait upright is 0°', () {
      expect(edgeDeg(const Vec3(0, 1, 0)), closeTo(0, eps));
    });
    test('resting on the left edge is 90°, right edge -90°', () {
      expect(edgeDeg(const Vec3(1, 0, 0)), closeTo(90, eps));
      expect(edgeDeg(const Vec3(-1, 0, 0)), closeTo(-90, eps));
    });
    test('upside down is 180°', () {
      expect(edgeDeg(const Vec3(0, -1, 0)), closeTo(180, eps));
    });
  });

  group('deviceToScreen', () {
    test('landscape (1 quarter turn) puts device +x "up" on screen', () {
      final s = deviceToScreen(const Vec3(1, 0, 0), 1);
      expect(edgeDeg(s), closeTo(0, eps));
    });
    test('every rotation keeps z and length', () {
      const v = Vec3(1, 2, 3);
      for (var t = 0; t < 4; t++) {
        final s = deviceToScreen(v, t);
        expect(s.z, v.z);
        expect(s.length, closeTo(v.length, eps));
      }
    });
    test('four quarter turns are the identity', () {
      var v = const Vec3(0.3, -0.4, 0.5);
      for (var t = 0; t < 4; t++) {
        v = deviceToScreen(v, 1);
      }
      expect(v.x, closeTo(0.3, eps));
      expect(v.y, closeTo(-0.4, eps));
    });
  });

  group('rotateFromTo', () {
    test('maps the reference direction onto the target', () {
      final ref = _tiltedUp(3);
      final r = rotateFromTo(ref, ref, Vec3.up);
      expect(tiltDeg(r), closeTo(0, 1e-9));
    });
    test('handles parallel and opposite directions', () {
      const v = Vec3(1, 2, 3);
      final same = rotateFromTo(v, Vec3.up, Vec3.up);
      expect([same.x, same.y, same.z], [1, 2, 3]);
      final flipped = rotateFromTo(Vec3.up, const Vec3(0, 0, -1), Vec3.up);
      expect(flipped.z, closeTo(-1, eps));
    });
    test('preserves angles between vectors', () {
      final a = _tiltedUp(10), b = _tiltedUp(25);
      final ra = rotateFromTo(a, _tiltedUp(2), Vec3.up);
      final rb = rotateFromTo(b, _tiltedUp(2), Vec3.up);
      expect(angleBetweenDeg(ra, rb), closeTo(15, 1e-6));
    });
  });

  group('nextMode', () {
    test('switches at 50° going up and 40° going down', () {
      expect(nextMode(LevelMode.flat, 45), LevelMode.flat);
      expect(nextMode(LevelMode.flat, 51), LevelMode.edge);
      expect(nextMode(LevelMode.edge, 45), LevelMode.edge);
      expect(nextMode(LevelMode.edge, 39), LevelMode.flat);
    });
    test('face down is flat too', () {
      expect(nextMode(LevelMode.flat, 175), LevelMode.flat);
      expect(nextMode(LevelMode.edge, 150), LevelMode.flat);
      expect(nextMode(LevelMode.flat, 120), LevelMode.edge);
    });
  });

  group('nextQuadrant', () {
    test('keeps the current quadrant within 50°', () {
      expect(nextQuadrant(0, 49), 0);
      expect(nextQuadrant(90, 41), 90);
    });
    test('snaps to the nearest quadrant beyond 50°', () {
      expect(nextQuadrant(0, 51), 90);
      expect(nextQuadrant(0, -100), -90);
      expect(nextQuadrant(0, 179), 180);
    });
    test('treats ±180 as the same quadrant', () {
      expect(nextQuadrant(0, -179), 180);
      expect(nextQuadrant(180, -140), 180);
    });
  });

  group('headingDeg', () {
    for (final heading in [0.0, 45.0, 90.0, 180.0, 270.0, 333.0]) {
      for (final pitch in [0.0, 25.0, -20.0]) {
        test('flat-ish: heading $heading° at pitch $pitch°', () {
          final pose = devicePose(heading: heading, pitch: pitch);
          final h = headingDeg(pose.up, pose.field, flat: true)!;
          expect(wrap180(h - heading), closeTo(0, 1e-6));
        });
      }
      test('upright: camera faces $heading°', () {
        final pose = devicePose(heading: heading, pitch: 90);
        final h = headingDeg(pose.up, pose.field, flat: false)!;
        expect(wrap180(h - heading), closeTo(0, 1e-6));
      });
    }

    test('is null when the field is parallel to gravity', () {
      expect(headingDeg(Vec3.up, const Vec3(0, 0, -40), flat: true), isNull);
    });
  });

  group('axisDeltaDeg', () {
    test('measures rotation about each axis', () {
      expect(
        axisDeltaDeg(Vec3.up, _tiltedUp(10), DeviceAxis.x),
        closeTo(10, eps),
      );
      expect(
        axisDeltaDeg(Vec3.up, _tiltedUp(-4, aboutX: false), DeviceAxis.y),
        closeTo(-4, eps),
      );
    });
    test('is null when the axis is vertical', () {
      expect(axisDeltaDeg(Vec3.up, _tiltedUp(10), DeviceAxis.z), isNull);
    });
  });

  test('slopePercent', () {
    expect(slopePercent(45), closeTo(100, eps));
    expect(slopePercent(0), 0);
    expect(slopePercent(90), isNull);
  });

  test('cardinal', () {
    expect(cardinal(0), 'N');
    expect(cardinal(359), 'N');
    expect(cardinal(44), 'NE');
    expect(cardinal(90), 'E');
    expect(cardinal(225), 'SW');
  });
}
