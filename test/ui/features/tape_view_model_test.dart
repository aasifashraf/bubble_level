import 'package:bubble_level/data/repositories/settings_repository.dart';
import 'package:bubble_level/data/services/ar_service.dart';
import 'package:bubble_level/domain/angles.dart';
import 'package:bubble_level/domain/ruler.dart';
import 'package:bubble_level/ui/features/tape/view_models/tape_view_model.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../helpers/fakes.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late FakeArService ar;
  late SettingsRepository settings;
  late TapeViewModel vm;
  late int placed;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    settings = await SettingsRepository.load();
    ar = FakeArService();
    placed = 0;
    vm = TapeViewModel(settings: settings, ar: ar, onPlaced: () => placed++);
  });

  tearDown(() => vm.dispose());

  /// Opens the tool in a 400 by 800 view and lets AR start.
  Future<void> open() async {
    vm.active = true;
    await flush();
    vm.layout(const Size(400, 800), 2);
    await flush();
  }

  // Corners two metres in front of the camera (see FakeArService.send):
  // a at the middle of the view, b one metre right, c one metre up from b.
  const a = Vec3(0, 0, -2), b = Vec3(1, 0, -2), c = Vec3(1, 1, -2);

  Future<void> tapAt(Vec3 aim) async {
    ar.send(aim: aim);
    await vm.add();
    ar.send(aim: aim);
    await flush();
  }

  test('allowed and supported: AR starts once laid out', () async {
    vm.active = true;
    await flush();
    expect(ar.started, 0, reason: 'waits for the view size');
    vm.layout(const Size(400, 800), 2);
    await flush();
    expect(ar.started, 1);
    expect(vm.access, TapeAccess.granted);
    expect(vm.texture, 7);
    expect(ar.listening, isTrue);
  });

  test('a phone without ARCore says so and never starts', () async {
    ar.supportResult = ArSupport.unsupported;
    await open();
    expect(vm.access, TapeAccess.unsupported);
    expect(ar.started, 0);
  });

  test('ARCore missing: offers the install, then starts', () async {
    ar.supportResult = ArSupport.install;
    await open();
    expect(vm.access, TapeAccess.install);
    await vm.install();
    await flush();
    expect(vm.access, TapeAccess.granted);
    expect(ar.started, 1);
  });

  test('camera not allowed: explains, asks, then starts', () async {
    ar.cameraAllowed = false;
    await open();
    expect(vm.access, TapeAccess.needed);
    expect(ar.requested, 0);
    await vm.allow();
    await flush();
    expect(ar.requested, 1);
    expect(vm.access, TapeAccess.granted);
    expect(settings.cameraAllowed, isTrue);
  });

  test('camera refused: points to Settings', () async {
    ar.cameraAllowed = false;
    ar.requestResult = false;
    await open();
    await vm.allow();
    expect(vm.access, TapeAccess.denied);
    await vm.openSettings();
    expect(ar.appSettingsOpened, 1);
    expect(ar.started, 0);
  });

  test('the camera busy: fails with a retry', () async {
    ar.startError = const ArStartFailed('camera');
    await open();
    expect(vm.access, TapeAccess.failed);
    ar.startError = null;
    await vm.retry();
    await flush();
    expect(vm.access, TapeAccess.granted);
  });

  test('a lost camera mid-session fails', () async {
    await open();
    ar.framesController.add(const ArFrame(error: 'camera'));
    await flush();
    expect(vm.access, TapeAccess.failed);
    expect(ar.stopped, 1);
  });

  test('taps chain pieces; the live piece follows the aim', () async {
    await open();
    await tapAt(a);
    expect(vm.shape.points, hasLength(1));
    expect(placed, 1);
    ar.send(aim: b);
    await flush();
    expect(vm.live, b);
    expect(vm.shape.total(live: vm.live), closeTo(1, 1e-9));
    await tapAt(b);
    expect(vm.shape.pieces(), [closeTo(1, 1e-9)]);
    expect(placed, 2);
  });

  test(
    'a tap with no surface under the aim adds nothing and says so',
    () async {
      await open();
      ar.send();
      await vm.add();
      expect(vm.shape.points, isEmpty);
      expect(vm.missed, isTrue);
      expect(placed, 0);
    },
  );

  test('back at the first point it snaps, and the tap closes the shape', () {
    return TestAsyncUtils.guard(() async {
      await open();
      await tapAt(a);
      await tapAt(b);
      expect(vm.snapping, isFalse, reason: 'needs three corners');
      await tapAt(c);
      // A little off the first point, within the snap.
      ar.send(aim: const Vec3(0.05, 0.05, -2));
      await flush();
      expect(vm.snapping, isTrue);
      expect(vm.live, a);
      await vm.add();
      expect(vm.shape.closed, isTrue);
      expect(vm.shape.area, closeTo(0.5, 1e-9));
      expect(vm.shape.total(), closeTo(2 + 1.4142135623, 1e-6));
      expect(vm.live, isNull);
      expect(placed, 4);
      expect(ar.points, hasLength(3), reason: 'closing adds no point');
    });
  });

  test('far from the first point it does not snap', () async {
    await open();
    await tapAt(a);
    await tapAt(b);
    await tapAt(c);
    ar.send(aim: const Vec3(0.5, 0.5, -2));
    await flush();
    expect(vm.snapping, isFalse);
    expect(vm.live, const Vec3(0.5, 0.5, -2));
  });

  test(
    'undo opens a closed shape, then takes points away; clear empties',
    () async {
      await open();
      await tapAt(a);
      await tapAt(b);
      await tapAt(c);
      ar.send(aim: a);
      await flush();
      await vm.add();
      expect(vm.shape.closed, isTrue);
      await vm.undo();
      expect(vm.shape.closed, isFalse);
      expect(ar.points, hasLength(3));
      await vm.undo();
      ar.send(aim: a);
      await flush();
      expect(vm.shape.points, hasLength(2));
      await vm.clear();
      ar.send(aim: a);
      await flush();
      expect(vm.shape.points, isEmpty);
    },
  );

  test('the unit is shared with the ruler', () async {
    await open();
    expect(vm.inches, isFalse);
    vm.toggleUnit();
    await flush();
    expect(settings.rulerUnit, LengthUnit.inch);
    expect(vm.inches, isTrue);
  });

  test('closing the tool stops AR and forgets the shape', () async {
    await open();
    await tapAt(a);
    vm.active = false;
    await flush();
    expect(ar.stopped, 1);
    expect(ar.listening, isFalse);
    expect(vm.texture, isNull);
    expect(vm.shape.points, isEmpty);
  });
}
