import '../../../../data/repositories/light_repository.dart';
import '../../../../domain/light.dart';
import '../../../core/sensor_view_model.dart';

/// Light meter: illuminance in lux and foot-candles, with what the level
/// is good for. The lock holds a reading while you move the phone away.
class LightViewModel extends ActiveViewModel {
  LightViewModel({required this._repository}) : super(_repository);

  final LightRepository _repository;

  LightReading? _held;

  /// The live reading, or the one held by the lock.
  LightReading get reading => _held ?? _repository.value;

  bool get locked => _held != null;

  /// Only a real reading can be held.
  void toggleLock() {
    final live = _repository.value;
    _held = _held == null && live.lux != null ? live : null;
    notifyListeners();
  }

  @override
  void onActivate() {
    _held = null;
    _repository.start();
  }

  @override
  void onDeactivate() => _repository.stop();

  @override
  void update() => notifyListeners();
}
