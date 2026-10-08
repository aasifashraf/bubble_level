import 'dart:math' as math;

import 'package:bubble_level/domain/angles.dart';
import 'package:bubble_level/domain/g_force.dart';
import 'package:bubble_level/domain/orientation_reading.dart';
import 'package:flutter_test/flutter_test.dart';

/// How a phone sits in the mount: the car's up, forward and right, each
/// given in the phone's own frame (x right edge, y top edge, z out of the
/// screen).
typedef Mount = ({Vec3 up, Vec3 forward, Vec3 right});

const _d2r = math.pi / 180;

/// Upright in portrait, screen facing the driver.
const Mount portrait = (
  up: Vec3(0, 1, 0),
  forward: Vec3(0, 0, -1),
  right: Vec3(1, 0, 0),
);

/// Upright, its top edge leaning back (towards the car's front) by [deg].
Mount tiltedBack(double deg) {
  final c = math.cos(deg * _d2r), s = math.sin(deg * _d2r);
  return (
    up: Vec3(0, c, s),
    forward: Vec3(0, s, -c),
    right: const Vec3(1, 0, 0),
  );
}

/// Upright in landscape, its right edge up.
const Mount landscape = (
  up: Vec3(1, 0, 0),
  forward: Vec3(0, 0, -1),
  right: Vec3(0, -1, 0),
);

/// Lying flat, screen up, top edge towards the car's front.
const Mount flat = (
  up: Vec3(0, 0, 1),
  forward: Vec3(0, 1, 0),
  right: Vec3(1, 0, 0),
);

/// Feeds a [GMeter] at 50 Hz with explicit timestamps.
class Drive {
  Drive(this.mount, {double smoothing = 0.25})
    : meter = GMeter(smoothing: smoothing);

  final Mount mount;
  final GMeter meter;
  double t = 0;

  static const dt = 0.02;

  /// One sample: gravity plus the car's acceleration, [forward] and
  /// [right] in g.
  void sample({double forward = 0, double right = 0}) {
    t += dt;
    final raw =
        mount.up * standardGravity +
        mount.forward * (forward * standardGravity) +
        mount.right * (right * standardGravity);
    meter.add(raw, t);
  }

  void hold(double seconds, {double forward = 0, double right = 0}) {
    for (var i = 0; i < (seconds / dt).round(); i++) {
      sample(forward: forward, right: right);
    }
  }

  /// Stands still for a moment, then zeroes.
  void park() {
    hold(0.6);
    expect(meter.zero(), isTrue);
    // One steady sample so smoothing has a time to count from.
    sample();
  }

  GReading get reading => meter.reading(SensorState.ok);
}

