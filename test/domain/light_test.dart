import 'package:bubble_level/domain/light.dart';
import 'package:bubble_level/ui/core/format.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('bands follow the usual lighting guides', () {
    expect(LightBand.of(0), LightBand.dark);
    expect(LightBand.of(9.9), LightBand.dark);
    expect(LightBand.of(50), LightBand.dim);
    expect(LightBand.of(150), LightBand.livingRoom);
    expect(LightBand.of(300), LightBand.reading);
    expect(LightBand.of(500), LightBand.reading);
    expect(LightBand.of(1000), LightBand.bright);
    expect(LightBand.of(5000), LightBand.overcast);
    expect(LightBand.of(20000), LightBand.daylight);
    expect(LightBand.of(100000), LightBand.sun);
  });

  test('the dial is logarithmic: 60° per tenfold', () {
    expect(lightSweep(0), 0);
    expect(lightSweep(1), 0);
    expect(lightSweep(10), closeTo(60, 1e-9));
    expect(lightSweep(1000), closeTo(180, 1e-9));
    expect(lightSweep(100000), closeTo(300, 1e-9));
    expect(lightSweep(1e9), lessThan(360), reason: 'never wraps round');
  });

  test('foot-candles and lux formatting', () {
    expect(const LightReading(lux: 107.639).footCandles, closeTo(10, 1e-9));
    expect(formatLux(3.24), '3.2');
    expect(formatLux(420.4), '420');
    expect(formatLux(32000), '32 000');
    expect(formatLux(1234567), '1 234 567');
  });
}
