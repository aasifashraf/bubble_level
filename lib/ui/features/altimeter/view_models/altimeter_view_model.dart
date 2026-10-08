import 'dart:ui';

import '../../../../data/repositories/barometer_repository.dart';
import '../../../../data/repositories/settings_repository.dart';
import '../../../../domain/barometer.dart';
import '../../../../domain/scene_weather.dart';
import '../../../core/sensor_view_model.dart';

/// Altimeter and barometer: air pressure, approximate altitude, and height
/// relative to a zero you set (reliable over minutes, e.g. floors).
class AltimeterViewModel extends ActiveViewModel {
  AltimeterViewModel({
    required this._repository,
    required this._settings,
    DateTime Function()? now,
  }) : _now = now ?? DateTime.now,
       super(_repository);

  final BarometerRepository _repository;
  final SettingsRepository _settings;
  final DateTime Function() _now;
  double? _zeroAltitude;
  double _highest = 0;
  DateTime? _closedAt;

  /// A zero older than this (the tool closed in between) is forgotten: the
  /// weather moves the pressure by then, which would read as height.
  static const zeroKeptFor = Duration(minutes: 30);

  /// The highest point above the zero so far, metres (0 before zeroing).
  double get highest => _highest;

  /// The weather the user picked, or null to follow the clock and season.
  SceneWeather? get pickedWeather => _settings.sceneWeather;

  /// The scene's weather: the user's pick, or the season's.
  SceneWeather get weather =>
      pickedWeather ??
      seasonalWeather(
        _now(),
        countryCode: PlatformDispatcher.instance.locale.countryCode,
      );

  /// Night by the phone's clock.
  bool get night => isNight(_now());

  Future<void> pickWeather(SceneWeather? weather) async {
    await _settings.setSceneWeather(weather);
    notifyListeners();
  }

  BarometerReading get reading => _repository.value;
  bool get zeroed => _zeroAltitude != null;

  /// Height above the zero, metres; null until zeroed.
  double? get relative {
    final a = reading.altitude, z = _zeroAltitude;
    return a == null || z == null ? null : a - z;
  }

  void setZero() {
    _zeroAltitude = reading.altitude;
    _highest = 0;
    notifyListeners();
  }

  void clearZero() {
    _zeroAltitude = null;
    _highest = 0;
    notifyListeners();
  }

  @override
  void onActivate() {
    final closed = _closedAt;
    if (closed != null && _now().difference(closed) > zeroKeptFor) {
      _zeroAltitude = null;
      _highest = 0;
    }
    _repository.start();
  }

  @override
  void onDeactivate() {
    _closedAt = _now();
    _repository.stop();
  }

  @override
  void update() {
    final r = relative;
    if (r != null && r > _highest) _highest = r;
    notifyListeners();
  }
}
