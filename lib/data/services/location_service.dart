import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:geolocator_apple/geolocator_apple.dart';
import 'package:geolocator_platform_interface/geolocator_platform_interface.dart';

import '../../domain/speed.dart';

/// Where location stands for the speedometer.
enum LocationAccess {
  /// Not asked yet: explain, then ask.
  needed,

  /// Refused: point to Settings.
  denied,

  /// Allowed, but the phone's location is switched off.
  serviceOff,
  granted,
}

/// GPS for the speedometer, only while it's open and in front (never in
/// the background). Fixes stay on the phone: shown, never stored or sent.
///
/// Android uses its own LocationManager (`Gps.kt`), so no build needs
/// Google Play services; iOS uses Core Location through geolocator.
class LocationService {
  const LocationService();

  static const _android = MethodChannel('bubble_level/location');
  static const _androidFixes = EventChannel('bubble_level/location_fixes');
  static const _app = MethodChannel('bubble_level/app');

  static bool get _isAndroid => defaultTargetPlatform == TargetPlatform.android;

  static GeolocatorPlatform get _apple => GeolocatorPlatform.instance;

  /// Where access stands now, without asking.
  Future<LocationAccess> check() async {
    try {
      if (_isAndroid) return _named(await _android.invokeMethod('check'));
      final p = await _apple.checkPermission();
      return _access(p, await _apple.isLocationServiceEnabled());
    } on Object {
      return LocationAccess.denied;
    }
  }

  /// Shows the system prompt (the explanation has been read).
  Future<LocationAccess> request() async {
    try {
      if (_isAndroid) return _named(await _android.invokeMethod('request'));
      final p = await _apple.requestPermission();
      return _access(p, await _apple.isLocationServiceEnabled());
    } on Object {
      return LocationAccess.denied;
    }
  }

  static LocationAccess _named(Object? name) => LocationAccess.values
      .firstWhere((a) => a.name == name, orElse: () => LocationAccess.denied);

  static LocationAccess _access(LocationPermission p, bool on) => switch (p) {
    LocationPermission.always || LocationPermission.whileInUse =>
      on ? LocationAccess.granted : LocationAccess.serviceOff,
    LocationPermission.denied => LocationAccess.needed,
    _ => LocationAccess.denied,
  };

  Future<void> openAppSettings() async {
    try {
      await _app.invokeMethod<void>('openSettings');
    } on Object {
      // Nothing to open; the message says where to go.
    }
  }

  Future<void> openLocationSettings() async {
    try {
      if (_isAndroid) {
        await _android.invokeMethod<void>('openLocationSettings');
      } else {
        await _apple.openLocationSettings();
      }
    } on Object {
      // Same.
    }
  }

  /// Whether the user allowed precise location; "approximate" (Android 12
  /// and later, iOS) is too coarse for a speed.
  Future<bool> precise() async {
    try {
      if (_isAndroid) {
        return await _android.invokeMethod<bool>('precise') ?? true;
      }
      return await _apple.getLocationAccuracy() ==
          LocationAccuracyStatus.precise;
    } on Object {
      return true;
    }
  }

  /// A fix about every second, as precise as the phone allows, with the
  /// altitude above sea level where the phone can give it. Never in the
  /// background.
  Stream<LocationFix> fixes() => _isAndroid
      ? _androidFixes.receiveBroadcastStream().map(
          (e) => androidFix((e as Map).cast<String, Object?>()),
        )
      : _apple
            .getPositionStream(
              locationSettings: AppleSettings(
                accuracy: LocationAccuracy.bestForNavigation,
                activityType: ActivityType.automotiveNavigation,
                allowBackgroundLocationUpdates: false,
              ),
            )
            .map(
              (p) => (
                latitude: p.latitude,
                longitude: p.longitude,
                altitude: p.altitude == 0 && p.altitudeAccuracy == 0
                    ? null
                    : p.altitude,
                speed: p.speedAccuracy == 0 && p.speed == 0 ? -1.0 : p.speed,
                accuracy: p.accuracy,
                time: p.timestamp,
              ),
            );

  /// A fix as `Gps.kt` sends it (only fixes with an accuracy). Speed is
  /// negative when the receiver gave none.
  @visibleForTesting
  static LocationFix androidFix(Map<String, Object?> m) => (
    latitude: (m['latitude']! as num).toDouble(),
    longitude: (m['longitude']! as num).toDouble(),
    altitude: (m['altitude'] as num?)?.toDouble(),
    speed: (m['speed'] as num?)?.toDouble() ?? -1,
    accuracy: (m['accuracy']! as num).toDouble(),
    time: DateTime.fromMillisecondsSinceEpoch((m['time']! as num).toInt()),
  );
}
