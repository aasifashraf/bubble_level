import 'package:bubble_level/domain/orientation_reading.dart';
import 'package:bubble_level/domain/scene_weather.dart';
import 'package:bubble_level/domain/speed.dart';
import 'package:flutter_test/flutter_test.dart';

final _t0 = DateTime(2026, 10, 7, 12);

/// Metres per degree of latitude on the app's 6371 km sphere.
const _mPerDeg = 111194.9266;

LocationFix _fix({
  double lat = 0,
  double lon = 0,
  double speed = -1,
  double accuracy = 5,
  double? altitude,
  double seconds = 0,
}) => (
  latitude: lat,
  longitude: lon,
  altitude: altitude,
  speed: speed,
  accuracy: accuracy,
  time: _t0.add(Duration(microseconds: (seconds * 1e6).round())),
);

/// A drive due north at [ms] m/s, one fix a second for [seconds] seconds.
void _drive(TripMeter trip, double ms, int seconds, {double from = 0}) {
  for (var i = 0; i <= seconds; i++) {
    trip.add(
      _fix(lat: i * ms / _mPerDeg, speed: ms, seconds: from + i.toDouble()),
    );
  }
}

void main() {
  group('distanceBetween', () {
    test('0.001 degree of latitude is about 111.2 m', () {
      expect(distanceBetween(_fix(), _fix(lat: 0.001)), closeTo(111.19, 0.01));
    });

    test('Paris to London and New York to Los Angeles within 0.5%', () {
      final paris = _fix(lat: 48.8566, lon: 2.3522);
      final london = _fix(lat: 51.5074, lon: -0.1278);
      expect(distanceBetween(paris, london), closeTo(343500, 343500 * 0.005));
      final ny = _fix(lat: 40.7128, lon: -74.0060);
      final la = _fix(lat: 34.0522, lon: -118.2437);
      expect(distanceBetween(ny, la), closeTo(3936000, 3936000 * 0.005));
    });

    test('same point is zero and order does not matter', () {
      final a = _fix(lat: 10, lon: 20), b = _fix(lat: 10.5, lon: 20.5);
      expect(distanceBetween(a, a), 0);
      expect(distanceBetween(a, b), closeTo(distanceBetween(b, a), 1e-6));
    });
  });

  group('TripMeter', () {
    test('no fix yet: no speed and an empty reading', () {
      final r = TripMeter().reading(SensorState.waiting);
      expect(r.hasFix, isFalse);
      expect(r.speed, isNull);
      expect(r.weak, isFalse);
      expect(r.distance, 0);
      expect(r.average, 0);
      expect(r.state, SensorState.waiting);
    });

    test('uses the Doppler speed when the receiver gives one', () {
      final trip = TripMeter()..add(_fix(speed: 12.5));
      expect(trip.speed, 12.5);
      // Far away in one second, but the Doppler speed wins.
      trip.add(_fix(lat: 0.01, speed: 13, seconds: 1));
      expect(trip.speed, 13);
    });

    test('without a Doppler speed, distance over time', () {
      final trip = TripMeter()..add(_fix());
      expect(trip.speed, 0, reason: 'one fix alone has no speed');
      trip.add(_fix(lat: 0.001, seconds: 5));
      expect(trip.speed, closeTo(22.239, 0.001));
      expect(trip.reading(SensorState.ok).distance, closeTo(111.19, 0.01));
    });

    test('below walking pace counts as standing still', () {
      final trip = TripMeter()
        ..add(_fix(speed: 0.4))
        ..add(_fix(lat: 3 / _mPerDeg, speed: 0.4, seconds: 1));
      expect(trip.speed, 0);
      var r = trip.reading(SensorState.ok);
      expect(r.distance, 0);
      expect(r.movingSeconds, 0);
      expect(r.top, 0);

      // GPS drift of 0.3 m a second, worked out from positions.
      trip.add(_fix(lat: 3.3 / _mPerDeg, seconds: 2));
      expect(trip.speed, 0);
      r = trip.reading(SensorState.ok);
      expect(r.distance, 0);
    });

    test('weak fixes show the speed but add no distance or top', () {
      final trip = TripMeter()
        ..add(_fix(speed: 15, accuracy: 30))
        ..add(_fix(lat: 15 / _mPerDeg, speed: 15, accuracy: 30, seconds: 1));
      expect(trip.speed, 15);
      final r = trip.reading(SensorState.ok);
      expect(r.speed, 15);
      expect(r.weak, isTrue);
      expect(r.distance, 0);
      expect(r.top, 0);
      expect(r.movingSeconds, 0);
    });

    test('a fix right at the weak limit still counts', () {
      final trip = TripMeter()
        ..add(_fix(speed: 10, accuracy: TripMeter.weakOver))
        ..add(
          _fix(
            lat: 10 / _mPerDeg,
            speed: 10,
            accuracy: TripMeter.weakOver,
            seconds: 1,
          ),
        );
      final r = trip.reading(SensorState.ok);
      expect(r.weak, isFalse);
      expect(r.distance, closeTo(10, 0.01));
      expect(r.top, 10);
    });

    test('a straight drive at 20 m/s for a minute is about 1200 m', () {
      final trip = TripMeter();
      _drive(trip, 20, 60);
      final r = trip.reading(SensorState.ok);
      expect(r.distance, closeTo(1200, 1200 * 0.02));
      expect(r.movingSeconds, 60);
      expect(r.top, 20);
      expect(r.average, closeTo(20, 0.4));
    });

    test('a gap of more than 10 s adds no distance', () {
      final trip = TripMeter()
        ..add(_fix(speed: 5))
        ..add(_fix(lat: 75 / _mPerDeg, speed: 5, seconds: 15));
      expect(trip.speed, 5);
      final r = trip.reading(SensorState.ok);
      expect(r.distance, 0);
      expect(r.movingSeconds, 0);
      expect(r.top, 5);
    });

    test('top is the fastest, average is distance over moving time', () {
      final trip = TripMeter();
      // 10 m/s for 10 s, stand still for 20 s, then 30 m/s for 10 s.
      _drive(trip, 10, 10);
      final stop = 100 / _mPerDeg;
      for (var i = 11; i <= 30; i++) {
        trip.add(_fix(lat: stop, speed: 0, seconds: i.toDouble()));
      }
      for (var i = 1; i <= 10; i++) {
        trip.add(
          _fix(lat: stop + i * 30 / _mPerDeg, speed: 30, seconds: 30.0 + i),
        );
      }
      final r = trip.reading(SensorState.ok);
      expect(r.top, 30);
      expect(r.distance, closeTo(400, 1));
      expect(r.movingSeconds, 20, reason: 'standing still is not moving');
      expect(r.average, closeTo(20, 0.1));
    });

    test('reset clears the trip but keeps the last fix', () {
      final trip = TripMeter();
      _drive(trip, 20, 10);
      trip.reset();
      var r = trip.reading(SensorState.ok);
      expect(r.distance, 0);
      expect(r.top, 0);
      expect(r.movingSeconds, 0);
      expect(r.average, 0);
      expect(r.speed, 20, reason: 'speed now stays');
      expect(r.latitude, closeTo(200 / _mPerDeg, 1e-12));

      // The next fix measures from the kept one.
      trip.add(_fix(lat: 220 / _mPerDeg, speed: 20, seconds: 11));
      r = trip.reading(SensorState.ok);
      expect(r.distance, closeTo(20, 0.01));
      expect(r.movingSeconds, 1);
      expect(r.top, 20);
    });

    test('the reading carries the last fix', () {
      final trip = TripMeter()
        ..add(
          _fix(
            lat: 34.05224,
            lon: -118.24368,
            speed: 3,
            accuracy: 8,
            altitude: 89.5,
          ),
        );
      final r = trip.reading(SensorState.ok);
      expect(r.latitude, 34.05224);
      expect(r.longitude, -118.24368);
      expect(r.altitude, 89.5);
      expect(r.accuracy, 8);
      expect(r.speed, 3);
      expect(r.hasFix, isTrue);
      expect(r.weak, isFalse);
      expect(r.state, SensorState.ok);

      trip.add(_fix(lat: 34.05224, lon: -118.24368, speed: 3, seconds: 1));
      expect(trip.reading(SensorState.ok).altitude, isNull);
    });
  });

  test('formatCoordinate gives the hemisphere and 5 decimals', () {
    expect(formatCoordinate(34.05224, latitude: true), '34.05224° N');
    expect(formatCoordinate(-33.8688, latitude: true), '33.86880° S');
    expect(formatCoordinate(151.2093, latitude: false), '151.20930° E');
    expect(formatCoordinate(-118.24368, latitude: false), '118.24368° W');
    expect(formatCoordinate(0, latitude: true), '0.00000° N');
    expect(formatCoordinate(0, latitude: false), '0.00000° E');
  });

  test('unit constants: 27.78 m/s is about 100 km/h and 62.14 mph', () {
    expect(27.78 * kmhPerMs, closeTo(100, 0.01));
    expect(27.78 * mphPerMs, closeTo(62.14, 0.01));
    expect(1609.344 / 3600 * mphPerMs, closeTo(1, 1e-9));
  });

  test('day, dusk and night by the clock', () {
    DateTime at(int h) => DateTime(2026, 10, 7, h, 30);
    expect(dayPartOf(at(12)), DayPart.day);
    expect(dayPartOf(at(18)), DayPart.dusk);
    expect(dayPartOf(at(6)), DayPart.dusk);
    expect(dayPartOf(at(19)), DayPart.night);
    expect(dayPartOf(at(3)), DayPart.night);
  });

  group('speed without a satellite speed', () {
    test('position jitter while standing still reads as still', () {
      final trip = TripMeter();
      // Fixes wandering 8 m apart a second apart, each within 10 m.
      for (var i = 0; i < 6; i++) {
        trip.add(
          _fix(
            lat: (i.isEven ? 0 : 8) / _mPerDeg,
            accuracy: 10,
            seconds: i.toDouble(),
          ),
        );
      }
      expect(trip.speed, 0);
      expect(trip.reading(SensorState.ok).distance, 0);
    });

    test('a real move, larger than the uncertainty, gives its speed', () {
      final trip = TripMeter()
        ..add(_fix())
        ..add(_fix(lat: 30 / _mPerDeg, seconds: 1));
      expect(trip.speed, closeTo(30, 0.01));
    });

    test('after a pause the speed is unknown until a new fix', () {
      final trip = TripMeter();
      _drive(trip, 20, 10);
      trip.pause();
      expect(trip.speed, isNull);
      final r = trip.reading(SensorState.waiting);
      expect(r.hasFix, isFalse);
      expect(r.distance, greaterThan(150), reason: 'the trip is kept');
    });
  });
}
