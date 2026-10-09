package dev.aasifashraf.bubble_level

import android.content.ActivityNotFoundException
import android.content.Context
import android.content.Intent
import android.content.pm.PackageManager
import android.hardware.Sensor
import android.hardware.SensorEvent
import android.hardware.SensorEventListener
import android.hardware.SensorManager
import android.net.Uri
import android.os.Build
import android.provider.Settings
import android.view.Surface
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        // Reports how far the UI is rotated from the device's natural
        // orientation, so sensor axes can be mapped onto the screen.
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "bubble_level/display")
            .setMethodCallHandler { call, result ->
                if (call.method == "ppi") {
                    // Physical pixels per inch along x and y, for the ruler.
                    val m = resources.displayMetrics
                    return@setMethodCallHandler result.success(listOf(m.xdpi.toDouble(), m.ydpi.toDouble()))
                }
                if (call.method != "quarterTurns") return@setMethodCallHandler result.notImplemented()
                val rotation = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R) {
                    display?.rotation
                } else {
                    @Suppress("DEPRECATION")
                    windowManager.defaultDisplay.rotation
                }
                result.success(
                    when (rotation) {
                        Surface.ROTATION_90 -> 1
                        Surface.ROTATION_180 -> 2
                        Surface.ROTATION_270 -> 3
                        else -> 0
                    }
                )
            }

        // Lists the sensors this device lacks, by the names the app uses.
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "bubble_level/sensors")
            .setMethodCallHandler { call, result ->
                if (call.method != "missing") return@setMethodCallHandler result.notImplemented()
                val manager = getSystemService(Context.SENSOR_SERVICE) as SensorManager
                val sensors = mapOf(
                    "accelerometer" to Sensor.TYPE_ACCELEROMETER,
                    "magnetometer" to Sensor.TYPE_MAGNETIC_FIELD,
                    "barometer" to Sensor.TYPE_PRESSURE,
                    "light" to Sensor.TYPE_LIGHT,
                )
                val missing = sensors.filterValues { manager.getDefaultSensor(it) == null }.keys.toMutableList()
                if (!packageManager.hasSystemFeature(PackageManager.FEATURE_MICROPHONE)) {
                    missing.add("microphone")
                }
                if (!packageManager.hasSystemFeature(PackageManager.FEATURE_CAMERA_ANY)) {
                    missing.add("camera")
                }
                if (!packageManager.hasSystemFeature(PackageManager.FEATURE_LOCATION_GPS)) {
                    missing.add("gps")
                }
                result.success(missing)
            }

        // Opens this app's page in Settings, to allow a refused permission.
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "bubble_level/app")
            .setMethodCallHandler { call, result ->
                // TEMPORARY (test builds): opens the email app to write to the owner.
                if (call.method == "email") {
                    val address = call.argument<String>("address") ?: return@setMethodCallHandler result.success(false)
                    val subject = Uri.encode(call.argument<String>("subject") ?: "")
                    return@setMethodCallHandler try {
                        startActivity(
                            Intent(Intent.ACTION_SENDTO, Uri.parse("mailto:$address?subject=$subject"))
                                .addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
                        )
                        result.success(true)
                    } catch (e: ActivityNotFoundException) {
                        result.success(false)
                    }
                }
                if (call.method != "openSettings") return@setMethodCallHandler result.notImplemented()
                startActivity(
                    Intent(Settings.ACTION_APPLICATION_DETAILS_SETTINGS, Uri.fromParts("package", packageName, null))
                        .addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
                )
                result.success(null)
            }

        // Illuminance in lux from the ambient light sensor, while listened
        // to. The sensor reports only when the level changes.
        EventChannel(flutterEngine.dartExecutor.binaryMessenger, "bubble_level/light")
            .setStreamHandler(object : EventChannel.StreamHandler {
                private var listener: SensorEventListener? = null

                override fun onListen(arguments: Any?, events: EventChannel.EventSink) {
                    val manager = getSystemService(Context.SENSOR_SERVICE) as SensorManager
                    val sensor = manager.getDefaultSensor(Sensor.TYPE_LIGHT)
                        ?: return events.error("NO_SENSOR", "This device has no light sensor", null)
                    val l = object : SensorEventListener {
                        override fun onSensorChanged(event: SensorEvent) {
                            events.success(event.values[0].toDouble())
                        }

                        override fun onAccuracyChanged(sensor: Sensor?, accuracy: Int) {}
                    }
                    listener = l
                    manager.registerListener(l, sensor, SensorManager.SENSOR_DELAY_UI)
                }

                override fun onCancel(arguments: Any?) {
                    val manager = getSystemService(Context.SENSOR_SERVICE) as SensorManager
                    listener?.let(manager::unregisterListener)
                    listener = null
                }
            })

        // The compass sensor's calibration status (SensorManager's
        // SENSOR_STATUS_*: 0 unreliable, 1 low, 2 medium, 3 high), sent
        // first with the first reading and then whenever it changes. A
        // figure 8 lets the system recalibrate and raise it.
        EventChannel(flutterEngine.dartExecutor.binaryMessenger, "bubble_level/magnetic_accuracy")
            .setStreamHandler(object : EventChannel.StreamHandler {
                private var listener: SensorEventListener? = null

                override fun onListen(arguments: Any?, events: EventChannel.EventSink) {
                    val manager = getSystemService(Context.SENSOR_SERVICE) as SensorManager
                    val sensor = manager.getDefaultSensor(Sensor.TYPE_MAGNETIC_FIELD)
                        ?: return events.error("NO_SENSOR", "This device has no magnetometer", null)
                    val l = object : SensorEventListener {
                        private var last: Int? = null

                        private fun send(accuracy: Int) {
                            if (accuracy == last) return
                            last = accuracy
                            events.success(accuracy)
                        }

                        override fun onSensorChanged(event: SensorEvent) = send(event.accuracy)

                        override fun onAccuracyChanged(sensor: Sensor?, accuracy: Int) = send(accuracy)
                    }
                    listener = l
                    manager.registerListener(l, sensor, SensorManager.SENSOR_DELAY_UI)
                }

                override fun onCancel(arguments: Any?) {
                    val manager = getSystemService(Context.SENSOR_SERVICE) as SensorManager
                    listener?.let(manager::unregisterListener)
                    listener = null
                }
            })
    }
}
