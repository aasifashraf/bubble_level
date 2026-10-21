import 'package:bubble_level/data/services/review_service.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final messenger =
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger;
  const app = MethodChannel('bubble_level/app');

  tearDown(() => messenger.setMockMethodCallHandler(app, null));

  group('store review card', () {
    test('asks the app channel', () async {
      final calls = <String>[];
      messenger.setMockMethodCallHandler(app, (c) async {
        calls.add(c.method);
        return null;
      });
      await const StoreReviewService().requestReview();
      expect(calls, ['review']);
    });

    test('never throws', () async {
      messenger.setMockMethodCallHandler(
        app,
        (_) async => throw PlatformException(code: 'x'),
      );
      await const StoreReviewService().requestReview();
      messenger.setMockMethodCallHandler(app, null);
      await const StoreReviewService().requestReview();
    });
  });
}
