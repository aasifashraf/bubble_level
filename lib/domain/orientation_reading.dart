import 'package:flutter/foundation.dart';

import 'angles.dart';

enum SensorState { waiting, ok, missing }

/// A fused snapshot of the motion sensors.
@immutable
class OrientationReading {
  const OrientationReading({
    this.gravity,
    this.magnetic,
    this.quarterTurns = 0,
    this.accel = SensorState.waiting,
    this.gyro = SensorState.waiting,
    this.magnet = SensorState.waiting,
  });

  /// Smoothed unit "up" vector in the device frame.
  final Vec3? gravity;

  /// Smoothed magnetic field in µT, device frame.
  final Vec3? magnetic;

  /// Current UI rotation from the device's natural orientation.
  final int quarterTurns;

  final SensorState accel, gyro, magnet;

  /// Gravity on the screen's axes (x right, y up as the user sees the UI).
  Vec3? get screenGravity =>
      gravity == null ? null : deviceToScreen(gravity!, quarterTurns);

  Vec3? get screenMagnetic =>
      magnetic == null ? null : deviceToScreen(magnetic!, quarterTurns);

  /// Magnetic heading of the top edge ([flat]) or back camera, or null
  /// without data. With [screen], "top" is the top of the UI as currently
  /// rotated; otherwise the device's own top edge, which doesn't change when
  /// the UI rotates.
  double? heading({required bool flat, bool screen = true}) {
    final g = screen ? screenGravity : gravity;
    final m = screen ? screenMagnetic : magnetic;
    return g == null || m == null ? null : headingDeg(g, m, flat: flat);
  }

  /// Earth's field is 25–65 µT; far outside that the compass is disturbed
  /// (nearby metal, magnets) or the magnetometer needs calibrating.
  bool get magneticReliable {
    final m = magnetic?.length;
    return m != null && m > 20 && m < 75;
  }
}
