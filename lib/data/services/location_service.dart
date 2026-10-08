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

  /// A fix about every second, as precise as the phone allows.
  Stream<LocationFix> fixes() => Geolocator.getPositionStream().map(
    (p) => (
      latitude: p.latitude,
      longitude: p.longitude,
      altitude: p.altitude == 0 && p.altitudeAccuracy == 0 ? null : p.altitude,
      speed: p.speedAccuracy == 0 && p.speed == 0 ? -1.0 : p.speed,
      accuracy: p.accuracy,
      time: p.timestamp,
    ),
  );
}
