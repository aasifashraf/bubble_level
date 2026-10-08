package dev.aasifashraf.bubble_level

import android.Manifest
import android.app.Activity
import android.content.pm.PackageManager
import android.opengl.EGL14
import android.opengl.EGLConfig
import android.opengl.EGLContext
import android.opengl.EGLDisplay
import android.opengl.EGLSurface
import android.opengl.GLES11Ext
import android.opengl.GLES20
import android.opengl.Matrix
import android.os.Build
import android.os.Handler
import android.os.HandlerThread
import android.os.Looper
import android.util.Log
import android.view.Surface
import com.google.ar.core.Anchor
import com.google.ar.core.ArCoreApk
import com.google.ar.core.Camera
import com.google.ar.core.Config
import com.google.ar.core.Coordinates2d
import com.google.ar.core.DepthPoint
import com.google.ar.core.Frame
import com.google.ar.core.HitResult
import com.google.ar.core.Plane
import com.google.ar.core.Point
import com.google.ar.core.Session
import com.google.ar.core.TrackingFailureReason
import com.google.ar.core.TrackingState
import com.google.ar.core.exceptions.CameraNotAvailableException
import com.google.ar.core.exceptions.UnavailableApkTooOldException
import com.google.ar.core.exceptions.UnavailableArcoreNotInstalledException
import com.google.ar.core.exceptions.UnavailableDeviceNotCompatibleException
import com.google.ar.core.exceptions.UnavailableSdkTooOldException
import com.google.ar.core.exceptions.UnavailableUserDeclinedInstallationException
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.view.TextureRegistry
import java.nio.ByteBuffer
import java.nio.ByteOrder
import java.nio.FloatBuffer
import java.util.concurrent.CountDownLatch
import java.util.concurrent.TimeUnit

/**
 * The tape measure's AR: ARCore follows the phone in 3D from the camera and
 * motion sensors and finds surfaces. The camera picture is drawn into a
 * Flutter texture; each frame Flutter gets the surface point under the
 * aim, the tapped points (as ARCore anchors, so they stay put as tracking
 * improves) and the camera's view-projection matrix to draw them with.
 * Runs only while the tool is open; the picture is never recorded, saved
 * or sent.
 */
