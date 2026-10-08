import 'package:bubble_level/data/repositories/settings_repository.dart';
import 'package:bubble_level/data/repositories/speed_repository.dart';
import 'package:bubble_level/data/services/location_service.dart';
import 'package:bubble_level/ui/features/speed/view_models/speed_view_model.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../helpers/fakes.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late FakeLocationService location;
  late SpeedRepository repository;
  late SettingsRepository settings;
  late SpeedViewModel vm;
  final t0 = DateTime(2026, 10, 7, 12);

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    settings = await SettingsRepository.load();
    location = FakeLocationService();
    repository = SpeedRepository(location: location);
    vm = SpeedViewModel(
      repository: repository,
      settings: settings,
      location: location,
    );
  });

  tearDown(() {
    vm.dispose();
    repository.dispose();
  });

  /// Drives north at [ms] m/s, one fix a second, for [seconds] seconds.
  Future<void> drive(double ms, int seconds) async {
    for (var i = 0; i <= seconds; i++) {
      location.send(
        lat: i * ms / 111194.9266,
        lon: 0,
        speed: ms,
        time: t0.add(Duration(seconds: i)),
      );
    }
    await flush();
  }

  test('not asked yet: explains first and listens to nothing', () async {
    vm.active = true;
    expect(vm.access, isNull, reason: 'finding out');
    await flush();
    expect(vm.access, LocationAccess.needed);
    expect(location.requested, 0);
    expect(location.listening, isFalse);
  });

  test('allowed: starts listening and fixes flow into the reading', () async {
    vm.active = true;
    await flush();
    var notified = 0;
    vm.addListener(() => notified++);
    await vm.allow();
    expect(location.requested, 1);
    expect(vm.access, LocationAccess.granted);
    expect(location.listening, isTrue);
    expect(vm.reading.hasFix, isFalse);

    location.send(
      lat: 51.5,
      lon: -0.12,
      speed: 8,
      accuracy: 6,
      altitude: 35,
      time: t0,
    );
    await flush();
    final r = vm.reading;
    expect(r.hasFix, isTrue);
    expect(r.speed, 8);
    expect(r.latitude, 51.5);
    expect(r.longitude, -0.12);
    expect(r.altitude, 35);
    expect(r.accuracy, 6);
    expect(notified, greaterThanOrEqualTo(2));
  });

  test('already allowed: starts at once without asking', () async {
    location.checkResult = LocationAccess.granted;
    vm.active = true;
    await flush();
    expect(vm.access, LocationAccess.granted);
    expect(location.requested, 0);
    expect(location.listening, isTrue);
  });

  testWidgets('refused, then still not allowed on return: denied', (
    tester,
  ) async {
    vm.active = true;
    await tester.pump();
    location.requestResult = LocationAccess.needed;
    await vm.allow();
    // Refused: straight to the Settings screen, not the explanation again.
    expect(vm.access, LocationAccess.denied);
    expect(location.listening, isFalse);

    // Back in front (for example from Settings): checked again, and a
    // still unanswered permission now points to Settings.
    for (final state in [
      AppLifecycleState.inactive,
      AppLifecycleState.hidden,
      AppLifecycleState.paused,
      AppLifecycleState.hidden,
      AppLifecycleState.inactive,
      AppLifecycleState.resumed,
    ]) {
      tester.binding.handleAppLifecycleStateChanged(state);
    }
    await tester.pump();
    expect(vm.access, LocationAccess.denied);
    expect(location.listening, isFalse);
  });

  test('refused for good: denied straight away', () async {
    vm.active = true;
    await flush();
    location.requestResult = LocationAccess.denied;
    await vm.allow();
    expect(vm.access, LocationAccess.denied);
    expect(location.listening, isFalse);
  });

  test('asked once and reopened while still not allowed: denied', () async {
    vm.active = true;
    await flush();
    location.requestResult = LocationAccess.needed;
    await vm.allow();
    vm.active = false;
    vm.active = true;
    await flush();
    expect(vm.access, LocationAccess.denied);
    expect(location.requested, 1);
  });

  test('location switched off: says so and listens to nothing', () async {
    location.checkResult = LocationAccess.serviceOff;
    vm.active = true;
    await flush();
    expect(vm.access, LocationAccess.serviceOff);
    expect(location.listening, isFalse);
  });

  test(
    'settings: location settings when off, app settings otherwise',
    () async {
      location.checkResult = LocationAccess.serviceOff;
      vm.active = true;
      await flush();
      await vm.openSettings();
      expect(location.locationSettingsOpened, 1);
      expect(location.appSettingsOpened, 0);

      location.requestResult = LocationAccess.denied;
      await vm.allow();
      await vm.openSettings();
      expect(location.locationSettingsOpened, 1);
      expect(location.appSettingsOpened, 1);
    },
  );

  test('turning location on and coming back starts listening', () async {
    location.checkResult = LocationAccess.serviceOff;
    vm.active = true;
    await flush();
    location.checkResult = LocationAccess.granted;
    vm.active = false;
    vm.active = true;
    await flush();
    expect(vm.access, LocationAccess.granted);
    expect(location.listening, isTrue);
  });

  test('resetTrip clears distance, top and average', () async {
    location.checkResult = LocationAccess.granted;
    vm.active = true;
    await flush();
    await drive(20, 10);
    expect(vm.reading.distance, closeTo(200, 1));
    expect(vm.reading.top, 20);
    var notified = 0;
    vm.addListener(() => notified++);
    vm.resetTrip();
    expect(notified, 1);
    expect(vm.reading.distance, 0);
    expect(vm.reading.top, 0);
    expect(vm.reading.average, 0);
    expect(vm.reading.speed, 20, reason: 'speed now stays');
  });

  test('toggleUnit flips to mph and is remembered', () async {
    vm.active = true;
    await flush();
    expect(vm.mph, isFalse);
    expect(vm.perHour(10), closeTo(36, 1e-9));
    var notified = 0;
    vm.addListener(() => notified++);
    vm.toggleUnit();
    await flush();
    expect(vm.mph, isTrue);
    expect(notified, greaterThanOrEqualTo(1));
    expect(vm.perHour(10), closeTo(22.369, 0.001));
    expect(vm.perHour(27.78), closeTo(62.14, 0.01));
    expect((await SettingsRepository.load()).speedMph, isTrue);

    vm.toggleUnit();
    await flush();
    expect(vm.mph, isFalse);
    expect(vm.perHour(27.78), closeTo(100, 0.01));
    expect(settings.speedMph, isFalse);
  });

  test('closing stops listening; reopening starts again', () async {
    location.checkResult = LocationAccess.granted;
    vm.active = true;
    await flush();
    expect(location.listening, isTrue);
    vm.active = false;
    expect(location.listening, isFalse);

    // Fixes while closed are not used.
    location.send(lat: 1, lon: 1, speed: 5, time: t0);
    await flush();
    expect(vm.reading.hasFix, isFalse);

    vm.active = true;
    await flush();
    expect(vm.access, LocationAccess.granted);
    expect(location.listening, isTrue);
  });

  test('closed before the check returns: starts nothing', () async {
    location.checkResult = LocationAccess.granted;
    vm.active = true;
    vm.active = false;
    await flush();
    expect(location.listening, isFalse);
  });
}
