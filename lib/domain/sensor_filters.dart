import 'angles.dart';

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
    final tau = _hasGyro ? 0.5 : 0.12;
    var k = dt / (tau + dt);
    // While the phone is being shaken the accelerometer isn't measuring
    // gravity; lean on the gyroscope instead.
    if (_hasGyro && (len - _standardGravity).abs() > 2) k *= 0.1;
    _g = (g * (1 - k) + unit * k).normalized();
  }

  /// Forget timestamps after a pause so the first dt isn't huge.
  void resetTiming() => _lastAccel = _lastGyro = null;
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