class ArMeasure(
    private val activity: Activity,
    messenger: BinaryMessenger,
    private val textures: TextureRegistry,
) {
    private val main = Handler(Looper.getMainLooper())
    private var events: EventChannel.EventSink? = null
    private var run: ArRun? = null
    private var permissionResult: MethodChannel.Result? = null

    init {
        MethodChannel(messenger, "bubble_level/ar").setMethodCallHandler(::handle)
        EventChannel(messenger, "bubble_level/ar/frames").setStreamHandler(
            object : EventChannel.StreamHandler {
                override fun onListen(arguments: Any?, sink: EventChannel.EventSink) {
                    events = sink
                }

                override fun onCancel(arguments: Any?) {
                    events = null
                }
            },
        )
    }

    private fun handle(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "support" -> support(result)
            "install" -> install(result)
            "permission" -> result.success(granted())
            "requestPermission" -> requestPermission(result)
            "start" -> start(call, result)
            "add" -> run?.add { ok -> main.post { result.success(ok) } } ?: result.success(false)
            "undo" -> {
                run?.undo()
                result.success(null)
            }
            "clear" -> {
                run?.clear()
                result.success(null)
            }
            "stop" -> {
                stop()
                result.success(null)
            }
            else -> result.notImplemented()
        }
    }

    /** "supported", "install" (ARCore needs installing or updating), "unsupported" or "unknown". */
    private fun support(result: MethodChannel.Result) {
        var answered = false
        fun answer(v: String) {
            if (answered) return
            answered = true
            result.success(v)
        }
        // Without an answer (no Play Store, no network), the tool tries anyway.
        main.postDelayed({ answer("unknown") }, 4000)
        ArCoreApk.getInstance().checkAvailabilityAsync(activity) { a ->
            main.post {
                answer(
                    when (a) {
                        ArCoreApk.Availability.SUPPORTED_INSTALLED -> "supported"
                        ArCoreApk.Availability.SUPPORTED_APK_TOO_OLD,
                        ArCoreApk.Availability.SUPPORTED_NOT_INSTALLED -> "install"
                        ArCoreApk.Availability.UNSUPPORTED_DEVICE_NOT_CAPABLE -> "unsupported"
                        else -> "unknown"
                    },
                )
            }
        }
    }

    /** Asks Google Play Services for AR to install: "installed", "requested" or "declined". */
    private fun install(result: MethodChannel.Result) {
        try {
            result.success(
                when (ArCoreApk.getInstance().requestInstall(activity, true)) {
                    ArCoreApk.InstallStatus.INSTALLED -> "installed"
                    else -> "requested"
                },
            )
        } catch (e: UnavailableUserDeclinedInstallationException) {
            result.success("declined")
        } catch (e: Exception) {
            result.success("unsupported")
        }
    }

    private fun granted() =
        activity.checkSelfPermission(Manifest.permission.CAMERA) == PackageManager.PERMISSION_GRANTED

    private fun requestPermission(result: MethodChannel.Result) {
        if (granted()) return result.success(true)
        permissionResult?.success(false)
        permissionResult = result
        activity.requestPermissions(arrayOf(Manifest.permission.CAMERA), PERMISSION_REQUEST)
    }

    /** From MainActivity: the answer to the camera prompt. */
    fun onPermissionResult(requestCode: Int, grantResults: IntArray) {
        if (requestCode != PERMISSION_REQUEST) return
        permissionResult?.success(grantResults.firstOrNull() == PackageManager.PERMISSION_GRANTED)
        permissionResult = null
    }

    private fun start(call: MethodCall, result: MethodChannel.Result) {
        stop()
        val width = call.argument<Int>("width") ?: return result.error("args", "width", null)
        val height = call.argument<Int>("height") ?: return result.error("args", "height", null)
        val aimX = (call.argument<Double>("aimX") ?: 0.5).toFloat()
        val aimY = (call.argument<Double>("aimY") ?: 0.5).toFloat()
        val session = try {
            Session(activity)
        } catch (e: UnavailableArcoreNotInstalledException) {
            return result.error("install", e.message, null)
        } catch (e: UnavailableApkTooOldException) {
            return result.error("install", e.message, null)
        } catch (e: UnavailableDeviceNotCompatibleException) {
            return result.error("unsupported", e.message, null)
        } catch (e: UnavailableSdkTooOldException) {
            return result.error("unsupported", e.message, null)
        } catch (e: SecurityException) {
            return result.error("denied", e.message, null)
        } catch (e: Exception) {
            // The camera busy or a passing failure: worth trying again.
            Log.w("ArMeasure", "AR session failed", e)
            return result.error("failed", e.message, null)
        }
        try {
            session.configure(
                Config(session).apply {
                    planeFindingMode = Config.PlaneFindingMode.HORIZONTAL_AND_VERTICAL
                    focusMode = Config.FocusMode.AUTO
                    // Depth (where the phone supports it) lets points land on
                    // surfaces that aren't flat planes yet.
                    if (session.isDepthModeSupported(Config.DepthMode.AUTOMATIC)) {
                        depthMode = Config.DepthMode.AUTOMATIC
                    }
                },
            )
        } catch (e: Exception) {
            session.close()
            return result.error("failed", e.message, null)
        }
        val producer = textures.createSurfaceProducer()
        producer.setSize(width, height)
        val r = ArRun(session, producer, width, height, aimX, aimY, rotation()) { frame ->
            main.post { events?.success(frame) }
        }
        run = r
        r.start()
        result.success(producer.id())
    }

    fun stop() {
        run?.stop()
        run = null
    }

    private fun rotation(): Int = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R) {
        activity.display?.rotation ?: Surface.ROTATION_0
    } else {
        @Suppress("DEPRECATION")
        activity.windowManager.defaultDisplay.rotation
    }

    private companion object {
        const val PERMISSION_REQUEST = 4201
    }
}

