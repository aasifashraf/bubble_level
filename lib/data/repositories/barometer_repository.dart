import '../../domain/barometer.dart';
import '../../domain/orientation_reading.dart';
import '../../domain/sensor_filters.dart';
import '../services/motion_sensor_service.dart';
import 'sensor_stream_repository.dart';

/// Smoothed air pressure from the barometer, which many phones lack.
class BarometerRepository
    extends SensorStreamRepository<ScalarSample, BarometerReading> {
  BarometerRepository({this._sensors = const MotionSensorService()})
    : super(const BarometerReading());

  final MotionSensorService _sensors;
  final _filter = ScalarLowPass(0.6);

  @override
  Stream<ScalarSample> open() => _sensors.barometer();

  @override
  void onResume() => _filter.resetTiming();

  @override
  void onSample(ScalarSample sample) {
    _filter.add(sample.value, sample.timestamp.microsecondsSinceEpoch / 1e6);
    value = BarometerReading(pressure: _filter.value, state: SensorState.ok);
  }

  @override
  void onMissing() => value = BarometerReading(
    pressure: value.pressure,
    state: SensorState.missing,
  );
}
