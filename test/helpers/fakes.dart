import 'dart:async';
import 'dart:math' as math;
import 'dart:typed_data';

import 'package:bubble_level/data/services/ar_service.dart';
import 'package:bubble_level/data/services/camera_service.dart';
import 'package:bubble_level/data/services/display_rotation_service.dart';
import 'package:bubble_level/data/services/location_service.dart';
import 'package:bubble_level/data/services/microphone_service.dart';
import 'package:bubble_level/data/services/motion_sensor_service.dart';
import 'package:bubble_level/data/services/sound_service.dart';
import 'package:bubble_level/domain/angles.dart';
import 'package:bubble_level/domain/speed.dart';
import 'package:flutter/widgets.dart';

/// Sensor streams the test drives by hand.
class FakeMotionSensorService implements MotionSensorService {
  final accel = StreamController<SensorSample>.broadcast();
  final gyro = StreamController<SensorSample>.broadcast();
  final magnet = StreamController<SensorSample>.broadcast();
  final userAccel = StreamController<SensorSample>.broadcast();
  final baro = StreamController<ScalarSample>.broadcast();
  final lightSensor = StreamController<ScalarSample>.broadcast();
  final magnetAccuracy = StreamController<int>.broadcast();

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

  void sendLux(double lux) {
    _t = _t.add(const Duration(milliseconds: 200));
    lightSensor.add((value: lux, timestamp: _t));
  }

  /// Accelerometer reading for a phone whose "up" is [up] (any length).
  void sendUp(Vec3 up) => sendAccel(up.normalized() * 9.81);

  @override
  Stream<SensorSample> accelerometer({bool fast = false}) => accel.stream;
  @override
  Stream<SensorSample> gyroscope() => gyro.stream;
  @override
  Stream<SensorSample> magnetometer() => magnet.stream;
  @override
  Stream<SensorSample> userAccelerometer({bool fast = false}) =>
      userAccel.stream;
  @override
  Stream<ScalarSample> barometer() => baro.stream;
  @override
  Stream<ScalarSample> light() => lightSensor.stream;
  @override
  Stream<int> magneticAccuracy() => magnetAccuracy.stream;
}

class FakeDisplayRotationService implements DisplayRotationService {
  int turns = 0;

  /// What the "platform" reports for the ruler; null like iOS.
  ({double xdpi, double ydpi})? ppi;

  @override
  Future<int> quarterTurns() async => turns;

  @override
  Future<({double xdpi, double ydpi})?> pixelsPerInch() async => ppi;
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

/// Counts the sounds the app asks for.
class RecordingSoundService implements SoundService {
  int chimes = 0, ticks = 0;

  @override
  void chime() => chimes++;

  @override
  void tick() => ticks++;
}

/// A microphone the test drives: permission answers and sound blocks.
class FakeMicrophoneService implements MicrophoneService {
  /// Whether access is already granted.
  bool granted = false;

  /// The answer to the system prompt.
  bool grantOnRequest = true;

  int requests = 0, settingsOpened = 0;
  final blocks = StreamController<ScalarSample>.broadcast();
  var _t = DateTime(2026);

  /// Sends [seconds] of steady sound at mean square [meanSquare], in the
  /// service's 100 ms blocks.
  void sendSound(double meanSquare, {double seconds = 0.1}) {
    for (var i = 0; i < (seconds * 10).round(); i++) {
      _t = _t.add(const Duration(milliseconds: 100));
      blocks.add((value: meanSquare, timestamp: _t));
    }
  }

  @override
  Future<bool> hasPermission({bool request = false}) async {
    if (request && !granted) {
      requests++;
      granted = grantOnRequest;
    }
    return granted;
  }

  @override
  Future<void> openAppSettings() async => settingsOpened++;

  @override
  Stream<ScalarSample> levels() => blocks.stream;
}

/// A camera that opens (or refuses, or is missing) on request, with a
/// plain box for its picture.
class FakeCameraService implements CameraService {
  FakeCameraService({this.result = FakeCameraResult.ok, this.torch = true});

  FakeCameraResult result;
  final bool torch;
  int opened = 0, settingsOpened = 0;
  FakeCameraFeed? feed;

  @override
  Future<CameraFeed> open() async {
    opened++;
    switch (result) {
      case FakeCameraResult.denied:
        throw const CameraDenied();
      case FakeCameraResult.missing:
        throw const CameraMissing();
      case FakeCameraResult.ok:
        return feed = FakeCameraFeed(torch: torch);
    }
  }