/** One AR session, on its own thread with its own GL context. */
private class ArRun(
    private val session: Session,
    private val producer: TextureRegistry.SurfaceProducer,
    private val width: Int,
    private val height: Int,
    private val aimX: Float,
    private val aimY: Float,
    private val rotation: Int,
    private val send: (Map<String, Any?>) -> Unit,
) {
    private val thread = HandlerThread("ArMeasure").apply { start() }
    private val handler = Handler(thread.looper)

    @Volatile private var running = true
    private val gl = Gl()
    private val background = Background()
    private val anchors = mutableListOf<Anchor>()
    private val pendingAdds = mutableListOf<(Boolean) -> Unit>()
    private var resumed = false

    private val proj = FloatArray(16)
    private val view = FloatArray(16)
    private val viewProj = FloatArray(16)

    fun start() {
        producer.setCallback(
            object : TextureRegistry.SurfaceProducer.Callback {
                override fun onSurfaceAvailable() {
                    handler.post { gl.attach(producer.surface) }
                }

                override fun onSurfaceCleanup() {
                    // The surface goes when this returns: stop drawing to it first.
                    val done = CountDownLatch(1)
                    handler.post {
                        gl.detach()
                        done.countDown()
                    }
                    done.await(500, TimeUnit.MILLISECONDS)
                }
            },
        )
        handler.post {
            try {
                gl.setUp(producer.surface)
                background.setUp()
                session.setCameraTextureName(background.texture)
                session.setDisplayGeometry(rotation, width, height)
                session.resume()
                resumed = true
                handler.post(tick)
            } catch (e: CameraNotAvailableException) {
                send(mapOf("error" to "camera"))
            } catch (e: Exception) {
                Log.e(TAG, "AR start failed", e)
                send(mapOf("error" to "failed"))
            }
        }
    }

    private val tick = object : Runnable {
        override fun run() {
            if (!running) return
            try {
                frame()
            } catch (e: CameraNotAvailableException) {
                send(mapOf("error" to "camera"))
                return
            } catch (e: Exception) {
                Log.w(TAG, "AR frame failed", e)
            }
            if (running) handler.post(this)
        }
    }

    /** Adds a point where the aim meets a surface; false when it meets none. */
    fun add(done: (Boolean) -> Unit) {
        handler.post { pendingAdds.add(done) }
    }

    fun undo() {
        handler.post { anchors.removeLastOrNull()?.detach() }
    }

    fun clear() {
        handler.post {
            anchors.forEach { it.detach() }
            anchors.clear()
        }
    }

    fun stop() {
        running = false
        producer.setCallback(null)
        handler.post {
            pendingAdds.forEach { it(false) }
            pendingAdds.clear()
            anchors.forEach { it.detach() }
            anchors.clear()
            try {
                if (resumed) session.pause()
            } catch (e: Exception) {
                Log.w(TAG, "AR pause failed", e)
            }
            session.close()
            background.release()
            gl.release()
            Handler(Looper.getMainLooper()).post { producer.release() }
            thread.quitSafely()
        }
    }

    private fun frame() {
        // Waits for the camera's next picture.
        val frame = session.update()
        if (frame.hasDisplayGeometryChanged()) background.fit(frame)
        if (frame.timestamp == 0L) return
        if (gl.hasWindow) {
            GLES20.glViewport(0, 0, width, height)
            background.draw()
            gl.swap()
        }

        val camera = frame.camera
        val tracking = camera.trackingState == TrackingState.TRACKING
        val hit = if (tracking) pick(frame.hitTest(aimX * width, aimY * height), camera) else null
        if (pendingAdds.isNotEmpty()) {
            val ok = hit != null && anchors.size < MAX_POINTS
            if (ok) anchors.add(hit!!.createAnchor())
            pendingAdds.forEach { it(ok) }
            pendingAdds.clear()
        }

        camera.getProjectionMatrix(proj, 0, 0.05f, 100f)
        camera.getViewMatrix(view, 0)
        Matrix.multiplyMM(viewProj, 0, proj, 0, view, 0)
        val points = FloatArray(anchors.size * 3)
        anchors.forEachIndexed { i, a ->
            val p = a.pose
            points[i * 3] = p.tx()
            points[i * 3 + 1] = p.ty()
            points[i * 3 + 2] = p.tz()
        }
        val surface = session.getAllTrackables(Plane::class.java)
            .any { it.trackingState == TrackingState.TRACKING && it.subsumedBy == null }
        send(
            mapOf(
                "tracking" to when (camera.trackingState) {
                    TrackingState.TRACKING -> "tracking"
                    TrackingState.PAUSED -> "paused"
                    else -> "stopped"
                },
                "reason" to when (camera.trackingFailureReason) {
                    TrackingFailureReason.INSUFFICIENT_LIGHT -> "dark"
                    TrackingFailureReason.EXCESSIVE_MOTION -> "fast"
                    TrackingFailureReason.INSUFFICIENT_FEATURES -> "plain"
                    TrackingFailureReason.NONE -> null
                    else -> "other"
                },
                "aim" to hit?.hitPose?.let { floatArrayOf(it.tx(), it.ty(), it.tz()) },
                "points" to points,
                "viewProj" to viewProj.copyOf(),
                "cloud" to if (tracking) cloud(frame) else FloatArray(0),
                "surface" to surface,
            ),
        )
    }

    /** The first hit on a found surface: a plane, a surface point, or depth. */
    private fun pick(hits: List<HitResult>, camera: Camera): HitResult? = hits.firstOrNull { h ->
        when (val t = h.trackable) {
            is Plane -> t.isPoseInPolygon(h.hitPose) && t.subsumedBy == null &&
                facesCamera(h, camera)
            is Point -> t.orientationMode == Point.OrientationMode.ESTIMATED_SURFACE_NORMAL
            is DepthPoint -> true
            else -> false
        }
    }

    /** The camera is on the side of the plane it faces (not seen from behind). */
    private fun facesCamera(h: HitResult, camera: Camera): Boolean {
        val n = FloatArray(3)
        h.hitPose.getTransformedAxis(1, 1f, n, 0)
        val c = camera.pose
        val p = h.hitPose
        return (c.tx() - p.tx()) * n[0] + (c.ty() - p.ty()) * n[1] + (c.tz() - p.tz()) * n[2] > 0
    }

    /** Up to [MAX_CLOUD] of ARCore's feature points, shown while it looks for surfaces. */
    private fun cloud(frame: Frame): FloatArray {
        frame.acquirePointCloud().use { pc ->
            val b = pc.points
            val n = b.remaining() / 4
            val step = maxOf(1, n / MAX_CLOUD)
            val out = ArrayList<Float>()
            var i = 0
            while (i < n && out.size < MAX_CLOUD * 3) {
                if (b.get(i * 4 + 3) > 0.3f) {
                    out.add(b.get(i * 4))
                    out.add(b.get(i * 4 + 1))
                    out.add(b.get(i * 4 + 2))
                }
                i += step
            }
            return out.toFloatArray()
        }
    }

    private companion object {
        const val TAG = "ArMeasure"
        const val MAX_POINTS = 40
        const val MAX_CLOUD = 80
    }
}

