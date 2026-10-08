import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';

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
class LocationService {
  const LocationService();

  /// Where access stands now, without asking.
  Future<LocationAccess> check() async {
    try {
      final p = await Geolocator.checkPermission();
      return _access(p, await Geolocator.isLocationServiceEnabled());
    } on Object {
      return LocationAccess.denied;
    }
  }

  /// Shows the system prompt (the explanation has been read).
  Future<LocationAccess> request() async {
    try {
      final p = await Geolocator.requestPermission();
      return _access(p, await Geolocator.isLocationServiceEnabled());
    } on Object {
      return LocationAccess.denied;
    }
  }

  static LocationAccess _access(LocationPermission p, bool on) => switch (p) {
    LocationPermission.always || LocationPermission.whileInUse =>
      on ? LocationAccess.granted : LocationAccess.serviceOff,
    LocationPermission.denied => LocationAccess.needed,
    _ => LocationAccess.denied,
  };

  Future<void> openAppSettings() async {
    try {
      await Geolocator.openAppSettings();
    } on Object {
      // Nothing to open; the message says where to go.
    }
  }

  Future<void> openLocationSettings() async {
    try {
      await Geolocator.openLocationSettings();
    } on Object {
      // Same.
    }
  }

  /// Whether the user allowed precise location; "approximate" (Android 12
  /// and later, iOS) is too coarse for a speed.
  Future<bool> precise() async {
    try {
      return await Geolocator.getLocationAccuracy() ==
          LocationAccuracyStatus.precise;
    } on Object {
      return true;
    }
  }

  /// A fix about every second, as precise as the phone allows, with the
  /// altitude above sea level where the phone can give it. Never in the
  /// background.
  Stream<LocationFix> fixes() =>
      Geolocator.getPositionStream(
        locationSettings: switch (defaultTargetPlatform) {
          // Without an interval Android sends a fix only every 5 s.
          TargetPlatform.android => AndroidSettings(
            intervalDuration: const Duration(seconds: 1),
            useMSLAltitude: true,
          ),
          TargetPlatform.iOS || TargetPlatform.macOS => AppleSettings(
            accuracy: LocationAccuracy.bestForNavigation,
            activityType: ActivityType.automotiveNavigation,
            allowBackgroundLocationUpdates: false,
          ),
          _ => const LocationSettings(),
        },
      ).map(
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
}
