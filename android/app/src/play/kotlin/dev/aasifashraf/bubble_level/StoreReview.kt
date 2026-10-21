package dev.aasifashraf.bubble_level

import android.app.Activity
import com.google.android.play.core.review.ReviewManagerFactory

/**
 * Google Play's in-app review card (Play build only). Play decides whether
 * it appears; [done] runs either way.
 */
object StoreReview {
    fun request(activity: Activity, done: () -> Unit) {
        val manager = ReviewManagerFactory.create(activity)
        manager.requestReviewFlow().addOnCompleteListener { info ->
            if (!info.isSuccessful) return@addOnCompleteListener done()
            manager.launchReviewFlow(activity, info.result).addOnCompleteListener { done() }
        }
    }
}
