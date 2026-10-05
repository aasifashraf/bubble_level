import 'package:bubble_level/data/repositories/barometer_repository.dart';
import 'package:bubble_level/data/repositories/orientation_repository.dart';
import 'package:bubble_level/data/repositories/settings_repository.dart';
import 'package:bubble_level/data/repositories/vibration_repository.dart';
import 'package:bubble_level/domain/angles.dart';
import 'package:bubble_level/domain/orientation_reading.dart';
import 'package:bubble_level/ui/features/altimeter/view_models/altimeter_view_model.dart';
import 'package:bubble_level/ui/features/metal/view_models/metal_view_model.dart';
import 'package:bubble_level/ui/features/protractor/view_models/protractor_view_model.dart';
import 'package:bubble_level/ui/features/vibration/view_models/vibration_view_model.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../helpers/fakes.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('ProtractorViewModel', () {
    test('angle between the arms, the short way round', () {
      final vm = ProtractorViewModel();
      expect(vm.angle, 60);
      vm.setArm(1, 300); // 0° and 300° are 60° apart the other way
      expect(vm.angle, 60);
      expect(vm.reflex, 300);
      expect(vm.arcStart, 300);
    });

    test('drags the nearest arm and snaps to whole degrees', () {
      final vm = ProtractorViewModel()..beginDrag(55.4);
      expect(vm.arm(1), 55); // arm 1 (at 60°) was nearer
      vm.dragTo(90.6);
      expect(vm.arm(1), 91);
      expect(vm.arm(0), 0);
      vm.reset();
      expect(vm.angle, 60);
    });
  });

  group('metal detector beep', () {
    test('silent with no metal, then faster the bigger the change', () {
      expect(MetalViewModel.beepGap(0), isNull);
      expect(MetalViewModel.beepGap(MetalViewModel.nearbyAt - 1), isNull);
      final near = MetalViewModel.beepGap(MetalViewModel.nearbyAt)!;
      final mid = MetalViewModel.beepGap(60)!;
      final close = MetalViewModel.beepGap(MetalViewModel.fastestAt)!;
      expect(near, MetalViewModel.slowestGap);
      expect(mid, lessThan(near));
      expect(close, MetalViewModel.fastestGap);
      expect(MetalViewModel.beepGap(500), MetalViewModel.fastestGap);
      // A drop in the field counts as much as a rise.
      expect(MetalViewModel.beepGap(-60), mid);
    });
  });

  test('protractor lock: no moves or reset until unlocked', () {
    final vm = ProtractorViewModel()..toggleLock();
    vm
      ..beginDrag(55)
      ..dragTo(90)
      ..reset();
    expect(vm.arm(1), 60);
    vm
      ..toggleLock()
      ..beginDrag(55);
    expect(vm.arm(1), 55);
    vm
      ..toggleLock()
      ..unlock();
    expect(vm.locked, isFalse);
  });

  testWidgets('metal: no beeps while the app is in the background', (
    tester,
  ) async {
    SharedPreferences.setMockInitialValues({});
    final settings = await SettingsRepository.load();
    final sensors = FakeMotionSensorService();
    final orientation = OrientationRepository(
      sensors: sensors,
      display: FakeDisplayRotationService(),
    );
    var beeps = 0;
    final vm = MetalViewModel(
      orientation: orientation,
      settings: settings,
      onDetected: () {},
      onTick: () => beeps++,
    )..active = true;
    Future<void> field(double strength) async {
      sensors
        ..sendMagnet(Vec3(0, strength, 0))
        ..sendUp(Vec3.up);
      await tester.pump();
    }

    await field(50);
    orientation
      ..stop()
      ..start();
    await field(150); // strong metal: fast beeps
    await tester.pump(const Duration(seconds: 1));
    expect(beeps, greaterThan(3));

    for (final state in [
      AppLifecycleState.inactive,
      AppLifecycleState.hidden,
      AppLifecycleState.paused,
    ]) {
      tester.binding.handleAppLifecycleStateChanged(state);
    }
    beeps = 0;
    await tester.pump(const Duration(seconds: 2));
    expect(beeps, 0);

    for (final state in [
      AppLifecycleState.hidden,
      AppLifecycleState.inactive,
      AppLifecycleState.resumed,
    ]) {
      tester.binding.handleAppLifecycleStateChanged(state);
    }
    await field(150);
    await tester.pump(const Duration(seconds: 1));
    expect(beeps, greaterThan(0), reason: 'beeps again when back');
    vm.dispose();
    orientation.dispose();
  });

  group('sensor tools', () {
    late FakeMotionSensorService sensors;
    late OrientationRepository orientation;
    late SettingsRepository settings;

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      settings = await SettingsRepository.load();
      sensors = FakeMotionSensorService();
      orientation = OrientationRepository(
        sensors: sensors,
        display: FakeDisplayRotationService(),
      );
      await flush();
    });

    tearDown(() => orientation.dispose());

    Future<void> field(double strength) async {
      sensors
        ..sendMagnet(Vec3(0, strength, 0))
        ..sendUp(Vec3.up);
      await flush();
    }

    test('metal: baseline from the first reading, levels, one buzz', () async {
      var buzzes = 0;
      final vm = MetalViewModel(
        orientation: orientation,
        settings: settings,
        onDetected: () => buzzes++,
      )..active = true;
      addTearDown(vm.dispose);

      await field(50);
      expect(vm.state!.change, closeTo(0, 1e-9));
      expect(vm.state!.level, MetalLevel.clear);

      // Fresh orientation timing so the low-pass jumps straight to the value.
      orientation
        ..stop()
        ..start();
      await field(70);
      expect(vm.state!.level, MetalLevel.nearby);

      orientation
        ..stop()
        ..start();
      await field(120);
      expect(vm.state!.level, MetalLevel.detected);
      await field(121);
      expect(buzzes, 1);

      vm.setBaseline();
      expect(vm.state!.level, MetalLevel.clear);
    });

    test('metal: an offset left after the metal is gone re-zeroes itself, '
        'and the beeping stops', () async {
      var now = Duration.zero;
      var beeps = 0;
      final vm = MetalViewModel(
        orientation: orientation,
        settings: settings,
        onDetected: () {},
        onTick: () => beeps++,
        clock: () => now,
      )..active = true;
      addTearDown(vm.dispose);

      await field(50);
      orientation
        ..stop()
        ..start();
      // Metal removed, but this phone's sensor now reads 30 µT higher.
      await field(80);
      expect(vm.state!.level, MetalLevel.nearby);
      for (var i = 0; i < 10 * 20; i++) {
        now += const Duration(milliseconds: 50);
        await field(80);
      }
      expect(vm.state!.level, MetalLevel.clear);
      expect(vm.state!.change.abs(), lessThan(5));
      // Silent from here on.
      beeps = 0;
      await Future<void>.delayed(const Duration(milliseconds: 1200));
      expect(beeps, 0);
    });

    test('vibration: starts fresh each time it opens', () async {
      final repo = VibrationRepository(sensors: sensors);
      final vm = VibrationViewModel(repository: repo)..active = true;
      addTearDown(() {
        vm.dispose();
        repo.dispose();
      });
      for (var i = 0; i < 20; i++) {
        sensors.sendUserAccel(const Vec3(5, 0, 0));
      }
      await flush();
      expect(vm.reading.peak, greaterThan(4));
      vm
        ..active = false
        ..active = true;
      expect(vm.reading.peak, 0);
      expect(vm.reading.history, isEmpty);
    });

    test('vibration: runs only while active, reports level', () async {
      final repo = VibrationRepository(sensors: sensors);
      final vm = VibrationViewModel(repository: repo);
      addTearDown(() {
        vm.dispose();
        repo.dispose();
      });
      expect(sensors.userAccel.hasListener, isFalse);

      vm.active = true;
      expect(sensors.userAccel.hasListener, isTrue);
      for (var i = 0; i < 20; i++) {
        sensors.sendUserAccel(const Vec3(3, 0, 0));
      }
      await flush();
      expect(vm.reading.current, closeTo(3, 1e-9));
      expect(vm.level, VibrationLevel.strong);

      vm.active = false;
      expect(sensors.userAccel.hasListener, isFalse);
    });

    test('vibration: without linear acceleration, uses the accelerometer '
        'minus gravity; missing only when that is missing too', () async {
      final repo = VibrationRepository(sensors: sensors);
      final vm = VibrationViewModel(repository: repo)..active = true;
      addTearDown(() {
        vm.dispose();
        repo.dispose();
      });
      sensors.userAccel.addError(Exception('NO_SENSOR'));
      await flush();
      expect(vm.reading.state, isNot(SensorState.missing));
      expect(sensors.accel.hasListener, isTrue);

      // Resting on a table: gravity alone reads as still.
      for (var i = 0; i < 20; i++) {
        sensors.sendAccel(const Vec3(0, 0, 9.81));
      }
      await flush();
      expect(vm.reading.state, SensorState.ok);
      expect(vm.reading.current, closeTo(0, 1e-6));
      // A sudden jolt on top of gravity shows up as vibration.
      sensors.sendAccel(const Vec3(3, 0, 9.81));
      await flush();
      expect(vm.reading.current, greaterThan(1));

      sensors.accel.addError(Exception('NO_SENSOR'));
      await flush();
      expect(vm.reading.state, SensorState.missing);
    });

    test('altimeter: pressure, altitude and height from zero', () async {
      final repo = BarometerRepository(sensors: sensors);
      final vm = AltimeterViewModel(repository: repo)..active = true;
      addTearDown(() {
        vm.dispose();
        repo.dispose();
      });

      sensors.sendPressure(1013.25);
      await flush();
      expect(vm.reading.pressure, closeTo(1013.25, 1e-9));
      expect(vm.reading.altitude, closeTo(0, 1e-6));
      vm.setZero();
      expect(vm.relative, closeTo(0, 1e-6));

      // Restart so the filter takes the next sample as-is.
      vm
        ..active = false
        ..active = true;
      sensors.sendPressure(1012.25); // about 8 m higher
      await flush();
      expect(vm.relative, closeTo(8.4, 0.3));
      vm.clearZero();
      expect(vm.relative, isNull);
    });
  });
}