void main() {
  group('GMeter zero and axes', () {
    final mounts = <String, Mount>{
      'upright in portrait': portrait,
      'tilted back 20°': tiltedBack(20),
      'in landscape': landscape,
      'lying flat': flat,
    };

    for (final MapEntry(key: name, value: mount) in mounts.entries) {
      group(name, () {
        test('reads zero standing still after Zero', () {
          final d = Drive(mount)..park();
          d.hold(1);
          expect(d.reading.zeroed, isTrue);
          expect(d.reading.lon, closeTo(0, 1e-9));
          expect(d.reading.lat, closeTo(0, 1e-9));
          expect(d.reading.total, closeTo(0, 1e-9));
        });

        test('speeding up 0.3 g reads lon +0.3', () {
          final d = Drive(mount)..park();
          d.hold(3, forward: 0.3);
          expect(d.reading.lon, closeTo(0.3, 1e-3));
          expect(d.reading.lat, closeTo(0, 1e-6));
        });

        test('braking 0.5 g reads lon -0.5', () {
          final d = Drive(mount)..park();
          d.hold(3, forward: -0.5);
          expect(d.reading.lon, closeTo(-0.5, 1e-3));
          expect(d.reading.lat, closeTo(0, 1e-6));
          expect(d.reading.total, closeTo(0.5, 1e-3));
        });

        test('a left bend (0.4 g to the left) reads lat +0.4', () {
          final d = Drive(mount)..park();
          d.hold(3, right: -0.4);
          expect(d.reading.lat, closeTo(0.4, 1e-3));
          expect(d.reading.lon, closeTo(0, 1e-6));
        });

        test('a right bend (0.4 g to the right) reads lat -0.4', () {
          final d = Drive(mount)..park();
          d.hold(3, right: 0.4);
          expect(d.reading.lat, closeTo(-0.4, 1e-3));
        });
      });
    }

    test('reads nothing before Zero', () {
      final d = Drive(portrait)..hold(1, forward: 0.5);
      expect(d.reading.zeroed, isFalse);
      expect(d.reading.lon, 0);
      expect(d.reading.lat, 0);
      expect(d.reading.state, SensorState.ok);
    });
  });

  group('GMeter smoothing', () {
    test('a sudden step reaches about 63% after one time constant', () {
      final d = Drive(portrait, smoothing: 0.2)..park();
      d.hold(0.2, forward: 1);
      expect(d.reading.lon, closeTo(1 - math.exp(-1), 0.03));
      d.hold(3, forward: 1);
      expect(d.reading.lon, closeTo(1, 1e-3));
    });

    test('rises steadily without overshoot', () {
      final d = Drive(portrait)..park();
      var previous = 0.0;
      for (var i = 0; i < 150; i++) {
        d.sample(forward: 0.5);
        expect(d.reading.lon, greaterThanOrEqualTo(previous));
        expect(d.reading.lon, lessThanOrEqualTo(0.5 + 1e-9));
        previous = d.reading.lon;
      }
      expect(previous, closeTo(0.5, 1e-3));
    });

    test('a single bump barely moves the display', () {
      final d = Drive(portrait)..park();
      d.sample(forward: 1);
      expect(d.reading.lon, lessThan(0.1));
      d.hold(2);
      expect(d.reading.lon, closeTo(0, 1e-3));
    });
  });

  group('GMeter peaks', () {
    test('speed up, brake and corner peaks, each in its sector', () {
      final d = Drive(portrait)..park();
      d
        ..hold(2, forward: 0.3)
        ..hold(0.5)
        ..hold(2, forward: -0.5)
        ..hold(0.5);
      // Speeding up pushes you back; that dot is fading by now.
      expect(d.reading.peaks[8], closeTo(0.3, 1e-3));
      expect(d.reading.peakFades[8], inExclusiveRange(0, 1));
      d
        ..hold(2, right: -0.4)
        ..hold(1);
      final r = d.reading;
      expect(r.peakSpeedUp, closeTo(0.3, 1e-3));
      expect(r.peakBrake, closeTo(0.5, 1e-3));
      expect(r.peakCorner, closeTo(0.4, 1e-3));
      expect(r.peaks, hasLength(GMeter.sectors));
      // Braking pushes you ahead: sector 0.
      expect(r.peaks[0], closeTo(0.5, 1e-3));
      // A left bend pushes you right: a quarter turn clockwise.
      expect(r.peaks[4], closeTo(0.4, 1e-3));
      expect(r.peakFades[4], 1, reason: 'still fresh');
      // The speed up dot has faded away; the panel keeps the peak.
      expect(r.peaks[8], 0);
      expect(r.peaks[12], 0);
      // Now standing still, the live reading is back near zero.
      expect(r.total, lessThan(0.01));
    });

    test('a peak dot fades away after the push, the panel keeps it', () {
      final d = Drive(portrait)..park();
      d
        ..hold(2, forward: -0.5)
        ..hold(1);
      expect(d.reading.peakFades[0], 1);
      d.hold(GMeter.holdFor + GMeter.fadeFor / 2);
      expect(d.reading.peakFades[0], inExclusiveRange(0, 1));
      d.hold(GMeter.fadeFor);
      expect(d.reading.peaks[0], 0);
      expect(d.reading.peakFades[0], 0);
      // The strongest braking stays on the panel until Reset.
      expect(d.reading.peakBrake, closeTo(0.5, 1e-3));
    });

    test('a weaker push renews a faded peak', () {
      final d = Drive(portrait)..park();
      d
        ..hold(2, forward: -0.5)
        ..hold(GMeter.holdFor + GMeter.fadeFor * 0.8)
        ..hold(2, forward: -0.3);
      expect(d.reading.peaks[0], closeTo(0.3, 1e-3));
      expect(d.reading.peakFades[0], 1);
    });

    test('a right bend pushes you left: sector 12', () {
      final d = Drive(portrait)..park();
      d.hold(2, right: 0.4);
      expect(d.reading.peaks[12], closeTo(0.4, 1e-3));
      expect(d.reading.peaks[4], 0);
      expect(d.reading.peakCorner, closeTo(0.4, 1e-3));
    });

    test('a diagonal push lands between the axes', () {
      // Braking and a left bend together: pushed ahead and right.
      final d = Drive(portrait)..park();
      d.hold(3, forward: -0.3, right: -0.3);
      expect(d.reading.peaks[2], closeTo(0.3 * math.sqrt2, 1e-3));
    });

    test('tiny pushes leave the sectors empty', () {
      final d = Drive(portrait)..park();
      d.hold(2, forward: -0.03);
      expect(d.reading.peaks.every((p) => p == 0), isTrue);
      expect(d.reading.peakBrake, closeTo(0.03, 1e-3));
    });

    test('resetPeaks clears every peak but keeps Zero and the reading', () {
      final d = Drive(portrait)..park();
      d.hold(3, forward: -0.5);
      d.meter.resetPeaks();
      final r = d.reading;
      expect(r.peakSpeedUp, 0);
      expect(r.peakBrake, 0);
      expect(r.peakCorner, 0);
      expect(r.peaks.every((p) => p == 0), isTrue);
      expect(r.zeroed, isTrue);
      expect(r.lon, closeTo(-0.5, 1e-3));
      // And peaks grow again from there.
      d.hold(3, right: -0.2);
      expect(d.reading.peakCorner, closeTo(0.2, 1e-3));
    });
  });

  group('GMeter zero', () {
    test('needs a few samples first', () {
      final d = Drive(portrait);
      expect(d.meter.canZero, isFalse);
      expect(d.meter.zero(), isFalse);
      for (var i = 0; i < 4; i++) {
        d.sample();
      }
      expect(d.meter.canZero, isFalse);
      expect(d.meter.zero(), isFalse);
      expect(d.meter.zeroed, isFalse);
      d.sample();
      expect(d.meter.canZero, isTrue);
      expect(d.meter.zero(), isTrue);
      expect(d.meter.zeroed, isTrue);
    });

    test('averages only the last half second', () {
      // Zeroed while braking long ago, then stopped: only the stop counts.
      final d = Drive(portrait)
        ..hold(2, forward: -0.5)
        ..hold(0.6);
      expect(d.meter.zero(), isTrue);
      d.hold(2);
      expect(d.reading.lon, closeTo(0, 1e-9));
    });

    test('Zero clears the peaks and the live reading', () {
      final d = Drive(portrait)..park();
      d
        ..hold(2, forward: -0.5)
        ..hold(2, right: -0.4)
        ..hold(0.6);
      expect(d.reading.peakBrake, greaterThan(0.4));
      expect(d.meter.zero(), isTrue);
      final r = d.reading;
      expect(r.lon, 0);
      expect(r.lat, 0);
      expect(r.peakSpeedUp, 0);
      expect(r.peakBrake, 0);
      expect(r.peakCorner, 0);
      expect(r.peaks.every((p) => p == 0), isTrue);
    });

    test('Zero again after the phone is re-mounted', () {
      final d = Drive(portrait)..park();
      // Re-mounted flat without zeroing: gravity now looks like braking.
      for (var i = 0; i < 50; i++) {
        d.t += Drive.dt;
        d.meter.add(flat.up * standardGravity, d.t);
      }
      expect(d.reading.lon, lessThan(-0.9));
      expect(d.meter.zero(), isTrue);
      // Now braking reads true in the new position.
      for (var i = 0; i < 150; i++) {
        d.t += Drive.dt;
        d.meter.add(
          flat.up * standardGravity + flat.forward * (-0.5 * standardGravity),
          d.t,
        );
      }
      expect(d.reading.lon, closeTo(-0.5, 1e-3));
      expect(d.reading.lat, closeTo(0, 1e-6));
    });

    test('the reading carries the sensor state', () {
      final m = GMeter();
      expect(m.reading(SensorState.missing).state, SensorState.missing);
      expect(m.reading(SensorState.missing).zeroed, isFalse);
    });
  });
}
