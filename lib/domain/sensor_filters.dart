import 'dart:math' as math;

import 'angles.dart';

/// How fast the sensor (accelerometer, magnetometer) pulls an estimate in:
/// gently when the gyroscope already turns it, quicker without one. Gravity
/// and the magnetic field share it, so they stay in step.
double _tau(bool hasGyro) => hasGyro ? 0.5 : 0.12;

/// Turns unit vector [from] the fraction [k] of the way to unit vector [to]
/// along the shortest arc. A straight blend of two opposite vectors never
/// changes direction (the phone turned face down while the gyroscope
/// missed it), so the filters turn instead.
Vec3 _turnToward(Vec3 from, Vec3 to, double k) {
  final angle = math.acos(from.dot(to).clamp(-1.0, 1.0));
  if (angle < 1e-9) return to;
  var axis = from.cross(to);
  if (axis.length < 1e-9) {
    // Opposite: any axis at right angles will do.
    axis = from.cross(
      from.x.abs() < 0.9 ? const Vec3(1, 0, 0) : const Vec3(0, 1, 0),
    );
  }
  final a = axis.normalized();
  final t = angle * k;
  return (from * math.cos(t) + a.cross(from) * math.sin(t)).normalized();
}

/// Complementary filter for the gravity direction: the gyroscope rotates the
/// estimate (smooth and fast), the accelerometer slowly pulls it back
/// (no drift). Without a gyroscope it degrades to a plain low-pass filter.
class GravityFilter {
  static const _standardGravity = 9.81;

  Vec3? _g;
  double? _lastAccel, _lastGyro;
  bool _hasGyro = false;

  /// Unit "up" vector in the device frame, or null before the first sample.
  Vec3? get value => _g;

  void addGyro(Vec3 rate, double seconds) {
    final last = _lastGyro;
    _lastGyro = seconds;
    _hasGyro = true;
    final g = _g;
    if (g == null || last == null) return;
    final dt = (seconds - last).clamp(0.0, 0.1);
    // The device rotates by ω, so the fixed up vector rotates by -ω in the
    // device frame: dg/dt = -ω × g = g × ω.
    _g = (g + g.cross(rate) * dt).normalized();
  }

  void addAccel(Vec3 a, double seconds) {
    final last = _lastAccel;
    _lastAccel = seconds;
    final len = a.length;
    if (len < 1e-3) return;
    final unit = a * (1 / len);
    final g = _g;
    if (g == null || last == null) {
      _g = unit;
      return;
    }
    final dt = (seconds - last).clamp(0.0, 0.1);
    final tau = _tau(_hasGyro);
    var k = dt / (tau + dt);
    // While the phone is being shaken the accelerometer isn't measuring
    // gravity; lean on the gyroscope instead.
    if (_hasGyro && (len - _standardGravity).abs() > 2) k *= 0.1;
    _g = _turnToward(g, unit, k);
  }

  /// Forget timestamps after a pause so the first dt isn't huge.
  void resetTiming() => _lastAccel = _lastGyro = null;
}

/// The magnetic field (µT, device frame), filtered like [GravityFilter] so
/// the two stay in step: the gyroscope turns the estimate as the phone
/// turns, and the magnetometer pulls it in gently, smoothing its noise. A
/// plain low-pass would trail the gravity estimate while the phone tilts,
/// and the heading would swing until it caught up.
class MagneticFilter {
  Vec3? _m;
  double? _lastField, _lastGyro;
  bool _hasGyro = false;

  Vec3? get value => _m;

  void addGyro(Vec3 rate, double seconds) {
    final last = _lastGyro;
    _lastGyro = seconds;
    _hasGyro = true;
    final m = _m;
    if (m == null || last == null) return;
    final dt = (seconds - last).clamp(0.0, 0.1);
    // Fixed in the world, so it turns by -ω in the device frame (as
    // gravity does) and keeps its strength.
    final turned = m + m.cross(rate) * dt;
    final l = turned.length;
    if (l > 0) _m = turned * (m.length / l);
  }

  void add(Vec3 field, double seconds) {
    final last = _lastField;
    _lastField = seconds;
    final m = _m;
    if (m == null || last == null) {
      _m = field;
      return;
    }
    final dt = (seconds - last).clamp(0.0, 0.1);
    final tau = _tau(_hasGyro);
    final k = dt / (tau + dt);
    // Direction and strength separately, so a big jump (a face down flip
    // the gyroscope missed) turns the estimate rather than shrinking it
    // through zero.
    final strength = m.length * (1 - k) + field.length * k;
    final l = m.length, f = field.length;
    _m = l == 0 || f == 0
        ? field
        : _turnToward(m * (1 / l), field * (1 / f), k) * strength;
  }
}

/// First-order low-pass filter for a vector signal.
class VectorLowPass {
  VectorLowPass(this.tau);

  final double tau;
  Vec3? _v;
  double? _last;

  Vec3? get value => _v;

  void add(Vec3 v, double seconds) {
    final last = _last, prev = _v;
    _last = seconds;
    if (prev == null || last == null) {
      _v = v;
      return;
    }
    final dt = (seconds - last).clamp(0.0, 0.5);
    final k = dt / (tau + dt);
    _v = prev * (1 - k) + v * k;
  }

  void resetTiming() => _last = null;
}

/// First-order low-pass filter for a single value.
class ScalarLowPass {
  ScalarLowPass(this.tau);

  final double tau;
  double? _v;
  double? _last;

  double? get value => _v;

  void add(double v, double seconds) {
    final last = _last, prev = _v;
    _last = seconds;
    if (prev == null || last == null) {
      _v = v;
      return;
    }
    final dt = (seconds - last).clamp(0.0, 2.0);
    final k = dt / (tau + dt);
    _v = prev * (1 - k) + v * k;
  }

  void resetTiming() => _last = null;
}
