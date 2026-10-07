import 'dart:math' as math;

import 'package:bubble_level/data/repositories/orientation_repository.dart';
import 'package:bubble_level/data/repositories/settings_repository.dart';
import 'package:bubble_level/domain/angles.dart';
import 'package:bubble_level/domain/height.dart';
import 'package:bubble_level/domain/ruler.dart';
import 'package:bubble_level/ui/features/height/view_models/height_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../helpers/fakes.dart';

Vec3 _pitched(double deg) {
  final r = deg * math.pi / 180;
  return Vec3(0, math.sin(r), math.cos(r));
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late FakeMotionSensorService sensors;
  late OrientationRepository orientation;
  late SettingsRepository settings;
  late HeightViewModel vm;

  /// Holds the phone at [deg] for [seconds] (the fake sends 50 a second).
  Future<void> aim(double deg, {double seconds = 1}) async {
    for (var i = 0; i < seconds * 50; i++) {
      sensors.sendUp(_pitched(deg));
      await flush();
    }
  }

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    settings = await SettingsRepository.load();
    sensors = FakeMotionSensorService();
    orientation = OrientationRepository(
      sensors: sensors,
      display: FakeDisplayRotationService(),
    );
    vm = HeightViewModel(orientation: orientation, settings: settings)
      ..active = true;
    await flush();
  });

  tearDown(() {
    vm.dispose();
    orientation.dispose();
  });

  test('base then top gives distance and height', () async {
    expect(vm.eyeHeight, SettingsRepository.defaultEyeHeight);
    expect(vm.step, HeightStep.base);
    await aim(-6, seconds: 2);
    expect(vm.live, closeTo(-6, 0.2));
    expect(vm.canLock, isTrue);
    vm.lock();
    expect(vm.step, HeightStep.top);
    expect(vm.distance, closeTo(15.22, 0.5));
    expect(vm.height, isNull);

    await aim(30, seconds: 2);
    vm.lock();
    expect(vm.step, HeightStep.done);
    expect(
      vm.height,
      closeTo(1.6 + vm.distance! * math.tan(math.pi / 6), 0.05),
    );

    // Measure again starts over.
    vm.lock();
    expect(vm.step, HeightStep.base);
    expect(vm.distance, isNull);
  });

  test('the jolt of the tap is not what gets locked', () async {
    await aim(-10, seconds: 2);
    // The thumb knocks the phone just as it taps.
    sensors.sendUp(_pitched(-25));
    await flush();
    vm.lock();
    expect(vm.baseAngle, closeTo(-10, 0.3));
  });

  test('a base too near level can\'t be locked, and says so', () async {
    await aim(-1);
    expect(vm.advice, SightAdvice.tooFar);
    expect(vm.canLock, isFalse);
    vm.lock();
    expect(vm.step, HeightStep.base);
  });

  test('a known distance skips the base', () async {
    vm.setKnownDistance(20);
    expect(vm.step, HeightStep.top);
    await aim(45, seconds: 2);
    expect(vm.advice, SightAdvice.ok);
    vm.lock();
    expect(vm.height, closeTo(21.6, 0.3));
    // Reset keeps the typed distance; clearing it goes back to the base.
    vm.reset();
    expect(vm.step, HeightStep.top);
    vm.setKnownDistance(null);
    expect(vm.step, HeightStep.base);
  });

  test('steep tops advise stepping back', () async {
    vm.setKnownDistance(5);
    await aim(75);
    expect(vm.advice, SightAdvice.stepBack);
    expect(vm.canLock, isTrue);
  });

  test('eye height is remembered; feet follow the ruler unit', () async {
    await vm.setEyeHeight(1.5);
    expect((await SettingsRepository.load()).eyeHeight, 1.5);
    expect(vm.imperial, isFalse);
    await settings.setRulerUnit(LengthUnit.inch);
    expect(vm.imperial, isTrue);
  });
}
