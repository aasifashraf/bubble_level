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
