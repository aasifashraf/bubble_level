import 'package:flutter/foundation.dart';

import '../../../../data/repositories/orientation_repository.dart';
import '../../../../data/repositories/settings_repository.dart';
import '../../../core/sensor_view_model.dart';

enum MetalLevel { clear, nearby, detected }

@immutable
class MetalState {
  const MetalState({
    required this.field,
    required this.change,
    required this.level,
  });

  /// Magnetic field strength, µT.
  final double field;

  /// Field minus the baseline (the ambient field), µT.
  final double change;

  final MetalLevel level;
}

/// Metal detector from the magnetometer: magnetic (ferrous) metal and
/// magnets change the field around the phone. The baseline is the ambient
/// field, taken automatically when the tool opens and re-set on demand.
class MetalViewModel extends SensorViewModel {
  MetalViewModel({
    required OrientationRepository orientation,
    required this._settings,
    required this._onDetected,
  }) : super(orientation);

  /// Change from the baseline that counts as metal nearby / detected, µT.
  static const nearbyAt = 15.0, detectedAt = 40.0;

  final SettingsRepository _settings;
  final void Function() _onDetected;

  double? _baseline;
  MetalLevel _previous = MetalLevel.clear;
  MetalState? _state;

  MetalState? get state => _state;

  /// Treats the current field as "no metal".
  void setBaseline() {
    _baseline = reading.magnetic?.length;
    update();
  }

  @override
  void onActivate() => _baseline = null;

  @override
  void update() {
    final field = reading.magnetic?.length;
    if (field == null) {
      _state = null;
    } else {
      final baseline = _baseline ??= field;
      final change = field - baseline;
      final level = change.abs() >= detectedAt
          ? MetalLevel.detected
          : change.abs() >= nearbyAt
          ? MetalLevel.nearby
          : MetalLevel.clear;
      if (level == MetalLevel.detected &&
          _previous != MetalLevel.detected &&
          _settings.haptics) {
        _onDetected();
      }
      _previous = level;
      _state = MetalState(field: field, change: change, level: level);
    }
    notifyListeners();
  }
}
