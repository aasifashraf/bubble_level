/// The metal detector's "no metal" field strength, which re-zeroes itself.
///
/// Some phones' magnetometers settle at a new offset after a strong magnet
/// or steel comes close, or recalibrate mid-use; with a fixed baseline the
/// detector would then report metal (and beep) forever. Once the field has
/// held steady for [settle], the baseline glides to it with time constant
/// [glide]. A field that keeps changing (sweeping past metal) leaves the
/// baseline alone, so detection while moving is unaffected; metal held
/// perfectly still is forgotten after a few seconds, like the auto-retune
/// of a handheld pinpointer.
class MetalBaseline {
  /// Within this of where it settled, the field counts as steady, µT.
  static const steadyWithin = 3.0;

  /// How long the field must hold steady before the baseline follows, s.
  static const settle = 3.0;

  /// Time constant of the glide, s.
  static const glide = 3.0;

  double? _baseline;
  double _anchor = 0, _steadySince = 0, _last = 0;

  /// The field counted as "no metal", or null before the first sample.
  double? get value => _baseline;

  /// Forgets everything; the next sample becomes the baseline.
  void clear() => _baseline = null;

  /// Treats [field] at time [seconds] as "no metal" right away.
  void reset(double field, double seconds) {
    _baseline = _anchor = field;
    _steadySince = _last = seconds;
  }

  /// Adds a sample at time [seconds] and returns its change from the
  /// baseline, µT.
  double add(double field, double seconds) {
    final baseline = _baseline;
    if (baseline == null) {
      reset(field, seconds);
      return 0;
    }
    if ((field - _anchor).abs() > steadyWithin) {
      _anchor = field;
      _steadySince = seconds;
    } else if (seconds - _steadySince >= settle) {
      final dt = (seconds - _last).clamp(0.0, 0.5);
      _baseline = baseline + (field - baseline) * (dt / (glide + dt));
    }
    _last = seconds;
    return field - _baseline!;
  }
}
