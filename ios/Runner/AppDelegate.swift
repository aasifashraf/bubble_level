import CoreMotion
import Flutter
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
      result(missing)
    }
  }
}
