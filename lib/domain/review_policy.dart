/// When to ask for a store review, following Google's and Apple's
/// guidance: only after the user has had real success with the app, never
/// on launch, rarely, and never twice in one session. The stores add their
/// own quota on top and may show nothing.
abstract final class ReviewPolicy {
  /// Successes (level reached, metal found) before the first ask.
  static const minSuccesses = 5;

  /// Days since first launch before the first ask.
  static const minDaysInstalled = 3;

  /// Days between asks.
  static const minDaysBetween = 60;

  static bool shouldAsk({
    required int successes,
    required DateTime firstLaunch,
    required DateTime? lastAsk,
    required DateTime now,
    required bool askedThisSession,
  }) {
    if (askedThisSession || successes < minSuccesses) return false;
    if (now.difference(firstLaunch).inDays < minDaysInstalled) return false;
    return lastAsk == null || now.difference(lastAsk).inDays >= minDaysBetween;
  }
}
