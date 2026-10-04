import 'dart:async';
import 'dart:math' as math;

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
///
/// Like a real detector it beeps, faster the bigger the change, so you can
/// sweep without watching the screen; silent while no metal is nearby.
class MetalViewModel extends SensorViewModel {
  MetalViewModel({
    required OrientationRepository orientation,
    required this._settings,
    required this._onDetected,
    this._onTick = _silent,
  }) : super(orientation);

  /// Change from the baseline that counts as metal nearby / detected, µT.
  static const nearbyAt = 15.0, detectedAt = 40.0;

  final SettingsRepository _settings;
  final void Function() _onDetected;

  /// Plays one beep.
  final void Function() _onTick;

  static void _silent() {}

  /// Change at which the beeping is fastest, µT.
  static const fastestAt = 150.0;
  static const slowestGap = Duration(milliseconds: 900);
  static const fastestGap = Duration(milliseconds: 90);
  static const _beat = Duration(milliseconds: 30);

  Timer? _beeper;
  Duration _sinceTick = const Duration(days: 1);

  /// Gap between beeps for a [change] from the baseline, or null for
  /// silence (no metal nearby). Shrinks geometrically, so the speed-up is
  /// felt evenly as you get closer.
  static Duration? beepGap(double change) {
    final c = change.abs();
    if (c < nearbyAt) return null;
    final f = ((c - nearbyAt) / (fastestAt - nearbyAt)).clamp(0.0, 1.0);
    final ms =
        slowestGap.inMilliseconds *
        math.pow(fastestGap.inMilliseconds / slowestGap.inMilliseconds, f);
    return Duration(milliseconds: ms.round());
  }

  bool get soundOn => _settings.sounds;

  void toggleSound() {
    _settings.setSounds(!_settings.sounds);
    _syncBeeper();
    notifyListeners();
  }

  /// Runs a light beat while the tool is open with sound on; each beat
  /// beeps once the gap for the current change has passed.
  void _syncBeeper() {
    final on = active && _settings.sounds;
    if (on && _beeper == null) {
      _beeper = Timer.periodic(_beat, (_) => _onBeat());
    } else if (!on) {
      _beeper?.cancel();
      _beeper = null;
    }
  }

  void _onBeat() {
    final gap = beepGap(_state?.change ?? 0);
    if (gap == null) {
      // The first beep comes at once when metal appears.
      _sinceTick = const Duration(days: 1);
      return;
    }
    _sinceTick += _beat;
    if (_sinceTick >= gap) {
      _sinceTick = Duration.zero;
      _onTick();
    }
  }

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
  void onActivate() {
    _baseline = null;
    _syncBeeper();
  }

  @override
  void onDeactivate() => _syncBeeper();

  @override
  void dispose() {
    _beeper?.cancel();
    super.dispose();
  }

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
