import 'package:flutter/services.dart';
import 'package:sensors_plus/sensors_plus.dart';

import '../../domain/angles.dart';

/// One raw sensor sample in the device frame.
typedef SensorSample = ({Vec3 value, DateTime timestamp});

/// One raw sample of a single-valued sensor.
typedef ScalarSample = ({double value, DateTime timestamp});

/// Thin wrapper over `sensors_plus`, plus the light sensor through the
/// app's own channel. A stream emits an error when the device lacks that
/// sensor.
class MotionSensorService {
  const MotionSensorService();

  static const _period = SensorInterval.gameInterval;

  Stream<SensorSample> accelerometer() =>
      accelerometerEventStream(samplingPeriod: _period)
          .map((e) => (value: Vec3(e.x, e.y, e.z), timestamp: e.timestamp));

  /// Angular rate in rad/s.
  Stream<SensorSample> gyroscope() =>
      gyroscopeEventStream(samplingPeriod: _period)
          .map((e) => (value: Vec3(e.x, e.y, e.z), timestamp: e.timestamp));

  /// Magnetic field in µT.
  Stream<SensorSample> magnetometer() =>
      magnetometerEventStream(samplingPeriod: _period)
          .map((e) => (value: Vec3(e.x, e.y, e.z), timestamp: e.timestamp));

  /// Acceleration without gravity, in m/s².
  Stream<SensorSample> userAccelerometer() =>
      userAccelerometerEventStream(samplingPeriod: _period)
          .map((e) => (value: Vec3(e.x, e.y, e.z), timestamp: e.timestamp));

  /// Air pressure in hPa.
  Stream<ScalarSample> barometer() => barometerEventStream().map(
    (e) => (value: e.pressure, timestamp: e.timestamp),
  );

  static const _light = EventChannel('bubble_level/light');

  /// Illuminance in lux, from the ambient light sensor (Android; see
  /// MainActivity.kt). Emits only when the level changes.
  Stream<ScalarSample> light() => _light.receiveBroadcastStream().map(
    (e) => (value: (e as num).toDouble(), timestamp: DateTime.now()),
  );
}
