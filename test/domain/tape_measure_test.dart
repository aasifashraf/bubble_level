import 'package:bubble_level/domain/angles.dart';
import 'package:bubble_level/domain/tape_measure.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // A 1.20 m by 0.70 m table top, 0.75 m up, in ARCore's axes (y up).
  const a = Vec3(-0.6, 0.75, -1.0), b = Vec3(0.6, 0.75, -1.0);
  const c = Vec3(0.6, 0.75, -1.7), d = Vec3(-0.6, 0.75, -1.7);

  group('TapeShape', () {
    test('pieces run point to point, the live one last', () {
      const s = TapeShape([a, b]);
      expect(s.pieces(), [closeTo(1.2, 1e-9)]);
      expect(s.pieces(live: c), [closeTo(1.2, 1e-9), closeTo(0.7, 1e-9)]);
      expect(s.total(live: c), closeTo(1.9, 1e-9));
    });

    test('a single point or none has no pieces', () {
      expect(TapeShape.empty.pieces(live: a), isEmpty);
      expect(const TapeShape([a]).pieces(), isEmpty);
      expect(const TapeShape([a]).pieces(live: b), [closeTo(1.2, 1e-9)]);
    });

    test('closes only from three corners', () {
      expect(const TapeShape([a, b]).canClose, isFalse);
      expect(const TapeShape([a, b, c]).canClose, isTrue);
      expect(const TapeShape([a, b, c], closed: true).canClose, isFalse);
    });

    test('a closed shape adds the piece back to the start, and its area', () {
      const s = TapeShape([a, b, c, d], closed: true);
      expect(s.pieces().length, 4);
      expect(s.total(), closeTo(3.8, 1e-9));
      expect(s.area, closeTo(0.84, 1e-9));
      // The live aim doesn't count once closed.
      expect(s.total(live: const Vec3(9, 9, 9)), closeTo(3.8, 1e-9));
    });

    test('area works on a wall, and needs a closed shape', () {
      // A 2 m by 1 m patch of a wall facing +z.
      const wall = TapeShape([
        Vec3(0, 0, -2),
        Vec3(2, 0, -2),
        Vec3(2, 1, -2),
        Vec3(0, 1, -2),
      ], closed: true);
      expect(wall.area, closeTo(2, 1e-9));
      expect(const TapeShape([a, b, c, d]).area, isNull);
      // A triangle: half the rectangle.
      expect(
        const TapeShape([a, b, c], closed: true).area,
        closeTo(0.42, 1e-9),
      );
    });
  });

  group('project', () {
    // Looking down -z from the origin, 90° field of view.
    const m = [
      1.0, 0.0, 0.0, 0.0, //
      0.0, 1.0, 0.0, 0.0, //
      0.0, 0.0, -1.0, -1.0, //
      0.0, 0.0, -0.1, 0.0,
    ];

    test('straight ahead lands in the middle', () {
      final p = project(m, const Vec3(0, 0, -2), 400, 800)!;
      expect(p.x, closeTo(200, 1e-9));
      expect(p.y, closeTo(400, 1e-9));
    });

    test('right and up land right and higher (y down)', () {
      final p = project(m, const Vec3(1, 1, -2), 400, 800)!;
      expect(p.x, closeTo(300, 1e-9));
      expect(p.y, closeTo(200, 1e-9));
    });

    test('behind the camera has no place', () {
      expect(project(m, const Vec3(0, 0, 1), 400, 800), isNull);
    });
  });
}
