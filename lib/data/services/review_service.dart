import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

/// Shows the store's own review card (Google Play In-App Review / Apple
/// SKStoreReviewController).
abstract interface class ReviewService {
  Future<void> requestReview();
}

class StoreReviewService implements ReviewService {
  const StoreReviewService();

  static const _app = MethodChannel('bubble_level/app');

  /// Never throws: the card is a courtesy, and the store decides whether it
  /// appears (it never does on sideloaded installs). The F-Droid build has
  /// no card at all.
  @override
  Future<void> requestReview() async {
    try {
      await _app.invokeMethod<void>('review');
    } catch (e) {
      debugPrint('Review card unavailable: $e');
    }
  }
}
