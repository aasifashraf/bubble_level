import 'dart:math' as math;

import 'package:flutter/foundation.dart';

import 'orientation_reading.dart';

/// One GPS fix.
typedef LocationFix = ({
  double latitude,
  double longitude,
  double? altitude,

  /// Ground speed from the satellites' Doppler shift, m/s; negative when
  /// the receiver didn't give one.
  double speed,

  /// How far off the position may be, m.
  double accuracy,
  DateTime time,
});

/// Metres per second to km/h and to mph.
const kmhPerMs = 3.6, mphPerMs = 2.2369362920544;

/// A snapshot of the speedometer.
@immutable
class SpeedReading {
  const SpeedReading({
    this.speed,
    this.accuracy,
    this.altitude,
    this.latitude,
    this.longitude,
    this.distance = 0,
    this.top = 0,
    this.movingSeconds = 0,
    this.state = SensorState.waiting,
  });

  /// Speed now, m/s; null until there's a fix.
  final double? speed;

  /// The fix's accuracy, m.
  final double? accuracy;

  /// GPS altitude, m (approximate).
  final double? altitude;
  final double? latitude, longitude;

  /// Trip distance (m), top speed (m/s) and time spent moving (s).
  final double distance, top, movingSeconds;

  final SensorState state;

  /// Average speed while moving, m/s.
  double get average => movingSeconds < 1 ? 0 : distance / movingSeconds;

  bool get hasFix => speed != null;

  /// The fix is too loose for a steady speed.
  bool get weak => accuracy != null && accuracy! > TripMeter.weakOver;
}

/// Speed, distance, top and average speed from GPS fixes.
///
/// Speed is the receiver's own (Doppler) speed when it gives one, which is
/// steadier than working it out from positions; otherwise the distance
/// between fixes over the time between them. Below walking pace it counts
/// as standing still, so GPS drift doesn't add up. Distance only grows from
/// fixes accurate enough to trust.
class TripMeter {
  /// Slower than this (m/s, about 2 km/h) counts as standing still.
  static const stillBelow = 0.55;

  /// Fixes looser than this (m) don't add distance or a top speed.
  static const weakOver = 25.0;

  LocationFix? _last;
  double? _speed;
  double _distance = 0, _top = 0, _moving = 0;

  double? get speed => _speed;

  void add(LocationFix fix) {
    final last = _last;
    _last = fix;
    final dt = last == null
        ? 0.0
        : fix.time.difference(last.time).inMicroseconds / 1e6;
    final step = last == null ? 0.0 : distanceBetween(last, fix);
    var v = fix.speed;
    if (v < 0) v = dt > 0 ? step / dt : 0;
    if (v < stillBelow) v = 0;
    _speed = v;
    if (fix.accuracy > weakOver) return;
    _top = math.max(_top, v);
    if (v > 0 && last != null && dt > 0 && dt < 10) {
      _distance += step;
      _moving += dt;
    }
  }

  void reset() {
    _distance = _top = _moving = 0;
  }

  SpeedReading reading(SensorState state) => SpeedReading(
    speed: _speed,
    accuracy: _last?.accuracy,
    altitude: _last?.altitude,
    latitude: _last?.latitude,
    longitude: _last?.longitude,
    distance: _distance,
    top: _top,
    movingSeconds: _moving,
    state: state,
  );
}

/// Great-circle distance between two fixes, m.
double distanceBetween(LocationFix a, LocationFix b) {
  const r = 6371000.0, rad = math.pi / 180;
  final p1 = a.latitude * rad, p2 = b.latitude * rad;
  final dp = p2 - p1, dl = (b.longitude - a.longitude) * rad;
  final h =
      math.sin(dp / 2) * math.sin(dp / 2) +
      math.cos(p1) * math.cos(p2) * math.sin(dl / 2) * math.sin(dl / 2);
  return 2 * r * math.asin(math.min(1, math.sqrt(h)));
}

/// A coordinate in degrees with its hemisphere: 34.05224° N.
String formatCoordinate(double deg, {required bool latitude}) {
  final h = latitude ? (deg >= 0 ? 'N' : 'S') : (deg >= 0 ? 'E' : 'W');
  return '${deg.abs().toStringAsFixed(5)}° $h';
}
