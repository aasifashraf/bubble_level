import 'package:flutter/foundation.dart';
import 'package:in_app_review/in_app_review.dart';

/// Shows the store's own review card (Google Play In-App Review / Apple
/// SKStoreReviewController).
abstract interface class ReviewService {
  Future<void> requestReview();
}

class StoreReviewService implements ReviewService {
  const StoreReviewService();

  /// Never throws: the card is a courtesy, and the store decides whether it
  /// appears (it never does on sideloaded installs).
  @override
  Future<void> requestReview() async {
    try {
      final review = InAppReview.instance;
      if (await review.isAvailable()) await review.requestReview();
    } catch (e) {
      debugPrint('Review card unavailable: $e');
    }
  }
}
