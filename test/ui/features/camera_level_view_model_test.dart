import 'dart:math' as math;

import 'package:bubble_level/data/repositories/orientation_repository.dart';
import 'package:bubble_level/data/repositories/settings_repository.dart';
import 'package:bubble_level/domain/angles.dart';
import 'package:bubble_level/ui/features/camera/view_models/camera_level_view_model.dart';
import 'package:flutter/widgets.dart';
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

  test('lines can be hidden; frozen, the handles read an edge', () async {
    await setUpWith({'cameraAllowed': true});
    vm
      ..active = true
      ..area = const Size(400, 600);
    await flush();
    vm.togglePhoneLines();
    expect(vm.showPhone, isFalse);
    vm.toggleTrueLines();
    expect(vm.showTrue, isFalse);

    // The phone turned 3° counter-clockwise: true level runs at +3°.
    await hold(3);
    expect(vm.edge, isNull);
    await vm.toggleFreeze();
    final h = vm.handles!;
    expect(h[0].dy, h[1].dy, reason: 'starts across the screen');
    // Level on the screen, so 3° off true level, the left end low.
    expect(vm.edge!.offset, closeTo(-3, 0.1));
    // Laid along true level, it reads level.
    final r = 3 * math.pi / 180;
    vm.moveHandle(1, h[0] + Offset(math.cos(r), math.sin(r)) * 180);
    expect(vm.edge!.offset, closeTo(0, 0.1));
    expect(vm.edge!.plumb, isFalse);
    // Upright: measured against plumb.
    vm.moveHandle(
      1,
      h[0] + Offset(-math.sin(r), math.cos(r)) * 180 + const Offset(-6.3, 0),
    );
    expect(vm.edge!.plumb, isTrue);
    expect(vm.edge!.offset.abs(), closeTo(2, 0.1));
    // Handles stay inside the picture; Resume forgets them.
    vm.moveHandle(0, const Offset(-50, 900));
    expect(vm.handles![0], const Offset(0, 600));
    await vm.toggleFreeze();
    expect(vm.handles, isNull);
    expect(vm.edge, isNull);
  });
}
