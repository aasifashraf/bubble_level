package dev.aasifashraf.bubble_level

import android.Manifest.permission.ACCESS_FINE_LOCATION
import android.Manifest.permission.BLUETOOTH_SCAN
import android.annotation.SuppressLint
import android.app.Activity
import android.bluetooth.BluetoothManager
import android.bluetooth.le.ScanCallback
import android.bluetooth.le.ScanFilter
import android.bluetooth.le.ScanResult
import android.bluetooth.le.ScanSettings
import android.content.Context
import android.content.Intent
import android.content.pm.PackageManager
import android.location.LocationManager
import android.os.Build
import android.os.Handler
import android.os.Looper
import android.os.ParcelUuid
import android.provider.Settings
import androidx.core.content.ContextCompat
import androidx.core.location.LocationManagerCompat
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel
import java.util.UUID

/**
 * Bluetooth scanning for the Tracker check, through Android's own LE
 * scanner (no Google libraries). It listens only for item trackers
 * (AirTag and Find My, Google Find Hub, the joint standard, Samsung, Tile,
 * Chipolo), only while the tool listens, never in the background. Nothing
 * is connected to or sent anywhere.
 *
 * Access is reported as "granted", "needed", "denied" (refused for good),
 * "bluetoothOff", or "locationOff" (Android 11 and older only scan with
 * location on).
 */
class Ble(private val activity: Activity, messenger: BinaryMessenger) {
    private val bluetooth = (activity.getSystemService(Context.BLUETOOTH_SERVICE) as BluetoothManager?)?.adapter
    private var pending: MethodChannel.Result? = null

    /** Android 12 and later scan with their own permission, older ones with location. */
    private val permission = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) BLUETOOTH_SCAN else ACCESS_FINE_LOCATION

    init {
        MethodChannel(messenger, "bubble_level/bluetooth").setMethodCallHandler { call, result ->
            when (call.method) {
                "check" -> result.success(access())
                "request" -> request(result)
                "openBluetoothSettings" -> {
                    activity.startActivity(
                        Intent(Settings.ACTION_BLUETOOTH_SETTINGS).addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
                    )
                    result.success(null)
                }
                else -> result.notImplemented()
            }
        }

        EventChannel(messenger, "bubble_level/ble_scan").setStreamHandler(object : EventChannel.StreamHandler {
            private var callback: ScanCallback? = null
            private val main = Handler(Looper.getMainLooper())

            // Android turns a scan running over 10 minutes down to low
            // power; starting it again every 9 keeps it listening.
            private val restart = object : Runnable {
                override fun run() {
                    stop()
                    callback?.let { start(it) }
                    main.postDelayed(this, RESTART_MS)
                }
            }

            override fun onListen(arguments: Any?, events: EventChannel.EventSink) {
                if (access() != "granted") return events.error("NOT_READY", access(), null)
                val c = object : ScanCallback() {
                    override fun onScanResult(callbackType: Int, result: ScanResult) {
                        events.success(signal(result))
                    }

                    override fun onScanFailed(errorCode: Int) {
                        events.error("SCAN_FAILED", "Scan failed: $errorCode", null)
                    }
                }
                callback = c
                start(c)
                main.postDelayed(restart, RESTART_MS)
            }

            override fun onCancel(arguments: Any?) {
                main.removeCallbacks(restart)
                stop()
                callback = null
            }

            @SuppressLint("MissingPermission")
            private fun start(c: ScanCallback) {
                try {
                    bluetooth?.bluetoothLeScanner?.startScan(filters(), settings(), c)
                } catch (e: SecurityException) {
                    // Permission withdrawn while open; the check finds out.
                }
            }

            @SuppressLint("MissingPermission")
            private fun stop() {
                val c = callback ?: return
                try {
                    bluetooth?.bluetoothLeScanner?.stopScan(c)
                } catch (e: SecurityException) {
                    // Same.
                } catch (e: IllegalStateException) {
                    // Bluetooth was turned off meanwhile.
                }
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
                grantResults.isEmpty() || activity.shouldShowRequestPermissionRationale(permission) -> "needed"
                else -> "denied"
            }
        )
        return true
    }

    private fun request(result: MethodChannel.Result) {
        if (granted()) return result.success(access())
        if (pending != null) return result.success("needed")
        pending = result
        activity.requestPermissions(arrayOf(permission), REQUEST)
    }

    private fun granted() =
        ContextCompat.checkSelfPermission(activity, permission) == PackageManager.PERMISSION_GRANTED

    private fun access(): String {
        if (!granted()) return "needed"
        if (bluetooth?.isEnabled != true) return "bluetoothOff"
        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.S) {
            val location = activity.getSystemService(Context.LOCATION_SERVICE) as LocationManager
            if (!LocationManagerCompat.isLocationEnabled(location)) return "locationOff"
        }
        return "granted"
    }

    private fun filters(): List<ScanFilter> =
        SERVICES.map { ScanFilter.Builder().setServiceData(uuid16(it), ByteArray(0)).build() } +
            // Apple "offline finding" (Find My) adverts start with 0x12.
            ScanFilter.Builder().setManufacturerData(APPLE, byteArrayOf(0x12), byteArrayOf(0xFF.toByte())).build()

    private fun settings(): ScanSettings = ScanSettings.Builder()
        .setScanMode(ScanSettings.SCAN_MODE_LOW_LATENCY)
        .build()

    /** An advertisement as the Dart side reads it (see BleSignal). */
    private fun signal(r: ScanResult): Map<String, Any?> {
        val record = r.scanRecord
        val service = HashMap<String, ByteArray>()
        record?.serviceData?.forEach { (uuid, data) ->
            service[uuid.uuid.toString().substring(4, 8).lowercase()] = data
        }
        val manufacturer = HashMap<Int, ByteArray>()
        record?.manufacturerSpecificData?.let { m ->
            for (i in 0 until m.size()) manufacturer[m.keyAt(i)] = m.valueAt(i)
        }
        return mapOf(
            "address" to r.device.address,
            "rssi" to r.rssi,
            "time" to System.currentTimeMillis(),
            "service" to service,
            "manufacturer" to manufacturer,
        )
    }

    private companion object {
        const val REQUEST = 4802
        const val RESTART_MS = 9 * 60 * 1000L
        const val APPLE = 0x004C

        /** Joint standard, Google Find Hub, Samsung, Tile, Chipolo. */
        val SERVICES = listOf("fcb2", "feaa", "fd5a", "feed", "fe33")

        fun uuid16(short: String): ParcelUuid =
            ParcelUuid(UUID.fromString("0000$short-0000-1000-8000-00805f9b34fb"))
    }
}
