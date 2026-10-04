import 'package:flutter/services.dart';

/// Asks the platform how far the UI is rotated from the device's natural
/// orientation (see MainActivity.kt / AppDelegate.swift).
class DisplayRotationService {
  const DisplayRotationService();

  static const _channel = MethodChannel('bubble_level/display');

  /// 0–3 quarter turns; 0 when the platform can't tell.
  Future<int> quarterTurns() async {
    try {
      return await _channel.invokeMethod<int>('quarterTurns') ?? 0;
    } on PlatformException {
      return 0;
    } on MissingPluginException {
      return 0;
    }
  }
}
