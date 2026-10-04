import 'package:bubble_level/data/repositories/review_repository.dart';
import 'package:bubble_level/data/services/review_service.dart';
import 'package:bubble_level/domain/review_policy.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _CountingReviews implements ReviewService {
  int asks = 0;

  @override
  Future<void> requestReview() async => asks++;
}

void main() {
  group('ReviewPolicy', () {
    final start = DateTime(2026, 10);
    bool ask({
      int successes = 5,
      int daysInstalled = 3,
      int? daysSinceAsk,
      bool session = false,
    }) => ReviewPolicy.shouldAsk(
      successes: successes,
      firstLaunch: start,
      lastAsk: daysSinceAsk == null
          ? null
          : start
                .add(Duration(days: daysInstalled))
                .subtract(Duration(days: daysSinceAsk)),
      now: start.add(Duration(days: daysInstalled)),
      askedThisSession: session,
    );

    test('needs real use: enough successes and days', () {
      expect(ask(), isTrue);
      expect(ask(successes: 4), isFalse);
      expect(ask(daysInstalled: 2), isFalse);
    });

    test('rarely: 60 days apart and never twice a session', () {
      expect(ask(daysInstalled: 100, daysSinceAsk: 59), isFalse);
      expect(ask(daysInstalled: 100, daysSinceAsk: 60), isTrue);
      expect(ask(session: true), isFalse);
    });
  });

  group('ReviewRepository', () {
    late DateTime now;
    late _CountingReviews reviews;

    setUp(() {
      SharedPreferences.setMockInitialValues({});
      now = DateTime(2026, 10);
      reviews = _CountingReviews();
    });

    Future<ReviewRepository> load() =>
        ReviewRepository.load(service: reviews, now: () => now);

    test('asks after the 5th success once 3 days have passed', () async {
      final repo = await load();
      for (var i = 0; i < 5; i++) {
        await repo.recordSuccess();
      }
      expect(reviews.asks, 0, reason: 'installed today');

      now = now.add(const Duration(days: 3));
      await repo.recordSuccess();
      expect(reviews.asks, 1);
      await repo.recordSuccess();
      expect(reviews.asks, 1, reason: 'once per session');
    });

    test('remembers counts and the last ask across launches', () async {
      var repo = await load();
      now = now.add(const Duration(days: 3));
      for (var i = 0; i < 5; i++) {
        await repo.recordSuccess();
      }
      expect(reviews.asks, 1);

      // Next launch, a month later: too soon to ask again.
      now = now.add(const Duration(days: 30));
      repo = await load();
      expect(repo.successes, 5);
      await repo.recordSuccess();
      expect(reviews.asks, 1);

      // Two months after the ask: allowed again.
      now = now.add(const Duration(days: 30));
      repo = await load();
      await repo.recordSuccess();
      expect(reviews.asks, 2);
    });
  });
}
