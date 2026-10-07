import 'dart:math' as math;

import 'angles.dart';

const _rad = math.pi / 180;

/// How far the phone's top edge points above (+) or below (−) level, in
/// degrees, for "up" [g] in the device frame: the angle a sight line along
/// the top edge makes with the horizon. Null when the phone is held upright
/// (the top edge points at the sky or the ground, not along a sight line).
double? sightAngleDeg(Vec3 g) {
  final up = g.normalized();
  final a = math.asin(up.y.clamp(-1.0, 1.0)) / _rad;
  return a.abs() > 80 ? null : a;
}

/// Distance along the ground to an object's base, from the eye height and
/// the angle down to the base (negative). Null when the base angle isn't
/// clearly below level: sighting a base at the horizon means "very far",
/// where the method can't tell distances apart.
double? distanceToBase(double eyeHeight, double baseAngle) {
  if (eyeHeight <= 0 || baseAngle > -minBaseAngle) return null;
  return eyeHeight / math.tan(-baseAngle * _rad);
}

/// The base must be at least this far below level (degrees): shallower,
/// and a 1° aiming wobble changes the distance by more than about 20%.
const minBaseAngle = 3.0;

/// An object's height from where it's measured: the eye height plus the
/// rise to its top over [distance] (the top can be below eye level).
double? heightOf(double eyeHeight, double distance, double topAngle) {
  if (distance <= 0 || topAngle.abs() >= 80) return null;
  final h = eyeHeight + distance * math.tan(topAngle * _rad);
  return h > 0 ? h : null;
}

/// What to tell the user about a top angle: steeper than 70° the reading
/// swings a lot with a small wobble (step back); otherwise fine.
enum SightAdvice { ok, stepBack, tooFar }

SightAdvice adviseTop(double topAngle) =>
    topAngle > 70 ? SightAdvice.stepBack : SightAdvice.ok;

SightAdvice adviseBase(double baseAngle) =>
    baseAngle > -minBaseAngle ? SightAdvice.tooFar : SightAdvice.ok;

/// The middle value of [values] (empty → null): a steady reading of a hand
/// held angle, unbothered by the jolt of a tap.
double? median(Iterable<double> values) {
  final s = values.toList()..sort();
  if (s.isEmpty) return null;
  final m = s.length ~/ 2;
  return s.length.isOdd ? s[m] : (s[m - 1] + s[m]) / 2;
}

/// Feet per metre.
const feetPerMetre = 3.28084;
