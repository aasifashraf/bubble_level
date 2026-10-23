import 'dart:typed_data';

import 'package:bubble_level/data/repositories/settings_repository.dart';
import 'package:bubble_level/data/services/bluetooth_service.dart';
import 'package:bubble_level/data/services/location_service.dart';
import 'package:bubble_level/domain/tracker.dart';
import 'package:bubble_level/ui/features/tracker/view_models/tracker_view_model.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../helpers/fakes.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late FakeBluetoothService bluetooth;
  late FakeLocationService location;
  late SettingsRepository settings;
  late TrackerViewModel vm;
  late DateTime clock;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    settings = await SettingsRepository.load();
    bluetooth = FakeBluetoothService()..checkResult = BluetoothAccess.granted;
    location = FakeLocationService()..checkResult = LocationAccess.granted;
    clock = DateTime(2026, 10, 22, 9);
    vm = TrackerViewModel(
      settings: settings,
      bluetooth: bluetooth,
      location: location,
      now: () => clock,
    );
  });

  tearDown(() => vm.dispose());

  /// An AirTag away from its owner, as `Ble.kt` would hear it.
  void airTag({String address = 'AA:00:00:00:00:01', int rssi = -60}) =>
      bluetooth.signalsController.add(
        BleSignal(
          address: address,
          rssi: rssi,
          time: clock,
          manufacturerData: {
            appleCompanyId: Uint8List.fromList([0x12, 0x19, 0x10, 0]),
          },
        ),
      );

  Future<void> open(WidgetTester tester) async {
    vm.active = true;
    await tester.pump();
  }

  /// Closes the tool, so no timer outlives the test.
  void close() => vm.active = false;

  /// Moves on, [minutes] later, about 330 m further north.
  Future<void> step(WidgetTester tester, int i, {double accuracy = 5}) async {
    location.send(
      lat: 34.0 + i * 0.003,
      lon: 74.8,
      accuracy: accuracy,
      time: clock,
    );
    airTag();
    await tester.pump(const Duration(milliseconds: 300));
    clock = clock.add(const Duration(minutes: 11));
  }

  testWidgets('asks once, then a refusal points to Settings', (tester) async {
    bluetooth.checkResult = BluetoothAccess.needed;
    bluetooth.requestResult = BluetoothAccess.needed;
    await open(tester);
    expect(vm.access, BluetoothAccess.needed);
    await vm.allow();
    expect(bluetooth.requested, 1);
    expect(vm.access, BluetoothAccess.denied);
    await vm.openSettings();
    expect(bluetooth.appSettingsOpened, 1);
    close();
  });

  testWidgets('Bluetooth switched off in the quick settings is noticed '
      'without leaving the app, and so is switching it back on', (
    tester,
  ) async {
    bluetooth.checkResult = BluetoothAccess.bluetoothOff;
    await open(tester);
    await vm.openSettings();
    expect(bluetooth.bluetoothSettingsOpened, 1);
    bluetooth.checkResult = BluetoothAccess.granted;
    await tester.pump(const Duration(seconds: 3));
    expect(vm.access, BluetoothAccess.granted);
    close();
  });

  testWidgets('scan here: lists trackers away from their owners and stops '
      'after 30 s; a quick Scan again reuses the scan', (tester) async {
    await open(tester);
    vm.scanHere();
    expect(bluetooth.listening, isTrue);
    expect(bluetooth.screenKeptOn, isFalse);
    airTag();
    // An AirTag next to its owner (short key) is left out.
    bluetooth.signalsController.add(
      BleSignal(
        address: 'AA:00:00:00:00:02',
        rssi: -50,
        time: clock,
        manufacturerData: {
          appleCompanyId: Uint8List.fromList([0x12, 0x02, 0x10]),
        },
      ),
    );
    await tester.pump(const Duration(milliseconds: 300));
    expect(vm.trackers.map((t) => t.id), ['AA:00:00:00:00:01']);
    expect(vm.followingCount, 0);
    clock = clock.add(TrackerViewModel.hereTime);
    await tester.pump(TrackerViewModel.hereTime);
    expect(vm.mode, TrackerMode.idle);
    expect(vm.scanning, isFalse);
    expect(vm.listenedEnough, isTrue);
    expect(vm.trackers, hasLength(1), reason: 'what was heard stays listed');
    // Lingers a few seconds, then really stops.
    await tester.pump(const Duration(seconds: 7));
    expect(bluetooth.listening, isFalse);
    close();
  });

  testWidgets('hiding the app ends a short scan; it does not run on later', (
    tester,
  ) async {
    await open(tester);
    vm.scanHere();
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.inactive);
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.hidden);
    await tester.pump();
    expect(bluetooth.listening, isFalse);
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.inactive);
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
    await tester.pump();
    expect(vm.mode, TrackerMode.idle);
    expect(bluetooth.listening, isFalse);
    expect(vm.listenedEnough, isFalse, reason: 'no "nothing heard"');
    close();
  });

  testWidgets('a scan that stops by itself says so and lets go of it', (
    tester,
  ) async {
    await open(tester);
    vm.scanHere();
    bluetooth
      ..checkResult = BluetoothAccess.bluetoothOff
      ..signalsController.addError(Exception('off'));
    await tester.pump();
    expect(vm.scanFailed, isTrue);
    expect(vm.mode, TrackerMode.idle);
    expect(bluetooth.listening, isFalse);
    expect(vm.access, BluetoothAccess.bluetoothOff);
    close();
  });

  testWidgets('on the move: a tag heard at 3 places over 30 minutes is '
      'following you; the screen stays on until stopped', (tester) async {
    await open(tester);
    await vm.checkWhileMoving();
    expect(vm.mode, TrackerMode.moving);
    expect(location.listening, isTrue);
    expect(bluetooth.screenKeptOn, isTrue);
    for (var i = 0; i <= 3; i++) {
      await step(tester, i);
    }
    expect(vm.placesPassed, 4);
    expect(vm.followingCount, 1);
    expect(FollowCheck.follows(vm.trackers.first), isTrue);
    vm.stop();
    expect(bluetooth.screenKeptOn, isFalse);
    expect(location.listening, isFalse);
    close();
  });

  testWidgets('GPS fixes count by when they arrive, so a phone clock far '
      'from GPS time still notes places', (tester) async {
    await open(tester);
    await vm.checkWhileMoving();
    for (var i = 0; i <= 3; i++) {
      location.send(
        lat: 34.0 + i * 0.003,
        lon: 74.8,
        time: clock.subtract(const Duration(hours: 3)),
      );
      airTag();
      await tester.pump(const Duration(milliseconds: 300));
      clock = clock.add(const Duration(minutes: 11));
    }
    expect(vm.followingCount, 1);
    close();
  });

  testWidgets('rough fixes at one café table never make places', (
    tester,
  ) async {
    await open(tester);
    await vm.checkWhileMoving();
    for (var i = 0; i <= 5; i++) {
      // 90 m accurate, jumping about 170 m around one spot.
      location.send(
        lat: 34.0 + (i.isEven ? 0.0015 : -0.0001),
        lon: 74.8,
        accuracy: 90,
        time: clock,
      );
      airTag();
      await tester.pump(const Duration(milliseconds: 300));
      clock = clock.add(const Duration(minutes: 10));
    }
    expect(vm.trackers.single.places, hasLength(1));
    expect(vm.followingCount, 0);
    close();
  });

  testWidgets('no GPS fix for a while on the move says so', (tester) async {
    await open(tester);
    await vm.checkWhileMoving();
    location.send(lat: 34.0, lon: 74.8, time: clock);
    await tester.pump(const Duration(milliseconds: 300));
    expect(vm.gpsLost, isFalse);
    clock = clock.add(const Duration(seconds: 40));
    await tester.pump(const Duration(seconds: 1));
    expect(vm.gpsLost, isTrue);
    close();
  });

  testWidgets('trackers not heard for a minute leave the rings, followers '
      'stay', (tester) async {
    await open(tester);
    vm.scanHere();
    airTag();
    await tester.pump(const Duration(milliseconds: 300));
    expect(vm.nearby, hasLength(1));
    clock = clock.add(const Duration(seconds: 61));
    await tester.pump(const Duration(seconds: 1));
    expect(vm.nearby, isEmpty);
    expect(vm.trackers, hasLength(1));
    close();
  });

  testWidgets('on the move without location says so and starts nothing', (
    tester,
  ) async {
    location
      ..checkResult = LocationAccess.needed
      ..requestResult = LocationAccess.denied;
    await open(tester);
    await vm.checkWhileMoving();
    expect(vm.mode, TrackerMode.idle);
    expect(vm.locationProblem, LocationAccess.denied);
    expect(bluetooth.listening, isFalse);
    close();
  });

  testWidgets('"This is mine" hides a tracker for good, and can be undone', (
    tester,
  ) async {
    await open(tester);
    vm.scanHere();
    airTag();
    await tester.pump(const Duration(milliseconds: 300));
    await vm.toggleMine('AA:00:00:00:00:01');
    expect(vm.trackers, isEmpty);
    expect(vm.mineHeard.single.id, 'AA:00:00:00:00:01');
    expect((await SettingsRepository.load()).trackerMine, {
      'AA:00:00:00:00:01',
    });
    await vm.toggleMine('AA:00:00:00:00:01');
    expect(vm.trackers, hasLength(1));
    close();
  });

  testWidgets('finding: "not heard" once it goes quiet; done stops a short '
      'scan', (tester) async {
    await open(tester);
    vm.scanHere();
    airTag(rssi: -45);
    await tester.pump(const Duration(milliseconds: 300));
    vm.find('AA:00:00:00:00:01');
    expect(vm.mode, TrackerMode.find);
    expect(vm.findingHeard, isTrue);
    expect(vm.finding!.rssi, -45);
    clock = clock.add(const Duration(seconds: 16));
    await tester.pump(const Duration(seconds: 1));
    expect(vm.findingHeard, isFalse);
    vm.doneFinding();
    expect(vm.mode, TrackerMode.idle);
    await tester.pump(const Duration(seconds: 7));
    expect(bluetooth.listening, isFalse);
    close();
  });

  testWidgets('finding during a check on the move carries the check on', (
    tester,
  ) async {
    await open(tester);
    await vm.checkWhileMoving();
    await step(tester, 0);
    vm.find('AA:00:00:00:00:01');
    vm.doneFinding();
    expect(vm.mode, TrackerMode.moving);
    expect(location.listening, isTrue);
    expect(bluetooth.screenKeptOn, isTrue);
    close();
  });

  testWidgets('hidden app: stops listening and the clock; back in front: '
      'carries on', (tester) async {
    await open(tester);
    await vm.checkWhileMoving();
    clock = clock.add(const Duration(minutes: 5));
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.inactive);
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.hidden);
    await tester.pump();
    expect(bluetooth.listening, isFalse);
    expect(location.listening, isFalse);
    expect(vm.paused, isTrue);
    clock = clock.add(const Duration(minutes: 20));
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.inactive);
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
    await tester.pump();
    expect(bluetooth.listening, isTrue);
    expect(location.listening, isTrue);
    expect(vm.listenedFor, const Duration(minutes: 5));
    close();
  });

  testWidgets('closing the tool stops everything and forgets what was heard', (
    tester,
  ) async {
    await open(tester);
    await vm.checkWhileMoving();
    airTag();
    await tester.pump(const Duration(milliseconds: 300));
    close();
    expect(bluetooth.listening, isFalse);
    expect(location.listening, isFalse);
    expect(bluetooth.screenKeptOn, isFalse);
    expect(vm.trackers, isEmpty);
  });
}
