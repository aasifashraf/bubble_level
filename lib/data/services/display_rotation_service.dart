import 'package:flutter/services.dart';

/// Asks the platform how far the UI is rotated from the device's natural
/// orientation, and the screen's physical density (see MainActivity.kt /
/// AppDelegate.swift).
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

  /// Physical pixels per inch along x and y as the platform reports them,
  /// or null when it doesn't (iOS has no such API). Not trusted blindly:
  /// see `reportedScale`.
  Future<({double xdpi, double ydpi})?> pixelsPerInch() async {
    try {
      final v = await _channel.invokeListMethod<double>('ppi');
      if (v == null || v.length != 2) return null;
      return (xdpi: v[0], ydpi: v[1]);
    } on PlatformException {
      return null;
    } on MissingPluginException {
      return null;
    }
  }
}
