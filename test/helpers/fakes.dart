import 'dart:async';
import 'dart:math' as math;

import 'package:bubble_level/data/services/display_rotation_service.dart';
import 'package:bubble_level/data/services/motion_sensor_service.dart';
import 'package:bubble_level/domain/angles.dart';

/// Sensor streams the test drives by hand.
class FakeMotionSensorService implements MotionSensorService {
  final accel = StreamController<SensorSample>.broadcast();
  final gyro = StreamController<SensorSample>.broadcast();
  final magnet = StreamController<SensorSample>.broadcast();
  final userAccel = StreamController<SensorSample>.broadcast();
  final baro = StreamController<ScalarSample>.broadcast();

  var _t = DateTime(2026);

  /// Each sample advances the clock by 20 ms (the "game" sensor rate).
  SensorSample _sample(Vec3 v) {
    _t = _t.add(const Duration(milliseconds: 20));
    return (value: v, timestamp: _t);
  }

  void sendAccel(Vec3 v) => accel.add(_sample(v));
  void sendMagnet(Vec3 v) => magnet.add(_sample(v));
  void sendUserAccel(Vec3 v) => userAccel.add(_sample(v));
  void sendPressure(double hPa) {
    _t = _t.add(const Duration(milliseconds: 200));
    baro.add((value: hPa, timestamp: _t));
  }

  /// Accelerometer reading for a phone whose "up" is [up] (any length).
  void sendUp(Vec3 up) => sendAccel(up.normalized() * 9.81);

  @override
  Stream<SensorSample> accelerometer() => accel.stream;
  @override
  Stream<SensorSample> gyroscope() => gyro.stream;
  @override
  Stream<SensorSample> magnetometer() => magnet.stream;
  @override
  Stream<SensorSample> userAccelerometer() => userAccel.stream;
  @override
  Stream<ScalarSample> barometer() => baro.stream;
}

class FakeDisplayRotationService implements DisplayRotationService {
  int turns = 0;

  @override
  Future<int> quarterTurns() async => turns;
}

/// Lets stream events and async callbacks run.
Future<void> flush() => Future<void>.delayed(Duration.zero);

const _d2r = math.pi / 180;

/// Gravity ("up") and magnetic field in the device frame for a phone whose
/// top edge faces compass [heading] and is raised by [pitch] degrees
/// (0 = flat face up, 90 = upright with the screen facing the user).
/// Field: 20 µT north, 40 µT down.
({Vec3 up, Vec3 field}) devicePose({
  required double heading,
  required double pitch,
}) {
  // World axes as Vec3(east, north, up).
  final h = heading * _d2r, p = pitch * _d2r;
  final top = Vec3(math.sin(h), math.cos(h), 0);
  final right = Vec3(math.cos(h), -math.sin(h), 0);
  const worldUp = Vec3(0, 0, 1);
  final x = right;
  final y = top * math.cos(p) + worldUp * math.sin(p);
  final z = top * -math.sin(p) + worldUp * math.cos(p);
  Vec3 toDevice(Vec3 w) => Vec3(w.dot(x), w.dot(y), w.dot(z));
  return (up: toDevice(worldUp), field: toDevice(const Vec3(0, 20, -40)));
}
