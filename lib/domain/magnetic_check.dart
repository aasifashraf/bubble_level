import 'dart:math' as math;

import 'angles.dart';

/// Catches a compass the system believes is calibrated but isn't: after a
/// magnet has been near, the phone's own parts can be left magnetised, or
/// the system's correction thrown off. That adds a field fixed to the phone
/// on top of the Earth's, so the heading is wrong while the strength can
/// still look normal and the system still reports "high" accuracy.
///
/// The tell: the Earth's field has the same strength whichever way the
/// phone faces, but a field fixed to the phone adds to it facing one way
/// and takes from it facing the other. So, once the phone has turned far
/// enough, a strength that swings with the direction means the compass is
/// off (a figure 8 lets the system correct it).
class MagneticCheck {
  MagneticCheck({this.window = 8, this.minTurn = 90, this.maxSwing = 0.1});

  /// Seconds of samples considered.
  final double window;

  /// How far the heading must have turned (degrees) to judge.
  final double minTurn;

  /// Largest change in strength, as a fraction of the typical strength, a
  /// healthy compass shows as it turns. 10% is a few µT, well above sensor
  /// noise; an offset that size already turns the heading ten degrees.
  final double maxSwing;

  final _samples = <({double t, double heading, double strength})>[];
  bool? _consistent;

  /// Whether the field held steady over the last full turn; null until the
  /// phone has turned far enough to tell. Sticks until the next verdict.
  bool? get consistent => _consistent;

  void clear() {
    _samples.clear();
    _consistent = null;
  }

  void add(Vec3 field, double heading, double seconds) {
    // Keep one sample per few degrees (or half second) to bound the work.
    final last = _samples.isEmpty ? null : _samples.last;
    if (last != null &&
        wrap180(heading - last.heading).abs() < 4 &&
        seconds - last.t < 0.5) {
      return;
    }
    _samples
      ..add((t: seconds, heading: heading, strength: field.length))
      ..removeWhere((s) => seconds - s.t > window);
    if (_turned() < minTurn) return;
    final strengths = [for (final s in _samples) s.strength]..sort();
    final typical = strengths[strengths.length ~/ 2];
    if (typical <= 0) return;
    // Ignore the odd outlier at either end (a hand passing, a jolt).
    final trim = strengths.length ~/ 20;
    final low = strengths[trim], high = strengths[strengths.length - 1 - trim];
    _consistent = (high - low) / typical <= maxSwing;
  }

  /// The widest arc of headings covered, in degrees (0–360).
  double _turned() {
    if (_samples.length < 2) return 0;
    final sorted = [for (final s in _samples) (s.heading % 360 + 360) % 360]
      ..sort();
    // The covered arc is 360 minus the largest gap between headings.
    var gap = 360 - sorted.last + sorted.first;
    for (var i = 1; i < sorted.length; i++) {
      gap = math.max(gap, sorted[i] - sorted[i - 1]);
    }
    return 360 - gap;
  }
}
