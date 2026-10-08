import 'angles.dart';

/// Points tapped on surfaces in the AR world (metres, ARCore's axes),
/// joined in order; [closed] when the last tap came back to the first
/// point, making a shape with an area.
class TapeShape {
  const TapeShape(this.points, {this.closed = false});

  static const empty = TapeShape([]);

  final List<Vec3> points;
  final bool closed;

  /// A shape needs three corners before it can close.
  bool get canClose => !closed && points.length >= 3;

  /// Each piece's length, m, in order: with the piece being measured to
  /// [live] last, or the closing piece back to the first point.
  List<double> pieces({Vec3? live}) {
    final p = points;
    return [
      for (var i = 1; i < p.length; i++) (p[i] - p[i - 1]).length,
      if (closed && p.length >= 3) (p.first - p.last).length,
      if (!closed && live != null && p.isNotEmpty) (live - p.last).length,
    ];
  }

  /// All the pieces added up, m: the perimeter once closed.
  double total({Vec3? live}) => pieces(live: live).fold(0.0, (a, b) => a + b);

  /// The area inside, m², once closed. The shape may lie on a floor, a
  /// wall or a slope: half the length of the summed cross products, exact
  /// for corners on one flat surface.
  double? get area {
    if (!closed || points.length < 3) return null;
    final o = points.first;
    var sum = const Vec3(0, 0, 0);
    for (var i = 1; i < points.length - 1; i++) {
      sum = sum + (points[i] - o).cross(points[i + 1] - o);
    }
    return sum.length / 2;
  }
}

/// Where world point [p] shows in a view [width] by [height] (y down), from
/// a column-major view-projection matrix [m]; null behind the camera.
({double x, double y})? project(
  List<double> m,
  Vec3 p,
  double width,
  double height,
) {
  final w = m[3] * p.x + m[7] * p.y + m[11] * p.z + m[15];
  if (w < 1e-3) return null;
  final x = (m[0] * p.x + m[4] * p.y + m[8] * p.z + m[12]) / w;
  final y = (m[1] * p.x + m[5] * p.y + m[9] * p.z + m[13]) / w;
  return (x: (x + 1) / 2 * width, y: (1 - y) / 2 * height);
}