/** EGL: a context, a tiny offscreen surface, and the Flutter texture's surface when there is one. */
private class Gl {
    private var display: EGLDisplay = EGL14.EGL_NO_DISPLAY
    private var context: EGLContext = EGL14.EGL_NO_CONTEXT
    private var config: EGLConfig? = null
    private var offscreen: EGLSurface = EGL14.EGL_NO_SURFACE
    private var window: EGLSurface = EGL14.EGL_NO_SURFACE

    val hasWindow get() = window != EGL14.EGL_NO_SURFACE

    fun setUp(surface: Surface?) {
        display = EGL14.eglGetDisplay(EGL14.EGL_DEFAULT_DISPLAY)
        val version = IntArray(2)
        check(EGL14.eglInitialize(display, version, 0, version, 1)) { "eglInitialize" }
        val attribs = intArrayOf(
            EGL14.EGL_RED_SIZE, 8, EGL14.EGL_GREEN_SIZE, 8, EGL14.EGL_BLUE_SIZE, 8,
            EGL14.EGL_ALPHA_SIZE, 8, EGL14.EGL_RENDERABLE_TYPE, EGL14.EGL_OPENGL_ES2_BIT,
            EGL14.EGL_SURFACE_TYPE, EGL14.EGL_WINDOW_BIT or EGL14.EGL_PBUFFER_BIT, EGL14.EGL_NONE,
        )
        val configs = arrayOfNulls<EGLConfig>(1)
        val count = IntArray(1)
        check(EGL14.eglChooseConfig(display, attribs, 0, configs, 0, 1, count, 0) && count[0] > 0) {
            "eglChooseConfig"
        }
        config = configs[0]
        context = EGL14.eglCreateContext(
            display, config, EGL14.EGL_NO_CONTEXT,
            intArrayOf(EGL14.EGL_CONTEXT_CLIENT_VERSION, 2, EGL14.EGL_NONE), 0,
        )
        offscreen = EGL14.eglCreatePbufferSurface(
            display, config, intArrayOf(EGL14.EGL_WIDTH, 1, EGL14.EGL_HEIGHT, 1, EGL14.EGL_NONE), 0,
        )
        EGL14.eglMakeCurrent(display, offscreen, offscreen, context)
        attach(surface)
    }

