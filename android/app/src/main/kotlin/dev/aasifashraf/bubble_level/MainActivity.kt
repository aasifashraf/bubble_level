package dev.aasifashraf.bubble_level

import android.content.Context
import android.hardware.Sensor
import android.hardware.SensorManager
import android.os.Build
import android.view.Surface
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        // Reports how far the UI is rotated from the device's natural
        // orientation, so sensor axes can be mapped onto the screen.
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "bubble_level/display")
            .setMethodCallHandler { call, result ->
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
                )
                result.success(sensors.filterValues { manager.getDefaultSensor(it) == null }.keys.toList())
            }
    }
}
