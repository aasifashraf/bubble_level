import 'dart:math' as math;

/// Pure orientation math. All vectors are in the device frame used by
/// Android and by `sensors_plus` on every platform:
/// x → right edge, y → top edge, z → out of the screen.
/// "Gravity" here is the accelerometer reading at rest, which points *up*
/// (+z when the phone lies face up).

const double _rad2deg = 180 / math.pi;

class Vec3 {
  const Vec3(this.x, this.y, this.z);

  static const up = Vec3(0, 0, 1);

  final double x, y, z;

  Vec3 operator +(Vec3 o) => Vec3(x + o.x, y + o.y, z + o.z);
  Vec3 operator -(Vec3 o) => Vec3(x - o.x, y - o.y, z - o.z);
  Vec3 operator *(double s) => Vec3(x * s, y * s, z * s);

  double dot(Vec3 o) => x * o.x + y * o.y + z * o.z;
  Vec3 cross(Vec3 o) =>
      Vec3(y * o.z - z * o.y, z * o.x - x * o.z, x * o.y - y * o.x);

  double get length => math.sqrt(dot(this));

  Vec3 normalized() {
    final l = length;
    return l == 0 ? this : this * (1 / l);
  }

  @override
  String toString() => 'Vec3($x, $y, $z)';
}

/// Maps a device-frame vector onto the screen's axes when the UI is rotated
/// [quarterTurns] × 90° from the natural orientation (Android
/// `Display.rotation`: 1 = device turned counter-clockwise to landscape).
Vec3 deviceToScreen(Vec3 v, int quarterTurns) => switch (quarterTurns % 4) {
  1 => Vec3(-v.y, v.x, v.z),
  2 => Vec3(-v.x, -v.y, v.z),
  3 => Vec3(v.y, -v.x, v.z),
  _ => v,
};

/// Wraps an angle in degrees into (-180, 180].
double wrap180(double deg) {
  final r = (deg + 180) % 360;
  return r == 0 ? 180 : r - 180;
}

double _acosDeg(double c) => math.acos(c.clamp(-1.0, 1.0)) * _rad2deg;

/// Angle between the screen normal and vertical: 0° flat face up, 90° upright.
double tiltDeg(Vec3 g) => _acosDeg(g.z / g.length);

/// Left/right tilt of a flat phone (positive when the left edge is lower).
double rollDeg(Vec3 g) => math.atan2(g.x, g.z) * _rad2deg;

/// Forward/back tilt of a flat phone (positive when the bottom edge is lower).
double pitchDeg(Vec3 g) => math.atan2(g.y, g.z) * _rad2deg;

/// Rotation of an upright phone within the screen plane:
/// 0° portrait, 90° turned counter-clockwise onto its left edge.
double edgeDeg(Vec3 g) => math.atan2(g.x, g.y) * _rad2deg;

/// Angle of the phone's long edge from level, 0–90°, for a phone standing
/// on an edge: 0° lying on its long side, 90° upright in portrait. Which
/// way up doesn't matter. [offset] is the Level's on-edge calibration.
double longEdgeDeg(Vec3 g, {double offset = 0}) =>
    (90 - wrap180(edgeDeg(g) - offset).abs()).abs();

double angleBetweenDeg(Vec3 a, Vec3 b) =>
    _acosDeg(a.dot(b) / (a.length * b.length));

/// Signed angle of the 2D point (a, b) measured from the b axis, or null when
/// the point is too close to the origin for the angle to be meaningful.
double? planeAngleDeg(double a, double b, {double minLength = 0.3}) =>
    math.sqrt(a * a + b * b) < minLength ? null : math.atan2(a, b) * _rad2deg;

/// Signed change of rotation about one device axis between two unit gravity
/// vectors, or null if either is (nearly) parallel to that axis.
enum DeviceAxis { x, y, z }

double? axisDeltaDeg(Vec3 from, Vec3 to, DeviceAxis axis) {
  double? angle(Vec3 g) => switch (axis) {
    DeviceAxis.x => planeAngleDeg(g.y, g.z),
    DeviceAxis.y => planeAngleDeg(g.x, g.z),
    DeviceAxis.z => planeAngleDeg(g.x, g.y),
  };
  final a = angle(from), b = angle(to);
  return a == null || b == null ? null : wrap180(b - a);
}

/// Rotates [v] by the rotation that takes direction [from] onto [to]
/// (Rodrigues' formula). Used to apply a flat-surface calibration.
Vec3 rotateFromTo(Vec3 v, Vec3 from, Vec3 to) {
  final f = from.normalized(), t = to.normalized();
  final c = f.dot(t);
  final axis = f.cross(t);
  final s = axis.length;
  if (s < 1e-9) {
    // Parallel: identity, or a half turn about the x axis when opposite.
    return c > 0 ? v : Vec3(v.x, -v.y, -v.z);
  }
  final k = axis * (1 / s);
  return v * c + k.cross(v) * s + k * (k.dot(v) * (1 - c));
}

enum LevelMode { flat, edge }

/// Flat while the screen is within ~45° of horizontal (face up or face
/// down), with ±5° hysteresis so the mode does not flicker near the boundary.
LevelMode nextMode(LevelMode current, double tilt) {
  final fromHorizontal = tilt > 90 ? 180 - tilt : tilt;
  return switch (current) {
    LevelMode.flat when fromHorizontal > 50 => LevelMode.edge,
    LevelMode.edge when fromHorizontal < 40 => LevelMode.flat,
    _ => current,
  };
}

/// Nearest multiple of 90° to [edge] (one of -90, 0, 90, 180), keeping
/// [current] until the angle is more than 50° away from it (hysteresis).
int nextQuadrant(int current, double edge) {
  if (wrap180(edge - current).abs() <= 50) return current;
  final q = (edge / 90).round() * 90;
  return q == -180 ? 180 : q;
}

/// Tilt-compensated magnetic heading in [0, 360), using Android's
/// getRotationMatrix construction. When [flat], it is the direction the top
/// edge points; otherwise the direction the back camera faces.
/// Null when gravity and the magnetic field are (nearly) parallel.
double? headingDeg(Vec3 g, Vec3 m, {required bool flat}) {
  final h = m.cross(g);
  if (h.length < 1e-6) return null;
  final east = h.normalized();
  final north = g.normalized().cross(east);
  final a = flat ? math.atan2(east.y, north.y) : math.atan2(-east.z, -north.z);
  return (a * _rad2deg + 360) % 360;
}

/// Which of the eight 45° compass sectors (0 = N, 1 = NE, … 7 = NW) a
/// heading falls in; the UI names it in the user's language.
int cardinalSector(double heading) => ((heading % 360) / 45).round() % 8;

/// Grade of a slope in percent, or null when it is (near) vertical.
double? slopePercent(double deg) =>
    deg.abs() >= 89.5 ? null : math.tan(deg / _rad2deg) * 100;
