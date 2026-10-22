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
  });

  testWidgets('Bluetooth off opens Bluetooth settings', (tester) async {
    bluetooth.checkResult = BluetoothAccess.bluetoothOff;
    await open(tester);
    await vm.openSettings();
    expect(bluetooth.bluetoothSettingsOpened, 1);
  });

  testWidgets('scan here: lists trackers away from their owners, stops '
      'after 30 s, and keeps the screen as it is', (tester) async {
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
    await tester.pump(TrackerViewModel.hereTime);
    expect(vm.mode, TrackerMode.idle);
    expect(bluetooth.listening, isFalse);
    expect(vm.trackers, hasLength(1), reason: 'what was heard stays listed');
  });

  testWidgets('on the move: a tag heard at 3 places over 30 minutes is '
      'following you; the screen stays on until stopped', (tester) async {
    await open(tester);
    await vm.checkWhileMoving();
    expect(vm.mode, TrackerMode.moving);
    expect(location.listening, isTrue);
    expect(bluetooth.screenKeptOn, isTrue);
    for (var i = 0; i <= 3; i++) {
      location.send(lat: 34.0 + i * 0.002, lon: 74.8, time: clock);
      airTag();
      await tester.pump(const Duration(milliseconds: 300));
      clock = clock.add(const Duration(minutes: 11));
    }
    expect(vm.placesPassed, 4);
    expect(vm.followingCount, 1);
    expect(FollowCheck.follows(vm.trackers.first), isTrue);
    vm.stop();
    expect(bluetooth.screenKeptOn, isFalse);
    expect(location.listening, isFalse);
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
    vm.stop();
  });

  testWidgets('finding follows one tag; done stops a short scan', (
    tester,
  ) async {
    await open(tester);
    vm.scanHere();
    airTag(rssi: -45);
    await tester.pump(const Duration(milliseconds: 300));
    vm.find('AA:00:00:00:00:01');
    expect(vm.mode, TrackerMode.find);
    expect(vm.finding!.rssi, -45);
    vm.doneFinding();
    expect(vm.mode, TrackerMode.idle);
    expect(bluetooth.listening, isFalse);
  });

  testWidgets('hidden app: stops listening; back in front: carries on', (
    tester,
  ) async {
    await open(tester);
    await vm.checkWhileMoving();
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.inactive);
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.hidden);
    await tester.pump();
    expect(bluetooth.listening, isFalse);
    expect(location.listening, isFalse);
    expect(vm.paused, isTrue);
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.inactive);
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
    await tester.pump();
    expect(bluetooth.listening, isTrue);
    expect(location.listening, isTrue);
    vm.stop();
  });

  testWidgets('closing the tool stops everything and forgets what was heard', (
    tester,
  ) async {
    await open(tester);
    await vm.checkWhileMoving();
    airTag();
    await tester.pump(const Duration(milliseconds: 300));
    vm.active = false;
    expect(bluetooth.listening, isFalse);
    expect(location.listening, isFalse);
    expect(bluetooth.screenKeptOn, isFalse);
    expect(vm.trackers, isEmpty);
  });
}
