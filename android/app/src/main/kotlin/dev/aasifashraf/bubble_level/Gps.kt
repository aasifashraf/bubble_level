package dev.aasifashraf.bubble_level

import android.Manifest.permission.ACCESS_COARSE_LOCATION
import android.Manifest.permission.ACCESS_FINE_LOCATION
import android.app.Activity
import android.content.Context
import android.content.Intent
import android.content.pm.PackageManager
import android.location.Location
import android.location.LocationManager
import android.location.OnNmeaMessageListener
import android.os.Build
import android.os.Handler
import android.os.Looper
import android.os.SystemClock
import android.provider.Settings
import androidx.core.content.ContextCompat
import androidx.core.location.LocationListenerCompat
import androidx.core.location.LocationManagerCompat
import androidx.core.location.LocationRequestCompat
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel

/**
 * GPS for the speedometer through Android's own LocationManager, so it
 * needs no Google Play services. Fixes come only while the speedometer
 * listens (never in the background) and stay on the phone.
 *
 * Access is reported as the app's LocationAccess names: "granted",
 * "serviceOff" (allowed, but location is switched off), "needed" (can be
 * asked) and "denied" (refused for good: only Settings can change it).
 */
class Gps(private val activity: Activity, messenger: BinaryMessenger) {
    private val manager = activity.getSystemService(Context.LOCATION_SERVICE) as LocationManager
    private var pending: MethodChannel.Result? = null

    // The latest altitude above sea level from the receiver's GGA sentence,
    // and when it came (elapsed realtime, ms).
    private var nmeaAltitude: Double? = null
    private var nmeaAt = 0L

    init {
        MethodChannel(messenger, "bubble_level/location").setMethodCallHandler { call, result ->
            when (call.method) {
                "check" -> result.success(access())
                "request" -> request(result)
                // Android 12 and later let the user allow only an
                // approximate location, too coarse for a speed.
                "precise" -> result.success(granted(ACCESS_FINE_LOCATION))
                "openLocationSettings" -> {
                    activity.startActivity(
                        Intent(Settings.ACTION_LOCATION_SOURCE_SETTINGS).addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
                    )
                    result.success(null)
                }
                else -> result.notImplemented()
            }
        }

        EventChannel(messenger, "bubble_level/location_fixes").setStreamHandler(object : EventChannel.StreamHandler {
            private var listener: LocationListenerCompat? = null
            private var nmea: OnNmeaMessageListener? = null

            override fun onListen(arguments: Any?, events: EventChannel.EventSink) {
                if (!granted(ACCESS_FINE_LOCATION) && !granted(ACCESS_COARSE_LOCATION)) {
                    return events.error("DENIED", "Location is not allowed", null)
                }
                if (!manager.allProviders.contains(LocationManager.GPS_PROVIDER)) {
                    return events.error("NO_GPS", "This device has no GPS", null)
                }
                val main = ContextCompat.getMainExecutor(activity)
                val l = object : LocationListenerCompat {
                    // A fix that can't say how far off it is can't be trusted.
                    override fun onLocationChanged(location: Location) {
                        if (location.hasAccuracy()) events.success(fix(location))
                    }

                    // Location switched off while open, like a sensor lost.
                    override fun onProviderDisabled(provider: String) =
                        events.error("SERVICE_OFF", "Location is switched off", null)
                }
                listener = l
                try {
                    if (granted(ACCESS_FINE_LOCATION)) {
                        val n = OnNmeaMessageListener { message, _ -> readGga(message) }
                        nmea = n
                        manager.addNmeaListener(n, Handler(Looper.getMainLooper()))
                    }
                    LocationManagerCompat.requestLocationUpdates(
                        manager,
                        LocationManager.GPS_PROVIDER,
                        LocationRequestCompat.Builder(1000L)
                            .setQuality(LocationRequestCompat.QUALITY_HIGH_ACCURACY)
                            .build(),
                        main,
                        l,
                    )
                } catch (e: SecurityException) {
                    events.error("DENIED", e.message, null)
                }
            }

            override fun onCancel(arguments: Any?) {
                listener?.let { LocationManagerCompat.removeUpdates(manager, it) }
                nmea?.let(manager::removeNmeaListener)
                listener = null
                nmea = null
                nmeaAltitude = null
            }
        })
    }

    /** Pass on Activity.onRequestPermissionsResult; true when it was ours. */
    fun onPermissionResult(requestCode: Int, grantResults: IntArray): Boolean {
        if (requestCode != REQUEST) return false
        val result = pending ?: return true
        pending = null
        result.success(
            when {
                grantResults.any { it == PackageManager.PERMISSION_GRANTED } -> access()
                // Refused, but Android will still show the prompt again.
                grantResults.isEmpty() || activity.shouldShowRequestPermissionRationale(ACCESS_FINE_LOCATION) -> "needed"
                else -> "denied"
            }
        )
        return true
    }

    private fun request(result: MethodChannel.Result) {
        if (granted(ACCESS_FINE_LOCATION) || granted(ACCESS_COARSE_LOCATION)) return result.success(access())
        // A prompt already showing answers the first caller only.
        if (pending != null) return result.success("needed")
        pending = result
        activity.requestPermissions(arrayOf(ACCESS_FINE_LOCATION, ACCESS_COARSE_LOCATION), REQUEST)
    }

    private fun access(): String = when {
        !granted(ACCESS_FINE_LOCATION) && !granted(ACCESS_COARSE_LOCATION) -> "needed"
        !LocationManagerCompat.isLocationEnabled(manager) -> "serviceOff"
        else -> "granted"
    }

    private fun granted(permission: String) =
        ContextCompat.checkSelfPermission(activity, permission) == PackageManager.PERMISSION_GRANTED

    /** Keeps the altitude above sea level from a GGA sentence with a fix. */
    private fun readGga(message: String) {
        val fields = message.substringBefore('*').split(',')
        if (fields.size < 10 || !fields[0].endsWith("GGA")) return
        if ((fields[6].toIntOrNull() ?: 0) == 0) return
        nmeaAltitude = fields[9].toDoubleOrNull() ?: return
        nmeaAt = SystemClock.elapsedRealtime()
    }

    private fun fix(location: Location): Map<String, Any?> = mapOf(
        "latitude" to location.latitude,
        "longitude" to location.longitude,
        "altitude" to altitude(location),
        "speed" to if (location.hasSpeed()) location.speed.toDouble() else -1.0,
        "accuracy" to location.accuracy.toDouble(),
        "time" to location.time,
    )

    /**
     * Height above sea level: the receiver's own GGA figure when it is fresh,
     * else Android's (14 and later, when filled in), else the GPS height
     * (above the ellipsoid, tens of metres off in places), else none.
     */
    private fun altitude(location: Location): Double? {
        val nmea = nmeaAltitude
        if (nmea != null && SystemClock.elapsedRealtime() - nmeaAt < NMEA_FRESH_MS) return nmea
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.UPSIDE_DOWN_CAKE && location.hasMslAltitude()) {
            return location.mslAltitudeMeters
        }
        return if (location.hasAltitude()) location.altitude else null
    }

    private companion object {
        const val REQUEST = 4801
        const val NMEA_FRESH_MS = 5000L
    }
}
