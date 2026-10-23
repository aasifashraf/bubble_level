import AVFoundation
import CoreMotion
import Flutter
import StoreKit
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate, FlutterImplicitEngineDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  func didInitializeImplicitFlutterEngine(_ engineBridge: FlutterImplicitEngineBridge) {
    GeneratedPluginRegistrant.register(with: engineBridge.pluginRegistry)

    // Reports how far the UI is rotated from portrait (in quarter turns,
    // matching Android's Display.rotation) so sensor axes can be mapped
    // onto the screen.
    guard let registrar = engineBridge.pluginRegistry.registrar(forPlugin: "DisplayRotation") else {
      return
    }
    let channel = FlutterMethodChannel(
      name: "bubble_level/display", binaryMessenger: registrar.messenger())
    channel.setMethodCallHandler { call, result in
      guard call.method == "quarterTurns" else {
        result(FlutterMethodNotImplemented)
        return
      }
      let scene = UIApplication.shared.connectedScenes
        .compactMap { $0 as? UIWindowScene }
        .first
      switch scene?.interfaceOrientation {
      case .landscapeRight: result(1)
      case .portraitUpsideDown: result(2)
      case .landscapeLeft: result(3)
      default: result(0)
      }
    }

    // Lists the sensors this device lacks, by the names the app uses.
    let sensors = FlutterMethodChannel(
      name: "bubble_level/sensors", binaryMessenger: registrar.messenger())
    sensors.setMethodCallHandler { call, result in
      guard call.method == "missing" else {
        result(FlutterMethodNotImplemented)
        return
      }
      let motion = CMMotionManager()
      var missing: [String] = []
      if !motion.isAccelerometerAvailable { missing.append("accelerometer") }
      if !motion.isMagnetometerAvailable { missing.append("magnetometer") }
      if !CMAltimeter.isRelativeAltitudeAvailable() { missing.append("barometer") }
      if AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) == nil {
        missing.append("camera")
      }
      result(missing)
    }

    // The magnetic field without the phone's own bias, for the compass
    // (sensors_plus reads the raw field, bias and all).
    FlutterEventChannel(name: "bubble_level/magnetometer", binaryMessenger: registrar.messenger())
      .setStreamHandler(CalibratedMagnetometer())

    // Opens this app's page in Settings, to allow a refused permission,
    // and asks for the App Store's review card.
    let app = FlutterMethodChannel(
      name: "bubble_level/app", binaryMessenger: registrar.messenger())
    app.setMethodCallHandler { call, result in
      // TEMPORARY (test builds): opens Mail to write to the owner.
      if call.method == "email" {
        var mail = URLComponents()
        mail.scheme = "mailto"
        guard let args = call.arguments as? [String: Any],
          let address = args["address"] as? String
        else {
          result(false)
          return
        }
        mail.path = address
        mail.queryItems = [URLQueryItem(name: "subject", value: args["subject"] as? String ?? "")]
        guard let url = mail.url else {
          result(false)
          return
        }
        UIApplication.shared.open(url) { opened in result(opened) }
        return
      }
      // Opens a web page (the owner's site) in the browser.
      if call.method == "openUrl" {
        guard let args = call.arguments as? [String: Any],
          let text = args["url"] as? String,
          let url = URL(string: text)
        else {
          result(false)
          return
        }
        UIApplication.shared.open(url) { opened in result(opened) }
        return
      }
      // Keeps the screen on during a Tracker check on the move.
      if call.method == "keepScreenOn" {
        let on = (call.arguments as? [String: Any])?["on"] as? Bool ?? false
        UIApplication.shared.isIdleTimerDisabled = on
        result(nil)
        return
      }
      // The App Store decides whether the card appears.
      if call.method == "review" {
        if let scene = UIApplication.shared.connectedScenes
          .compactMap({ $0 as? UIWindowScene })
          .first(where: { $0.activationState == .foregroundActive })
        {
          SKStoreReviewController.requestReview(in: scene)
        }
        result(nil)
        return
      }
      guard call.method == "openSettings",
        let url = URL(string: UIApplication.openSettingsURLString)
      else {
        result(FlutterMethodNotImplemented)
        return
      }
      UIApplication.shared.open(url)
      result(nil)
    }
  }
}

/// Sends [x, y, z, accuracy]: the calibrated magnetic field in µT on the
/// device axes, and Core Motion's calibration status shifted to Android's
/// scale (0 unreliable to 3 high). Runs only while the app listens.
class CalibratedMagnetometer: NSObject, FlutterStreamHandler {
  private let motion = CMMotionManager()

  func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink)
    -> FlutterError?
  {
    guard motion.isDeviceMotionAvailable,
      CMMotionManager.availableAttitudeReferenceFrames().contains(.xMagneticNorthZVertical)
    else {
      return FlutterError(code: "NO_SENSOR", message: "This device has no magnetometer", details: nil)
    }
    motion.deviceMotionUpdateInterval = 0.02
    // A magnetic reference frame, or Core Motion leaves the field uncalibrated.
    motion.startDeviceMotionUpdates(using: .xMagneticNorthZVertical, to: .main) { data, _ in
      guard let field = data?.magneticField else { return }
      events([field.field.x, field.field.y, field.field.z, Double(field.accuracy.rawValue + 1)])
    }
    return nil
  }

  func onCancel(withArguments arguments: Any?) -> FlutterError? {
    motion.stopDeviceMotionUpdates()
    return nil
  }
}
