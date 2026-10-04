import '../../../../data/repositories/barometer_repository.dart';
import '../../../../domain/barometer.dart';
import '../../../core/sensor_view_model.dart';

/// Altimeter and barometer: air pressure, approximate altitude, and height
/// relative to a zero you set (reliable over minutes, e.g. floors).
class AltimeterViewModel extends ActiveViewModel {
  AltimeterViewModel({required this._repository}) : super(_repository);

  final BarometerRepository _repository;
  double? _zeroAltitude;

  BarometerReading get reading => _repository.value;
  bool get zeroed => _zeroAltitude != null;

  /// Height above the zero, metres; null until zeroed.
  double? get relative {
    final a = reading.altitude, z = _zeroAltitude;
    return a == null || z == null ? null : a - z;
  }

  void setZero() {
    _zeroAltitude = reading.altitude;
    notifyListeners();
  }

  void clearZero() {
    _zeroAltitude = null;
    notifyListeners();
  }

  @override
  void onActivate() => _repository.start();

  @override
  void onDeactivate() => _repository.stop();

  @override
  void update() => notifyListeners();
}
