import 'dart:collection';
import 'dart:math' as math;

import 'package:flutter/foundation.dart';

import 'angles.dart';
import 'orientation_reading.dart';

/// Standard gravity, m/s²: one g.
const standardGravity = 9.80665;

/// A snapshot of the g-force meter, in g.
@immutable
class GReading {
  const GReading({
    this.lon = 0,
    this.lat = 0,
    this.peakSpeedUp = 0,
    this.peakBrake = 0,
    this.peakCorner = 0,
    this.peaks = const [],
    this.peakFades = const [],
    this.zeroed = false,
    this.state = SensorState.waiting,
  });

  /// Along the car: positive speeding up, negative braking.
  final double lon;

  /// Across the car: positive when you're pushed to the right (a left
  /// bend), negative to the left (a right bend).
  final double lat;

  /// The strongest speeding up, braking and cornering since Zero.
  final double peakSpeedUp, peakBrake, peakCorner;

  /// The strongest recent push in each of [GMeter.sectors] directions
  /// around the car, clockwise from straight ahead (the push you feel when
  /// braking).
  final List<double> peaks;

  /// How much of each recent peak is still shown: 1 for a fresh one, fading
  /// to 0 a few seconds after the push eases off.
  final List<double> peakFades;

  /// Whether Zero has set which way is down and forward.
  final bool zeroed;

  final SensorState state;

  /// The whole push, g.
  double get total => math.sqrt(lon * lon + lat * lat);
}

/// Turns raw accelerometer samples from a phone fixed in a car mount into
/// the push felt along and across the car.
///
/// Zero, taken while the car stands still, records gravity in the phone's
/// frame: that gives "down", and with it "forward" (the way the phone's
/// back faces, or its top edge for a phone lying flat) and "right". After
/// that, acceleration is the reading less that gravity, projected onto
/// those axes and smoothed so road bumps don't jump the display.
class GMeter {
  GMeter({this.smoothing = 0.25});

  /// Time constant of the smoothing, seconds.
  final double smoothing;

  /// Directions around the car that hold a peak each.
  static const sectors = 16;

  /// A direction's peak stays this long after the push eases off, then
  /// fades out over [fadeFor], seconds.
  static const holdFor = 1.5, fadeFor = 2.5;

  /// Samples kept for Zero to average over, seconds.
  static const zeroWindow = 0.5;

  final _recent = Queue<(double, Vec3)>();
  Vec3? _rest, _forward, _right;
  double? _last;
  double _lon = 0, _lat = 0;
  double _peakUp = 0, _peakBrake = 0, _peakCorner = 0;
  final _peaks = List<double>.filled(sectors, 0);
  final _peakAt = List<double>.filled(sectors, 0);
  double _now = 0;

  bool get zeroed => _rest != null;
  double get lon => _lon;
  double get lat => _lat;

  /// Whether there's enough to take a Zero from.
  bool get canZero => _recent.length >= 5;

  /// How much of sector [i]'s peak is still shown, 0 to 1.
  double _fade(int i) {
    if (_peaks[i] <= 0) return 0;
    final age = _now - _peakAt[i] - holdFor;
    return age <= 0 ? 1 : (1 - age / fadeFor).clamp(0.0, 1.0);
  }

  void add(Vec3 raw, double seconds) {
    _now = seconds;
    _recent.addLast((seconds, raw));
    while (_recent.isNotEmpty && seconds - _recent.first.$1 > zeroWindow) {
      _recent.removeFirst();
    }
    final rest = _rest, f = _forward, r = _right;
    if (rest == null || f == null || r == null) return;
    final a = raw - rest;
    // The car speeding up forward pushes the phone forward.
    final lon = a.dot(f) / standardGravity;
    // Turning left accelerates the car to the left; you're pushed right.
    final lat = -a.dot(r) / standardGravity;
    final last = _last;
    _last = seconds;
    // The first sample after Zero counts as one typical step, so a bump
    // right then is smoothed like any other.
    final dt = last == null ? 0.02 : (seconds - last).clamp(0.0, 0.2);
    final k = dt / (smoothing + dt);
    _lon += (lon - _lon) * k;
    _lat += (lat - _lat) * k;
    _peakUp = math.max(_peakUp, _lon);
    _peakBrake = math.max(_peakBrake, -_lon);
    _peakCorner = math.max(_peakCorner, _lat.abs());
    final total = math.sqrt(_lon * _lon + _lat * _lat);
    if (total > 0.05) {
      // Clockwise from ahead (braking pushes you forward).
      final angle = math.atan2(_lat, -_lon);
      final i = (angle / (2 * math.pi) * sectors).round() % sectors;
      // A push at least as strong as what's left of the peak renews it.
      if (total >= _peaks[i] * _fade(i)) {
        _peaks[i] = total;
        _peakAt[i] = seconds;
      }
    }
    for (var i = 0; i < sectors; i++) {
      if (_peaks[i] > 0 && _fade(i) == 0) _peaks[i] = 0;
    }
  }

  /// Takes the last half second as "standing still". False when there
  /// aren't enough samples yet.
  bool zero() {
    if (!canZero) return false;
    var sum = const Vec3(0, 0, 0);
    for (final (_, v) in _recent) {
      sum = sum + v;
    }
    final rest = sum * (1 / _recent.length);
    final up = rest.normalized();
    // Forward: out of the phone's back, level; for a phone lying flat, its
    // top edge instead.
    var forward = const Vec3(0, 0, -1) - up * (-up.z);
    if (forward.length < 0.3) forward = const Vec3(0, 1, 0) - up * up.y;
    forward = forward.normalized();
    _rest = rest;
    _forward = forward;
    _right = forward.cross(up).normalized();
    _lon = _lat = 0;
    _last = null;
    resetPeaks();
    return true;
  }

  void resetPeaks() {
    _peakUp = _peakBrake = _peakCorner = 0;
    _peaks.fillRange(0, sectors, 0);
  }

  GReading reading(SensorState state) => GReading(
    lon: _lon,
    lat: _lat,
    peakSpeedUp: _peakUp,
    peakBrake: _peakBrake,
    peakCorner: _peakCorner,
    peaks: List.unmodifiable(_peaks),
    peakFades: List.unmodifiable([for (var i = 0; i < sectors; i++) _fade(i)]),
    zeroed: zeroed,
    state: state,
  );
}
