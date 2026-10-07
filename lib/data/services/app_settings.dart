import 'package:flutter/services.dart';

const _app = MethodChannel('bubble_level/app');

/// Opens this app's page in the phone's Settings, to allow a permission
/// that was refused.
Future<void> openAppSettings() async {
  try {
    await _app.invokeMethod<void>('openSettings');
  } on PlatformException {
    // Nothing to open; the message already says where to go.
  } on MissingPluginException {
    // Same.
  }
}
