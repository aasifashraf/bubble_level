import '../../../../data/repositories/vibration_repository.dart';
import '../../../../domain/vibration.dart';
import '../../../core/sensor_view_model.dart';

enum VibrationLevel { still, light, strong }

/// Vibration meter: runs the acceleration sensor only while open.
class VibrationViewModel extends ActiveViewModel {
  VibrationViewModel({required this._repository}) : super(_repository);

  /// RMS thresholds for light and strong vibration, m/s².
  static const lightAt = 0.3, strongAt = 2.0;

  final VibrationRepository _repository;

  VibrationReading get reading => _repository.value;

  VibrationLevel get level => reading.rms >= strongAt
      ? VibrationLevel.strong
      : reading.rms >= lightAt
      ? VibrationLevel.light
      : VibrationLevel.still;

  void resetPeak() => _repository.resetPeak();

  @override
  void onActivate() => _repository.start();

  @override
  void onDeactivate() => _repository.stop();

  @override
  void update() => notifyListeners();
}
