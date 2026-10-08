import 'package:bubble_level/data/repositories/g_force_repository.dart';
import 'package:bubble_level/domain/angles.dart';
import 'package:bubble_level/domain/g_force.dart';
import 'package:bubble_level/domain/orientation_reading.dart';
import 'package:bubble_level/ui/features/g_force/view_models/g_force_view_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/fakes.dart';

/// Phone upright in portrait in a car mount, screen facing the driver:
/// the car's up, forward and right in the phone's frame.
const _up = Vec3(0, 1, 0), _forward = Vec3(0, 0, -1), _right = Vec3(1, 0, 0);

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late FakeMotionSensorService sensors;
  late GForceRepository repo;
  late GForceViewModel vm;

  setUp(() {
    sensors = FakeMotionSensorService();
    repo = GForceRepository(sensors: sensors);
    vm = GForceViewModel(repository: repo);
    addTearDown(() {
      vm.dispose();
      repo.dispose();
    });
  });

  /// [samples] at 50 Hz of the car's acceleration, [forward] and [right]
  /// in g, on top of gravity for a phone whose up is [up].
  Future<void> drive(
    int samples, {
    double forward = 0,
    double right = 0,
    Vec3 up = _up,
    Vec3 fwd = _forward,
    Vec3 rgt = _right,
  }) async {
    for (var i = 0; i < samples; i++) {
      sensors.sendAccel(
        up * standardGravity +
            fwd * (forward * standardGravity) +
            rgt * (right * standardGravity),
      );
    }
    await flush();
  }

  test('runs the accelerometer only while active', () async {
    expect(sensors.accel.hasListener, isFalse);
    vm.active = true;
    expect(sensors.accel.hasListener, isTrue);
    vm.active = false;
    expect(sensors.accel.hasListener, isFalse);
  });

  test('zeroes itself on opening', () async {
    vm.active = true;
    expect(vm.reading.zeroed, isFalse);
    await drive(30);
    expect(vm.reading.zeroed, isTrue);
    expect(vm.reading.state, SensorState.ok);
    expect(vm.reading.total, closeTo(0, 1e-6));
    expect(vm.motion, GMotion.steady);
    expect(vm.strength, closeTo(0, 1e-6));
  });

  test('notifies listeners as samples arrive', () async {
    var notified = 0;
    vm
      ..addListener(() => notified++)
      ..active = true;
    await drive(10);
    expect(notified, greaterThanOrEqualTo(10));
  });

  group('motion and strength', () {
    setUp(() async {
      vm.active = true;
      await drive(30);
    });

    test('braking', () async {
      await drive(150, forward: -0.5);
      expect(vm.motion, GMotion.braking);
      expect(vm.strength, closeTo(0.5, 1e-3));
      expect(vm.reading.peakBrake, closeTo(0.5, 1e-3));
    });

    test('speeding up', () async {
      await drive(150, forward: 0.3);
      expect(vm.motion, GMotion.speedingUp);
      expect(vm.strength, closeTo(0.3, 1e-3));
      expect(vm.reading.peakSpeedUp, closeTo(0.3, 1e-3));
    });

    test('left bend: the car accelerates left, you are pushed right', () async {
      await drive(150, right: -0.4);
      expect(vm.reading.lat, closeTo(0.4, 1e-3));
      expect(vm.motion, GMotion.leftBend);
      expect(vm.strength, closeTo(0.4, 1e-3));
    });

    test('right bend', () async {
      await drive(150, right: 0.4);
      expect(vm.reading.lat, closeTo(-0.4, 1e-3));
      expect(vm.motion, GMotion.rightBend);
      expect(vm.strength, closeTo(0.4, 1e-3));
    });

    test('the larger push wins: braking in a gentle bend', () async {
      await drive(150, forward: -0.4, right: -0.2);
      expect(vm.motion, GMotion.braking);
      expect(vm.strength, closeTo(0.4, 1e-3));
    });

    test('steady below the threshold, back to steady after', () async {
      await drive(150, forward: GForceViewModel.steadyBelow / 2);
      expect(vm.motion, GMotion.steady);
      expect(vm.strength, lessThan(GForceViewModel.steadyBelow));
      await drive(150, forward: -0.5);
      expect(vm.motion, GMotion.braking);
      await drive(200);
      expect(vm.motion, GMotion.steady);
    });

    test('thresholds are in order', () {
      expect(GForceViewModel.steadyBelow, lessThan(GForceViewModel.firmAt));
      expect(GForceViewModel.firmAt, lessThan(GForceViewModel.hardAt));
    });
  });

  test('zero re-learns after the phone is re-mounted', () async {
    vm.active = true;
    await drive(30);
    // Re-mounted lying flat: gravity alone now looks like hard braking.
    const flatUp = Vec3(0, 0, 1), flatForward = Vec3(0, 1, 0);
    await drive(50, up: flatUp, fwd: flatForward);
    expect(vm.motion, GMotion.braking);
    expect(vm.strength, greaterThan(0.9));

    vm.zero();
    expect(vm.reading.zeroed, isTrue);
    expect(vm.reading.total, 0);
    expect(vm.reading.peakBrake, 0);
    await drive(50, up: flatUp, fwd: flatForward);
    expect(vm.motion, GMotion.steady);

    // Now speeding up reads true in the new position.
    await drive(150, up: flatUp, fwd: flatForward, forward: 0.3);
    expect(vm.motion, GMotion.speedingUp);
    expect(vm.strength, closeTo(0.3, 1e-3));
  });

  test('zero does nothing before there are samples', () async {
    vm.active = true;
    vm.zero();
    expect(vm.reading.zeroed, isFalse);
    expect(vm.reading.state, SensorState.waiting);
  });

  test('resetPeaks clears the peaks, keeps the live reading', () async {
    vm.active = true;
    await drive(30);
    await drive(150, forward: -0.5);
    await drive(150, right: -0.4);
    expect(vm.reading.peakBrake, greaterThan(0.4));
    expect(vm.reading.peakCorner, greaterThan(0.3));

    vm.resetPeaks();
    expect(vm.reading.peakBrake, 0);
    expect(vm.reading.peakCorner, 0);
    expect(vm.reading.peakSpeedUp, 0);
    expect(vm.reading.peaks.every((p) => p == 0), isTrue);
    expect(vm.reading.zeroed, isTrue);
    expect(vm.reading.lat, closeTo(0.4, 1e-3));
  });

  test('starts fresh each time it opens', () async {
    vm.active = true;
    await drive(30);
    await drive(150, forward: -0.5);
    expect(vm.reading.peakBrake, greaterThan(0.4));

    vm
      ..active = false
      ..active = true;
    expect(vm.reading.zeroed, isFalse);
    expect(vm.reading.peakBrake, 0);
    expect(vm.reading.lon, 0);
    expect(vm.reading.peaks, isEmpty);

    // And zeroes itself again on the new mount.
    const flatUp = Vec3(0, 0, 1), flatForward = Vec3(0, 1, 0);
    await drive(30, up: flatUp, fwd: flatForward);
    expect(vm.reading.zeroed, isTrue);
    expect(vm.motion, GMotion.steady);
    await drive(150, up: flatUp, fwd: flatForward, forward: -0.5);
    expect(vm.motion, GMotion.braking);
    expect(vm.strength, closeTo(0.5, 1e-3));
  });

  test('a phone without an accelerometer reports missing', () async {
    vm.active = true;
    sensors.accel.addError(Exception('NO_SENSOR'));
    await flush();
    expect(vm.reading.state, SensorState.missing);
    expect(vm.reading.zeroed, isFalse);
    expect(vm.motion, GMotion.steady);
  });
}
