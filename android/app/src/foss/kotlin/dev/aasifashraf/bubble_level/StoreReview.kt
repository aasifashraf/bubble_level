package dev.aasifashraf.bubble_level

import android.app.Activity

/** The F-Droid build has no store review card (and no Google libraries). */
object StoreReview {
    fun request(activity: Activity, done: () -> Unit) = done()
}
