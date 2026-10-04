import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/review_policy.dart';
import '../services/review_service.dart';

/// Counts the user's successes and, when [ReviewPolicy] allows, asks the
/// store for its review card. Nothing is shown in the app itself: no
/// question first, no button.
class ReviewRepository {
  ReviewRepository._(this._prefs, this._service, this._now);

  static Future<ReviewRepository> load({
    ReviewService service = const StoreReviewService(),
    DateTime Function() now = DateTime.now,
  }) async {
    final repo = ReviewRepository._(
      await SharedPreferences.getInstance(),
      service,
      now,
    );
    if (repo._prefs.getInt(_kFirstLaunch) == null) {
      await repo._prefs.setInt(_kFirstLaunch, now().millisecondsSinceEpoch);
    }
    return repo;
  }

  static const _kSuccesses = 'reviewSuccesses';
  static const _kFirstLaunch = 'firstLaunch';
  static const _kLastAsk = 'lastReviewAsk';

  final SharedPreferences _prefs;
  final ReviewService _service;
  final DateTime Function() _now;
  bool _askedThisSession = false;

  int get successes => _prefs.getInt(_kSuccesses) ?? 0;

  DateTime? _read(String key) {
    final ms = _prefs.getInt(key);
    return ms == null ? null : DateTime.fromMillisecondsSinceEpoch(ms);
  }

  /// A moment the app clearly helped (level reached, metal found).
  Future<void> recordSuccess() async {
    final count = successes + 1;
    await _prefs.setInt(_kSuccesses, count);
    final now = _now();
    final ask = ReviewPolicy.shouldAsk(
      successes: count,
      firstLaunch: _read(_kFirstLaunch) ?? now,
      lastAsk: _read(_kLastAsk),
      now: now,
      askedThisSession: _askedThisSession,
    );
    if (!ask) return;
    _askedThisSession = true;
    await _prefs.setInt(_kLastAsk, now.millisecondsSinceEpoch);
    await _service.requestReview();
  }
}