    fun attach(surface: Surface?) {
        if (display == EGL14.EGL_NO_DISPLAY || surface == null || !surface.isValid) return
        detach()
        window = EGL14.eglCreateWindowSurface(display, config, surface, intArrayOf(EGL14.EGL_NONE), 0)
        if (window == EGL14.EGL_NO_SURFACE) return
        EGL14.eglMakeCurrent(display, window, window, context)
    }

    fun detach() {
        if (!hasWindow) return
        EGL14.eglMakeCurrent(display, offscreen, offscreen, context)
        EGL14.eglDestroySurface(display, window)
        window = EGL14.EGL_NO_SURFACE
    }

    fun swap() {
        EGL14.eglSwapBuffers(display, window)
    }

    fun release() {
        if (display == EGL14.EGL_NO_DISPLAY) return
        detach()
        EGL14.eglMakeCurrent(display, EGL14.EGL_NO_SURFACE, EGL14.EGL_NO_SURFACE, EGL14.EGL_NO_CONTEXT)
        EGL14.eglDestroySurface(display, offscreen)
        EGL14.eglDestroyContext(display, context)
        EGL14.eglTerminate(display)
        display = EGL14.EGL_NO_DISPLAY
    }
}

/** Draws ARCore's camera picture across the whole view. */
private class Background {
    var texture = 0
        private set
    private var program = 0
    private var position = 0
    private var texCoord = 0
    private var sampler = 0
    private val quad = floats(floatArrayOf(-1f, -1f, 1f, -1f, -1f, 1f, 1f, 1f))
    private val uvs = floats(FloatArray(8))

