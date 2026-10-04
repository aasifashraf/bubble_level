package dev.aasifashraf.bubble_level

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
    }
}
