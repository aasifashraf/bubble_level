import 'package:bubble_level/data/services/location_service.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final messenger =
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger;
  const location = MethodChannel('bubble_level/location');
  const fixes = EventChannel('bubble_level/location_fixes');
  const app = MethodChannel('bubble_level/app');

  tearDown(() {
    messenger.setMockMethodCallHandler(location, null);
    messenger.setMockMethodCallHandler(app, null);
    messenger.setMockStreamHandler(fixes, null);
  });

  group('Android location (no Google Play services)', () {
    const service = LocationService();

    void answer(Object? Function(MethodCall call) reply) =>
        messenger.setMockMethodCallHandler(location, (c) async => reply(c));

    test('maps the native access names', () async {
      for (final a in LocationAccess.values) {
        answer((_) => a.name);
        expect(await service.check(), a);
        expect(await service.request(), a);
      }
    });

    test('an unknown answer or a failure reads as refused', () async {
      answer((_) => 'later');
      expect(await service.check(), LocationAccess.denied);
      answer((_) => throw PlatformException(code: 'x'));
      expect(await service.request(), LocationAccess.denied);
    });

    test('precise follows the native answer', () async {
      answer((_) => false);
      expect(await service.precise(), isFalse);
      answer((_) => true);
      expect(await service.precise(), isTrue);
    });

    test('settings: location on its channel, the app page on the app '
        'channel', () async {
      final calls = <String>[];
      answer((c) => calls.add('location.${c.method}'));
      messenger.setMockMethodCallHandler(app, (c) async {
        calls.add('app.${c.method}');
        return null;
      });
      await service.openLocationSettings();
      await service.openAppSettings();
      expect(calls, ['location.openLocationSettings', 'app.openSettings']);
    });

    test('fixes arrive as LocationFix', () async {
      messenger.setMockStreamHandler(
        fixes,
        MockStreamHandler.inline(
          onListen: (_, sink) {
            sink.success({
              'latitude': 34.08,
              'longitude': 74.8,
              'altitude': 1585.5,
              'speed': 12.5,
              'accuracy': 4.0,
              'time': 1760000000000,
            });
            sink.endOfStream();
          },
        ),
      );
      final fix = await service.fixes().single;
      expect(fix.latitude, 34.08);
      expect(fix.longitude, 74.8);
      expect(fix.altitude, 1585.5);
      expect(fix.speed, 12.5);
      expect(fix.accuracy, 4);
      expect(fix.time, DateTime.fromMillisecondsSinceEpoch(1760000000000));
    });

    test('no altitude stays unknown; no speed is negative', () {
      final fix = LocationService.androidFix({
        'latitude': 1,
        'longitude': 2,
        'altitude': null,
        'speed': -1.0,
        'accuracy': 8,
        'time': 0,
      });
      expect(fix.altitude, isNull);
      expect(fix.speed, isNegative);
      expect(fix.accuracy, 8.0);
    });
  });
}