    fun setUp() {
        val t = IntArray(1)
        GLES20.glGenTextures(1, t, 0)
        texture = t[0]
        val target = GLES11Ext.GL_TEXTURE_EXTERNAL_OES
        GLES20.glBindTexture(target, texture)
        GLES20.glTexParameteri(target, GLES20.GL_TEXTURE_WRAP_S, GLES20.GL_CLAMP_TO_EDGE)
        GLES20.glTexParameteri(target, GLES20.GL_TEXTURE_WRAP_T, GLES20.GL_CLAMP_TO_EDGE)
        GLES20.glTexParameteri(target, GLES20.GL_TEXTURE_MIN_FILTER, GLES20.GL_LINEAR)
        GLES20.glTexParameteri(target, GLES20.GL_TEXTURE_MAG_FILTER, GLES20.GL_LINEAR)
        program = GLES20.glCreateProgram()
        GLES20.glAttachShader(program, shader(GLES20.GL_VERTEX_SHADER, VERTEX))
        GLES20.glAttachShader(program, shader(GLES20.GL_FRAGMENT_SHADER, FRAGMENT))
        GLES20.glLinkProgram(program)
        position = GLES20.glGetAttribLocation(program, "a_Position")
        texCoord = GLES20.glGetAttribLocation(program, "a_TexCoord")
        sampler = GLES20.glGetUniformLocation(program, "u_Texture")
    }

    /** Matches the picture to the view's shape and turn. */
    fun fit(frame: Frame) {
        quad.position(0)
        uvs.position(0)
        frame.transformCoordinates2d(
            Coordinates2d.OPENGL_NORMALIZED_DEVICE_COORDINATES, quad,
            Coordinates2d.TEXTURE_NORMALIZED, uvs,
        )
        quad.position(0)
        uvs.position(0)
    }

    fun draw() {
        GLES20.glDisable(GLES20.GL_DEPTH_TEST)
        GLES20.glDepthMask(false)
        GLES20.glUseProgram(program)
        GLES20.glActiveTexture(GLES20.GL_TEXTURE0)
        GLES20.glBindTexture(GLES11Ext.GL_TEXTURE_EXTERNAL_OES, texture)
        GLES20.glUniform1i(sampler, 0)
        GLES20.glVertexAttribPointer(position, 2, GLES20.GL_FLOAT, false, 0, quad)
        GLES20.glVertexAttribPointer(texCoord, 2, GLES20.GL_FLOAT, false, 0, uvs)
        GLES20.glEnableVertexAttribArray(position)
        GLES20.glEnableVertexAttribArray(texCoord)
        GLES20.glDrawArrays(GLES20.GL_TRIANGLE_STRIP, 0, 4)
        GLES20.glDisableVertexAttribArray(position)
        GLES20.glDisableVertexAttribArray(texCoord)
    }

    fun release() {
        if (program != 0) GLES20.glDeleteProgram(program)
        if (texture != 0) GLES20.glDeleteTextures(1, intArrayOf(texture), 0)
        program = 0
        texture = 0
    }

    private fun shader(type: Int, code: String): Int {
        val s = GLES20.glCreateShader(type)
        GLES20.glShaderSource(s, code)
        GLES20.glCompileShader(s)
        return s
    }

    private companion object {
        fun floats(v: FloatArray): FloatBuffer = ByteBuffer.allocateDirect(v.size * 4)
            .order(ByteOrder.nativeOrder()).asFloatBuffer().apply {
                put(v)
                position(0)
            }

        val VERTEX = """
            attribute vec4 a_Position;
            attribute vec2 a_TexCoord;
            varying vec2 v_TexCoord;
            void main() {
                gl_Position = a_Position;
                v_TexCoord = a_TexCoord;
            }
        """.trimIndent()

        val FRAGMENT = """
            #extension GL_OES_EGL_image_external : require
            precision mediump float;
            varying vec2 v_TexCoord;
            uniform samplerExternalOES u_Texture;
            void main() {
                gl_FragColor = texture2D(u_Texture, v_TexCoord);
            }
        """.trimIndent()
    }
}
