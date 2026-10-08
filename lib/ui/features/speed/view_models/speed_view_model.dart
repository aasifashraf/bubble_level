import 'dart:async';

import 'dart:ui' show PlatformDispatcher;

import 'package:flutter/widgets.dart';

import '../../../../data/repositories/settings_repository.dart';
import '../../../../data/repositories/speed_repository.dart';
import '../../../../data/services/location_service.dart';
import '../../../../domain/scene_weather.dart';
import '../../../../domain/speed.dart';
import '../../../core/sensor_view_model.dart';

/// Speedometer: speed, trip distance, top and average speed, GPS altitude
/// and coordinates. Location is used only while the tool is open and in
/// front; before the first use it explains why, then asks.
class SpeedViewModel extends ActiveViewModel {
  SpeedViewModel({
    required this._repository,
    required this._settings,
    this._location = const LocationService(),
    DateTime Function()? now,
  }) : _now = now ?? DateTime.now,
       super(_repository);

  final DateTime Function() _now;

  final SpeedRepository _repository;
  final SettingsRepository _settings;
  final LocationService _location;

  LocationAccess? _access;
  bool _asked = false;
  AppLifecycleListener? _lifecycle;

  /// Null while finding out.
  LocationAccess? get access => _access;

  SpeedReading get reading => _repository.value;

  /// The weather the user picked for the scene, or null for the season's.
  SceneWeather? get pickedWeather => _settings.driveWeather;

  /// The scene's weather: scenery, never a forecast.
  SceneWeather get weather =>
      pickedWeather ??
      seasonalWeather(
        _now(),
        countryCode: PlatformDispatcher.instance.locale.countryCode,
      );

  /// Day, dusk or night by the phone's clock.
  DayPart get dayPart => dayPartOf(_now());

  Future<void> pickWeather(SceneWeather? weather) =>
      _settings.setDriveWeather(weather);

  /// Miles per hour instead of km/h.
  bool get mph => _settings.speedMph;

  void toggleUnit() => unawaited(_settings.setSpeedMph(!mph));

  /// Speed in the chosen unit.
  double perHour(double ms) => ms * (mph ? mphPerMs : kmhPerMs);

  /// Shows the system prompt (the explanation has been read).
  Future<void> allow() async {
    _asked = true;
    final a = await _location.request();
    // Refused: point to Settings rather than explain again.
    _set(a == LocationAccess.needed ? LocationAccess.denied : a);
  }

  Future<void> openSettings() => _access == LocationAccess.serviceOff
      ? _location.openLocationSettings()
      : _location.openAppSettings();

  void resetTrip() => _repository.resetTrip();

  Future<void> _check() async {
    final a = await _location.check();
    // Asked and still not allowed: point to Settings rather than ask again.
    _set(a == LocationAccess.needed && _asked ? LocationAccess.denied : a);
  }

  void _set(LocationAccess a) {
    if (!active) return;
    _access = a;
    if (a == LocationAccess.granted) {
      _repository.start();
    } else {
      _repository.stop();
    }
    notifyListeners();
  }

  @override
  void onActivate() {
    _access = null;
    _settings.addListener(notifyListeners);
    // Back from Settings: check again.
    _lifecycle = AppLifecycleListener(onShow: () => unawaited(_check()));
    unawaited(_check());
  }

  @override
  void onDeactivate() {
    _settings.removeListener(notifyListeners);
    _lifecycle?.dispose();
    _lifecycle = null;
    _repository.stop();
  }

  @override
  void update() => notifyListeners();
}
