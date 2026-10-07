import 'dart:math' as math;

import 'package:bubble_level/data/repositories/orientation_repository.dart';
import 'package:bubble_level/data/repositories/settings_repository.dart';
import 'package:bubble_level/domain/angles.dart';
import 'package:bubble_level/ui/features/camera/view_models/camera_level_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../helpers/fakes.dart';

Vec3 _turned(double deg) {
  final r = deg * math.pi / 180;
  return Vec3(math.sin(r), math.cos(r), 0);
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late FakeMotionSensorService sensors;
  late OrientationRepository orientation;
  late SettingsRepository settings;
  late FakeCameraService camera;
  late CameraLevelViewModel vm;
  var levels = 0;

  Future<void> hold(double deg) async {
    for (var i = 0; i < 60; i++) {
      sensors.sendUp(_turned(deg));
    }
    await flush();
  }

  Future<void> setUpWith(Map<String, Object> prefs) async {
    SharedPreferences.setMockInitialValues(prefs);
    settings = await SettingsRepository.load();
    sensors = FakeMotionSensorService();
    orientation = OrientationRepository(
      sensors: sensors,
      display: FakeDisplayRotationService(),
    );
    camera = FakeCameraService();
    levels = 0;
    vm = CameraLevelViewModel(
      orientation: orientation,
      settings: settings,
      camera: camera,
      onLevelReached: () => levels++,
    );
  }

  tearDown(() {
    vm.dispose();
    orientation.dispose();
  });

  test(
    'explains first; the camera starts only on Allow, then by itself',
    () async {
      await setUpWith({});
      vm.active = true;
      expect(vm.access, CameraAccess.needed);
      expect(camera.opened, 0);
      await vm.allow();
      expect(vm.access, CameraAccess.granted);
      expect(vm.feed, isNotNull);
      expect(settings.cameraAllowed, isTrue);

      // Closing lets the camera go; next time it starts straight away.
      final first = camera.feed!;
      vm.active = false;
      expect(first.disposed, isTrue);
      vm.active = true;
      await flush();
      expect(vm.access, CameraAccess.granted);
      expect(camera.opened, 2);
    },
  );

  test('refused: points to Settings; no camera: says so', () async {
    await setUpWith({});
    vm.active = true;
    camera.result = FakeCameraResult.denied;
    await vm.allow();
    expect(vm.access, CameraAccess.denied);
    await vm.openSettings();
    expect(camera.settingsOpened, 1);
    camera.result = FakeCameraResult.missing;
    await vm.allow();
    expect(vm.access, CameraAccess.missing);
  });

  test('tilt, level with a tap, freeze holds it', () async {
    await setUpWith({'cameraAllowed': true});
    vm.active = true;
    await flush();
    await hold(2);
    expect(vm.pose!.tilt, closeTo(2, 0.1));
    expect(vm.level, isFalse);
    await hold(0.2);
    expect(vm.level, isTrue);
    expect(levels, 1);

    await vm.toggleFreeze();
    expect(camera.feed!.frozen, isTrue);
    await hold(5);
    expect(vm.pose!.tilt, closeTo(0.2, 0.1));
    await vm.toggleFreeze();
    expect(vm.pose!.tilt, closeTo(5, 0.1));
  });

  test('the light, hidden when the camera has none', () async {
    await setUpWith({'cameraAllowed': true});
    vm.active = true;
    await flush();
    await vm.toggleTorch();
    expect(vm.torch, isTrue);
    expect(camera.feed!.torchOn, isTrue);
    vm.active = false;
    expect(vm.torch, isFalse);

    vm.dispose();
    camera = FakeCameraService(torch: false);
    vm = CameraLevelViewModel(
      orientation: orientation,
      settings: settings,
      camera: camera,
    )..active = true;
    await flush();
    await vm.toggleTorch();
    expect(vm.torchAvailable, isFalse);
  });

  test('square size is remembered', () async {
    await setUpWith({});
    expect(vm.gridSize, 1);
    vm.setGridSize(2);
    await flush();
    expect((await SettingsRepository.load()).cameraGrid, 2);
  });
}
