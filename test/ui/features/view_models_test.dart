import 'dart:math' as math;

import 'package:bubble_level/data/repositories/orientation_repository.dart';
import 'package:bubble_level/data/repositories/settings_repository.dart';
import 'package:bubble_level/domain/angles.dart';
import 'package:bubble_level/domain/orientation_reading.dart';
import 'package:bubble_level/ui/features/angle/view_models/angle_view_model.dart';
import 'package:bubble_level/ui/features/compass/view_models/compass_view_model.dart';
import 'package:bubble_level/ui/features/level/view_models/level_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../helpers/fakes.dart';

Vec3 _pitched(double deg) {
  final r = deg * math.pi / 180;
  return Vec3(0, math.sin(r), math.cos(r));
}

Vec3 _rolled(double deg) {
  final r = deg * math.pi / 180;
  return Vec3(math.sin(r), 0, math.cos(r));
}

Vec3 _onEdge(double deg) {
  final r = deg * math.pi / 180;
  return Vec3(math.sin(r), math.cos(r), 0);
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late FakeMotionSensorService sensors;
  late FakeDisplayRotationService display;
  late OrientationRepository orientation;
  late SettingsRepository settings;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    settings = await SettingsRepository.load();
    sensors = FakeMotionSensorService();
    display = FakeDisplayRotationService();
    orientation = OrientationRepository(sensors: sensors, display: display);
    await flush();
  });

  tearDown(() => orientation.dispose());

  group('saved calibration', () {
    test('a damaged or far off-level flat calibration is ignored', () async {
      for (final saved in [
        ['NaN', '0', '1'],
        ['0', '0', '0'],
        ['0', '1', '0'], // 90° from level: never accepted when calibrating
      ]) {
        SharedPreferences.setMockInitialValues({'flatRef': saved});
        final s = await SettingsRepository.load();
        expect(s.isLevelCalibrated, isFalse, reason: '$saved');
      }
      SharedPreferences.setMockInitialValues({
        'flatRef': ['0.02', '0', '1'],
        'edgeOffset': 40.0,
      });
      final s = await SettingsRepository.load();
      expect(s.flatRef.z, closeTo(1, 1e-3), reason: 'a real calibration');
      expect(s.edgeOffset, 0, reason: 'out of reach');
    });
  });

  group('OrientationRepository', () {
    void listener() {}
    setUp(() => orientation.addListener(listener));
    tearDown(() => orientation.removeListener(listener));

    test('sensors run only while something listens', () {
      expect(sensors.accel.hasListener, isTrue);
      orientation.removeListener(listener);
      expect(sensors.accel.hasListener, isFalse);
      orientation.addListener(listener);
      expect(sensors.accel.hasListener, isTrue);
    });

    test('waits for data, then reports gravity', () async {
      expect(orientation.value.accel, SensorState.waiting);
      sensors.sendUp(Vec3.up);
      await flush();
      expect(orientation.value.accel, SensorState.ok);
      expect(orientation.value.gravity!.z, closeTo(1, 1e-9));
    });

    test('the magnetometer runs only while a tool asks for it', () {
      expect(sensors.magnet.hasListener, isFalse);
      orientation.useMagnetometer(true);
      expect(sensors.magnet.hasListener, isTrue);
      orientation.useMagnetometer(false);
      expect(sensors.magnet.hasListener, isFalse);
      expect(sensors.accel.hasListener, isTrue);
    });

    test('stopping forgets the last reading', () async {
      sensors.sendUp(Vec3.up);
      await flush();
      expect(orientation.value.gravity, isNotNull);
      orientation.stop();
      expect(orientation.value.gravity, isNull);
      expect(orientation.value.accel, SensorState.waiting);
    });

    test('marks a sensor missing when its stream errors', () async {
      orientation.useMagnetometer(true);
      sensors.magnet.addError(Exception('NO_SENSOR'));
      await flush();
      expect(orientation.value.magnet, SensorState.missing);
      expect(orientation.value.accel, SensorState.waiting);
    });
  });

  group('LevelViewModel', () {
    late LevelViewModel vm;
    late int haptics;

    setUp(() {
      haptics = 0;
      vm = LevelViewModel(
        orientation: orientation,
        settings: settings,
        onLevelReached: () => haptics++,
      )..active = true;
    });

    tearDown(() => vm.dispose());

    test(
      'face down on a level surface reads 0°, and tilt from there',
      () async {
        sensors.sendUp(const Vec3(0, 0, -1));
        await flush();
        expect(vm.state!.mode, LevelMode.flat);
        expect(vm.state!.angle, closeTo(0, 1e-9));
        expect(vm.state!.isLevel, isTrue);
        final a = 3 * math.pi / 180;
        for (var i = 0; i < 100; i++) {
          sensors.sendUp(Vec3(math.sin(a), 0, -math.cos(a)));
        }
        await flush();
        expect(vm.state!.angle, closeTo(3, 0.05));
      },
    );

    test('flat and level: 0°, vibrates once', () async {
      sensors.sendUp(Vec3.up);
      await flush();
      expect(vm.state!.mode, LevelMode.flat);
      expect(vm.state!.angle, closeTo(0, 1e-9));
      expect(vm.state!.isLevel, isTrue);
      sensors.sendUp(Vec3.up);
      await flush();
      expect(haptics, 1);
    });

    test('bubble floats to the high side', () async {
      sensors.sendUp(_rolled(5)); // right edge raised
      await flush();
      final s = vm.state!;
      expect(s.angle, closeTo(5, 1e-6));
      expect(s.roll, closeTo(5, 1e-6));
      expect(s.bubble.dx, greaterThan(0));
      expect(s.bubble.dy, closeTo(0, 1e-9));
      expect(s.isLevel, isFalse);
    });

    test('bubble stops at the rim', () async {
      sensors.sendUp(_pitched(30));
      await flush();
      expect(vm.state!.bubble.distance, closeTo(1, 1e-9));
      // Top raised → bubble toward the top of the screen (negative y).
      expect(vm.state!.bubble.dy, lessThan(0));
    });

    test('standing on an edge measures deviation from level', () async {
      sensors.sendUp(_onEdge(3));
      await flush();
      expect(vm.state!.mode, LevelMode.edge);
      expect(vm.state!.quadrant, 0);
      expect(vm.state!.deviation, closeTo(3, 1e-6));
      expect(vm.state!.angle, closeTo(3, 1e-6));
    });

    test('on its long side the quadrant follows', () async {
      sensors.sendUp(_onEdge(88));
      await flush();
      expect(vm.state!.quadrant, 90);
      expect(vm.state!.deviation, closeTo(-2, 1e-6));
    });

    test('a rotated UI is accounted for', () async {
      display.turns = 1;
      orientation.didChangeMetrics();
      await flush();
      sensors.sendUp(const Vec3(1, 0, 0)); // device on its left edge
      await flush();
      expect(vm.state!.quadrant, 0);
      expect(vm.state!.deviation, closeTo(0, 1e-9));
    });

    test('hold freezes the reading', () async {
      sensors.sendUp(_pitched(2));
      await flush();
      vm.toggleLock();
      sensors.sendUp(_pitched(20));
      await flush();
      expect(vm.locked, isTrue);
      expect(vm.state!.angle, closeTo(2, 1e-6));
    });

    test('calibration zeroes a slightly-off surface and persists', () async {
      sensors.sendUp(_pitched(2));
      await flush();
      expect(await vm.calibrate(), CalibrationResult.done);
      expect(vm.state!.angle, closeTo(0, 1e-6));
      expect(settings.isLevelCalibrated, isTrue);

      final reloaded = await SettingsRepository.load();
      expect(reloaded.flatRef.y, closeTo(settings.flatRef.y, 1e-12));
    });

    test('calibration refuses a clearly tilted surface', () async {
      sensors.sendUp(_pitched(10));
      await flush();
      expect(await vm.calibrate(), CalibrationResult.notLevel);
      expect(settings.isLevelCalibrated, isFalse);
    });

    test('edge calibration subtracts the offset', () async {
      sensors.sendUp(_onEdge(1.5));
      await flush();
      expect(await vm.calibrate(), CalibrationResult.done);
      expect(vm.state!.deviation, closeTo(0, 1e-6));
      await settings.resetLevelCalibration();
      expect(vm.state!.deviation, closeTo(1.5, 1e-6));
    });

    test('face down counts as flat, not as standing on an edge', () async {
      sensors.sendUp(const Vec3(0.01, 0.02, -1));
      await flush();
      expect(vm.state!.mode, LevelMode.flat);
    });

    test('noise at the level boundary vibrates only once', () async {
      for (var i = 0; i < 6; i++) {
        orientation
          ..stop()
          ..start();
        sensors.sendUp(_pitched(i.isEven ? 0.45 : 0.6));
        await flush();
      }
      expect(haptics, 1);
      expect(vm.state!.isLevel, isTrue);
    });

    test('chimes once per arrival at level, with sounds on', () async {
      var chimes = 0, successes = 0;
      final chiming = LevelViewModel(
        orientation: orientation,
        settings: settings,
        onLevelReached: () {},
        onChime: () => chimes++,
        onSuccess: () => successes++,
      )..active = true;
      addTearDown(chiming.dispose);
      await settings.setHaptics(false); // the chime doesn't depend on it

      Future<void> show(Vec3 up) async {
        orientation
          ..stop()
          ..start();
        sensors.sendUp(up);
        await flush();
      }

      Future<void> arrive() async {
        await show(_pitched(5));
        await show(Vec3.up);
      }

      await arrive();
      await show(Vec3.up);
      expect(chimes, 1, reason: 'not again while it stays level');
      await arrive();
      expect(chimes, 2);

      await settings.setSounds(false);
      await arrive();
      expect(chimes, 2, reason: 'sounds off');
      // Each arrival counts toward a review ask, with or without sound.
      expect(successes, 3);

      await settings.setSounds(true);
      await show(_pitched(5));
      chiming.toggleLock();
      await show(Vec3.up);
      expect(chimes, 2, reason: 'held');
    });

    test('an inactive view model ignores sensors and never vibrates', () async {
      vm.active = false;
      sensors.sendUp(Vec3.up);
      await flush();
      expect(haptics, 0);
    });

    test('calibrating while held uses the live position', () async {
      sensors.sendUp(_onEdge(30));
      await flush();
      vm.toggleLock(); // locked in edge mode
      orientation
        ..stop()
        ..start();
      sensors.sendUp(_pitched(1)); // now lying flat
      await flush();
      expect(await vm.calibrate(), CalibrationResult.done);
      expect(vm.locked, isFalse);
      expect(settings.edgeOffset, 0);
      expect(vm.state!.mode, LevelMode.flat);
      expect(vm.state!.angle, closeTo(0, 1e-6));
    });
  });

  group('AngleViewModel', () {
    late AngleViewModel vm;

    setUp(
      () =>
          vm = AngleViewModel(orientation: orientation, settings: settings)
            ..active = true,
    );
    tearDown(() => vm.dispose());

    test('locked: zero and mode changes apply to the frozen reading', () async {
      sensors.sendUp(_pitched(30));
      await flush();
      vm.toggleLock();
      // Lifted off the object.
      sensors.sendUp(_pitched(70));
      await flush();
      expect(vm.state!.tilt, closeTo(30, 1e-6));
      vm.setZero();
      expect(vm.state!.moved, closeTo(0, 1e-6));
      vm.clearZero();
      expect(vm.state!.tilt, closeTo(30, 1e-6), reason: 'still frozen');
      vm.toggleLock();
      for (var i = 0; i < 100; i++) {
        sensors.sendUp(_pitched(70));
      }
      await flush();
      expect(vm.state!.tilt, closeTo(70, 0.1), reason: 'live again');
    });

    test(
      'on an edge the lower side is measured, steady near upright',
      () async {
        await settings.setAngleMode(AngleMode.edge);
        Future<void> hold(double deg) async {
          for (var i = 0; i < 200; i++) {
            sensors.sendUp(_onEdge(deg));
          }
          await flush();
        }

        await hold(60); // right side raised: the left edge is lower
        expect(vm.state!.side, EdgeSide.left);
        expect(vm.state!.edge, closeTo(30, 0.1));
        await hold(-60);
        expect(vm.state!.side, EdgeSide.right);
        expect(vm.state!.edge, closeTo(30, 0.1));
        // Upright, leaning 1° the other way: no flicker across.
        await hold(1);
        expect(vm.state!.side, EdgeSide.right);
        expect(vm.state!.edge, closeTo(89, 0.1));
        await hold(3);
        expect(vm.state!.side, EdgeSide.left);
      },
    );

    test('reports angle from level before zeroing', () async {
      sensors.sendUp(_pitched(30));
      await flush();
      expect(vm.state!.zeroed, isFalse);
      expect(vm.state!.tilt, closeTo(30, 1e-6));
    });

    test('measures movement from the zero position', () async {
      sensors.sendUp(_pitched(10));
      await flush();
      vm.setZero();
      expect(vm.state!.moved, closeTo(0, 1e-6));

      // Restarting resets the filter, so the next sample is taken as-is.
      orientation
        ..stop()
        ..start();
      sensors.sendUp(_pitched(35));
      await flush();
      expect(vm.state!.moved, closeTo(25, 1e-6));
      expect(vm.state!.forwardBack, closeTo(25, 1e-6));
      expect(vm.state!.turn, isNull); // no magnetometer data

      vm.clearZero();
      expect(vm.state!.zeroed, isFalse);
    });

    test('"from level" honours the flat calibration', () async {
      sensors.sendUp(_pitched(2));
      await flush();
      await settings.calibrateFlat(_pitched(2));
      sensors.sendUp(_pitched(2));
      await flush();
      expect(vm.state!.tilt, closeTo(0, 1e-6));
    });

    test('turn does not jump when the UI rotates', () async {
      final pose = devicePose(heading: 40, pitch: 0);
      sensors
        ..sendUp(pose.up)
        ..sendMagnet(pose.field);
      await flush();
      sensors.sendUp(pose.up);
      await flush();
      vm.setZero();
      display.turns = 1;
      orientation.didChangeMetrics();
      await flush();
      sensors.sendUp(pose.up);
      await flush();
      expect(vm.state!.turn, closeTo(0, 1e-6));
    });
  });

  group('CompassViewModel', () {
    late CompassViewModel vm;

    setUp(() => vm = CompassViewModel(orientation: orientation)..active = true);
    tearDown(() => vm.dispose());

    test('reports tilt-compensated heading', () async {
      final pose = devicePose(heading: 120, pitch: 15);
      sensors
        ..sendUp(pose.up)
        ..sendMagnet(pose.field);
      await flush();
      sensors.sendUp(pose.up); // publish with the magnetometer value
      await flush();
      expect(vm.state!.heading, closeTo(120, 1e-6));
      expect(vm.state!.sector, 3); // SE
      expect(vm.state!.flat, isTrue);
      expect(vm.state!.reliable, isTrue);
    });

    test('flags a disturbed magnetic field', () async {
      sensors
        ..sendUp(Vec3.up)
        ..sendMagnet(const Vec3(0, 300, -40));
      await flush();
      sensors.sendUp(Vec3.up);
      await flush();
      expect(vm.state!.reliable, isFalse);
      expect(vm.state!.fieldOk, isFalse);
    });

    /// Sends [pose] long enough for the filters to settle on it.
    Future<void> hold(({Vec3 up, Vec3 field}) pose) async {
      for (var i = 0; i < 60; i++) {
        sensors
          ..sendUp(pose.up)
          ..sendMagnet(pose.field);
      }
      await flush();
    }

    /// Top edge facing [heading], the phone turned [roll] degrees about it
    /// (90: on its long side; 180: face down).
    ({Vec3 up, Vec3 field}) rolled(double heading, double roll) {
      final h = heading * math.pi / 180, r = roll * math.pi / 180;
      final top = Vec3(math.sin(h), math.cos(h), 0);
      final right = Vec3(math.cos(h), -math.sin(h), 0);
      const worldUp = Vec3(0, 0, 1);
      final x = right * math.cos(r) + worldUp * math.sin(r);
      final z = right * -math.sin(r) + worldUp * math.cos(r);
      Vec3 toDevice(Vec3 w) => Vec3(w.dot(x), w.dot(top), w.dot(z));
      return (up: toDevice(worldUp), field: toDevice(const Vec3(0, 20, -40)));
    }

    test('face down, and on its long side, it reads the top edge', () async {
      for (final roll in [70.0, 90.0, 180.0]) {
        await hold(rolled(90, roll));
        expect(vm.state!.heading, closeTo(90, 1), reason: 'roll $roll');
        expect(vm.state!.flat, isTrue, reason: 'roll $roll');
      }
    });

    test('upright, it reads the back camera', () async {
      await hold(devicePose(heading: 200, pitch: 85));
      expect(vm.state!.flat, isFalse);
      expect(vm.state!.heading, closeTo(200, 1));
    });

    test('reads the top of the screen as turned', () async {
      display.turns = 1; // turned to landscape, top edge to the left
      vm.active = false;
      vm.active = true;
      await flush();
      await hold(devicePose(heading: 0, pitch: 0));
      expect(vm.state!.heading, closeTo(90, 1));
    });

    test('the number holds until the heading clearly moves on', () async {
      await hold(devicePose(heading: 90.4, pitch: 0));
      expect(vm.state!.shown, 90);
      await hold(devicePose(heading: 90.6, pitch: 0));
      expect(vm.state!.shown, 90);
      await hold(devicePose(heading: 89.5, pitch: 0));
      expect(vm.state!.shown, 90);
      await hold(devicePose(heading: 91.2, pitch: 0));
      expect(vm.state!.shown, 91);
      await hold(devicePose(heading: 359.6, pitch: 0));
      expect(vm.state!.shown, 0);
      expect(vm.state!.sector, 0);
    });

    test('a field with almost no level part is flagged', () async {
      await hold((up: Vec3.up, field: const Vec3(0, 2, -50)));
      expect(vm.state!.fieldOk, isFalse);
    });

    test('untrusted while the system asks for calibration', () async {
      final pose = devicePose(heading: 120, pitch: 0);
      sensors
        ..sendUp(pose.up)
        ..sendMagnet(pose.field)
        ..magnetAccuracy.add(0);
      await flush();
      sensors.sendUp(pose.up);
      await flush();
      expect(vm.state!.fieldOk, isTrue);
      expect(vm.state!.calibrated, isFalse);
      expect(vm.state!.reliable, isFalse);
      sensors.magnetAccuracy.add(3);
      await flush();
      sensors.sendUp(pose.up);
      await flush();
      expect(vm.state!.reliable, isTrue);
    });
  });
}