  @override
  Future<void> openAppSettings() async => settingsOpened++;
}

enum FakeCameraResult { ok, denied, missing }

class FakeCameraFeed implements CameraFeed {
  FakeCameraFeed({required this.torch});

  final bool torch;
  bool frozen = false, torchOn = false, disposed = false;

  @override
  Widget get preview => const ColoredBox(color: Color(0xFF808080));

  @override
  double get aspectRatio => 3 / 4;

  @override
  Future<void> setFrozen(bool frozen) async => this.frozen = frozen;

  @override
  Future<bool> setTorch(bool on) async {
    if (!torch) return false;
    torchOn = on;
    return true;
  }

  @override
  Future<void> dispose() async => disposed = true;
}

/// GPS the test drives: permission answers and fixes.
class FakeLocationService implements LocationService {
  /// Where access stands without asking.
  LocationAccess checkResult = LocationAccess.needed;

  /// The answer to the system prompt.
  LocationAccess requestResult = LocationAccess.granted;

  int requested = 0, appSettingsOpened = 0, locationSettingsOpened = 0;
  final fixesController = StreamController<LocationFix>.broadcast();

  bool get listening => fixesController.hasListener;

  void send({
    required double lat,
    required double lon,
    double speed = -1,
    double accuracy = 5,
    double? altitude,
    required DateTime time,
  }) => fixesController.add((
    latitude: lat,
    longitude: lon,
    altitude: altitude,
    speed: speed,
    accuracy: accuracy,
    time: time,
  ));

  @override
  Future<LocationAccess> check() async => checkResult;

  @override
  Future<LocationAccess> request() async {
    requested++;
    return requestResult;
  }

  @override
  Future<void> openAppSettings() async => appSettingsOpened++;

  @override
  Future<void> openLocationSettings() async => locationSettingsOpened++;

  @override
  Stream<LocationFix> fixes() => fixesController.stream;
}

/// ARCore driven by hand: frames are sent by the test; points are added
/// where the last frame's aim was.
class FakeArService implements ArService {
  ArSupport supportResult = ArSupport.supported;
  bool cameraAllowed = true;

  /// The answer to the camera prompt.
  bool requestResult = true;
  String installResult = 'installed';

  /// Thrown by [start] instead of starting.
  ArStartFailed? startError;

  int requested = 0, started = 0, stopped = 0, appSettingsOpened = 0;
  final points = <Vec3>[];
  ArFrame last = ArFrame.none;
  final framesController = StreamController<ArFrame>.broadcast();

  bool get listening => framesController.hasListener;

  /// A tracking frame aiming at [aim] (null: no surface under the aim),
  /// seen through a simple camera at the origin looking down -z.
  void send({Vec3? aim, bool tracking = true, ArTrouble? trouble}) {
    last = ArFrame(
      tracking: tracking,
      trouble: trouble,
      aim: aim,
      points: List.of(points),
      viewProj: lookDownZ,
      surface: true,
    );
    framesController.add(last);
  }

  /// Perspective (90° field of view, square) looking down -z from the
  /// origin, column-major: x and y on screen are x/-z and y/-z.
  static final lookDownZ = Float32List.fromList([
    1, 0, 0, 0, //
    0, 1, 0, 0, //
    0, 0, -1, -1, //
    0, 0, -0.1, 0,
  ]);

  @override
  Future<ArSupport> support() async => supportResult;

  @override
  Future<String> install() async {
    if (installResult == 'installed') supportResult = ArSupport.supported;
    return installResult;
  }

  @override
  Future<bool> hasCamera() async => cameraAllowed;

  @override
  Future<bool> requestCamera() async {
    requested++;
    cameraAllowed = requestResult;
    return requestResult;
  }

  @override
  Future<int> start({
    required int width,
    required int height,
    required double aimX,
    required double aimY,
  }) async {
    final e = startError;
    if (e != null) throw e;
    started++;
    return 7;
  }

  @override
  Stream<ArFrame> frames() => framesController.stream;

  @override
  Future<bool> add() async {
    final aim = last.aim;
    if (aim == null) return false;
    points.add(aim);
    return true;
  }

  @override
  Future<void> undo() async {
    if (points.isNotEmpty) points.removeLast();
  }

  @override
  Future<void> clear() async => points.clear();

  @override
  Future<void> stop() async {
    stopped++;
    points.clear();
  }

  @override
  Future<void> openAppSettings() async => appSettingsOpened++;
}
