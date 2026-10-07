import '../../../../data/repositories/vibration_repository.dart';
import '../../../../domain/vibration.dart';
import '../../../core/sensor_view_model.dart';

enum VibrationLevel { still, light, strong }

/// Vibration meter: strength and frequency. Runs the acceleration sensor
/// only while open; the lock holds the reading on screen.
class VibrationViewModel extends ActiveViewModel {
  VibrationViewModel({required this._repository}) : super(_repository);

  /// RMS thresholds for light and strong vibration, m/s².
  static const lightAt = 0.3, strongAt = 2.0;

  final VibrationRepository _repository;
  VibrationReading? _held;

  VibrationReading get reading => _held ?? _repository.value;

  bool get locked => _held != null;

  VibrationLevel get level => reading.rms >= strongAt
      ? VibrationLevel.strong
      : reading.rms >= lightAt
      ? VibrationLevel.light
      : VibrationLevel.still;

  /// The strongest frequency, Hz, when one clearly stands out.
  double? get frequency => reading.spectrum?.peakHz;

  void toggleLock() {
    _held = _held == null ? _repository.value : null;
    notifyListeners();
  }

  /// Starts again, for the next machine.
  void reset() {
    _held = null;
    _repository.clear();
    notifyListeners();
  }

  @override
  void onActivate() {
    _held = null;
    _repository
      ..clear()
      ..start();
  }

  @override
  void onDeactivate() => _repository.stop();

  @override
  void update() {
    // Held: the sensor keeps running, the screen doesn't change.
    if (_held == null) notifyListeners();
  }
}
