import 'package:flutter/services.dart';

/// Hardware a tool can depend on (the microphone counts too).
enum SensorKind { accelerometer, magnetometer, barometer, light, microphone }

/// Asks the platform which sensors this device lacks (see MainActivity.kt /
/// AppDelegate.swift), so home can say so before a tool is opened.
class SensorAvailabilityService {
  const SensorAvailabilityService();

  static const _channel = MethodChannel('bubble_level/sensors');

  /// The missing sensors; empty when the platform can't tell, in which case
  /// each tool still finds out when it opens.
  Future<Set<SensorKind>> missing() async {
    try {
      final names = await _channel.invokeListMethod<String>('missing') ?? [];
      return {
        for (final kind in SensorKind.values)
          if (names.contains(kind.name)) kind,
      };
    } on PlatformException {
      return {};
    } on MissingPluginException {
      return {};
    }
  }
}
