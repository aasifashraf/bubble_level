import 'dart:collection';

import '../../../../data/repositories/orientation_repository.dart';
import '../../../../data/repositories/settings_repository.dart';
import '../../../../domain/angles.dart';
import '../../../../domain/height.dart';
import '../../../../domain/ruler.dart';
import '../../../core/sensor_view_model.dart';

/// Where a measurement is: aiming at the base, at the top, or done.
enum HeightStep { base, top, done }

/// Height & distance by sighting along the phone's top edge: the angle
/// down to an object's base gives the distance (from the eye height), the
/// angle up to its top gives the height. A known distance, if the user has
/// one, replaces the first sighting and is more accurate.
class HeightViewModel extends SensorViewModel {
  HeightViewModel({
    required OrientationRepository orientation,
    required this._settings,
  }) : super(orientation);

  final SettingsRepository _settings;

  double? _live, _base, _top, _knownDistance;

  /// The last second of sight angles, by sensor time (seconds).
  final _recent = Queue<({double t, double angle})>();

  /// The sight angle now, degrees above (+) or below (−) level; null while
  /// the phone is held upright.
  double? get live => _live;

  /// The locked angles, degrees.
  double? get baseAngle => _base;
  double? get topAngle => _top;

  /// The distance the user typed, metres, or null to measure it.
  double? get knownDistance => _knownDistance;

  double get eyeHeight => _settings.eyeHeight;

  /// Feet, when the user measures in inches elsewhere (the ruler).
  bool get imperial => _settings.rulerUnit == LengthUnit.inch;

  HeightStep get step => distance == null
      ? HeightStep.base
      : _top == null
      ? HeightStep.top
      : HeightStep.done;

  /// To the object's base, metres: typed, or from the base sighting.
  double? get distance =>
      _knownDistance ??
      (_base == null ? null : distanceToBase(eyeHeight, _base!));

  double? get height {
    final d = distance, t = _top;
    return d == null || t == null ? null : heightOf(eyeHeight, d, t);
  }

  /// Advice for the angle being aimed now.
  SightAdvice get advice {
    final a = _live;
    if (a == null) return SightAdvice.ok;
    return switch (step) {
      HeightStep.base => adviseBase(a),
      HeightStep.top => adviseTop(a),
      HeightStep.done => SightAdvice.ok,
    };
  }

  /// Whether the lock button can take the angle aimed now.
  bool get canLock {
    final a = _live;
    return switch (step) {
      HeightStep.done => true,
      HeightStep.base => a != null && distanceToBase(eyeHeight, a) != null,
      HeightStep.top => a != null && heightOf(eyeHeight, distance!, a) != null,
    };
  }

  /// Locks the current step's angle, or starts again once done. The angle
  /// is the median of the half second before the tap, leaving out the last
  /// 50 ms, so neither hand wobble nor the tap's jolt moves it.
  void lock() {
    switch (step) {
      case HeightStep.done:
        reset();
        return;
      case HeightStep.base:
        final a = _steady();
        if (a == null || distanceToBase(eyeHeight, a) == null) return;
        _base = a;
      case HeightStep.top:
        final a = _steady();
        if (a == null || heightOf(eyeHeight, distance!, a) == null) return;
        _top = a;
    }
    notifyListeners();
  }

  /// Forgets the sightings; a typed distance stays.
  void reset() {
    _base = _top = null;
    notifyListeners();
  }

  Future<void> setEyeHeight(double metres) async {
    await _settings.setEyeHeight(metres);
    _top = null;
    notifyListeners();
  }

  /// A known distance (metres), or null to measure it by sighting.
  void setKnownDistance(double? metres) {
    _knownDistance = metres;
    _base = _top = null;
    notifyListeners();
  }

  double? _steady() {
    if (_recent.isEmpty) return _live;
    final now = _recent.last.t;
    return median([
          for (final s in _recent)
            if (now - s.t <= 0.5 && now - s.t >= 0.05) s.angle,
        ]) ??
        _live;
  }

  @override
  void onActivate() {
    _recent.clear();
    _base = _top = null;
  }

  @override
  void update() {
    final g = reading.gravity;
    // "Level" honours the Level tab's flat calibration.
    _live = g == null
        ? null
        : sightAngleDeg(rotateFromTo(g, _settings.flatRef, Vec3.up));
    final time = reading.time;
    if (_live != null && time != null) {
      final now = time.microsecondsSinceEpoch / 1e6;
      _recent.addLast((t: now, angle: _live!));
      while (_recent.isNotEmpty && now - _recent.first.t > 1) {
        _recent.removeFirst();
      }
    }
    notifyListeners();
  }
}
