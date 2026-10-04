import 'package:bubble_level/domain/metal.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  /// Feeds [field] for [seconds] at 20 samples a second from [from], and
  /// returns the last change.
  double hold(MetalBaseline b, double field, double from, double seconds) {
    var change = 0.0;
    for (var t = from; t <= from + seconds; t += 0.05) {
      change = b.add(field, t);
    }
    return change;
  }

  test('the first sample is the baseline', () {
    final b = MetalBaseline();
    expect(b.add(48, 0), 0);
    expect(b.value, 48);
    expect(b.add(90, 0.05), 42);
  });

  test('an offset left behind (sensor recalibrated after a magnet) fades '
      'out within seconds, so the beeping stops', () {
    final b = MetalBaseline()..add(48, 0);
    // Metal came and went; the sensor now reads 30 µT higher with nothing
    // there: "metal detected" at first.
    expect(b.add(78, 1), 30);
    // Still beeping (≥ 15 µT) for the settle time...
    expect(hold(b, 78, 1, 2.5), greaterThanOrEqualTo(15));
    // ...then below "nearby" within about 6 s, and near zero after.
    expect(hold(b, 78, 3.5, 3.5), lessThan(15));
    expect(hold(b, 78, 7, 10), lessThan(1));
  });

  test('a sweep past metal is unaffected: a changing field never moves the '
      'baseline', () {
    final b = MetalBaseline()..add(48, 0);
    var peak = 0.0;
    // Up to +120 µT and back over 8 s, as when sweeping slowly.
    for (var i = 0; i <= 160; i++) {
      final t = i * 0.05;
      final rise = i <= 80 ? i * 1.5 : (160 - i) * 1.5;
      final change = b.add(48 + rise, t);
      if (change > peak) peak = change;
    }
    expect(peak, closeTo(120, 1e-9));
    expect(b.value, 48);
  });

  test('noise below the steadiness limit counts as steady', () {
    final b = MetalBaseline()..add(48, 0);
    var t = 0.0;
    for (var i = 0; i < 300; i++) {
      t += 0.05;
      b.add(70 + (i.isEven ? 1.0 : -1.0), t);
    }
    expect(b.value, closeTo(70, 1.5));
  });

  test('Set baseline re-zeroes at once; clear starts over', () {
    final b = MetalBaseline()..add(48, 0);
    b.reset(90, 1);
    expect(b.add(90, 1.05), 0);
    b.clear();
    expect(b.value, isNull);
    expect(b.add(60, 2), 0);
  });
}
