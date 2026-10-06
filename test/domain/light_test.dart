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

  test('the sky is logarithmic: a fifth per tenfold', () {
    expect(skyLevel(0), 0);
    expect(skyLevel(1), 0);
    expect(skyLevel(10), closeTo(0.2, 1e-9));
    expect(skyLevel(1000), closeTo(0.6, 1e-9));
    expect(skyLevel(100000), closeTo(1, 1e-9));
    expect(skyLevel(1e9), 1, reason: 'never past full sun');
  });

  test('foot-candles and lux formatting', () {
    expect(const LightReading(lux: 107.639).footCandles, closeTo(10, 1e-9));
    expect(formatLux(3.24), '3.2');
    expect(formatLux(420.4), '420');
    expect(formatLux(32000), '32 000');
    expect(formatLux(1234567), '1 234 567');
  });
}
