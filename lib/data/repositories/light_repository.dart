import '../../domain/light.dart';
import '../../domain/orientation_reading.dart';
import '../services/motion_sensor_service.dart';
import 'sensor_stream_repository.dart';

/// The ambient light sensor next to the front camera. It reports only
/// when the level changes, so readings are shown as they come: smoothing
/// would stop partway through a change.
class LightRepository
    extends SensorStreamRepository<ScalarSample, LightReading> {
  LightRepository({this._sensors = const MotionSensorService()})
    : super(const LightReading());

  final MotionSensorService _sensors;

  @override
  Stream<ScalarSample> open() => _sensors.light();

  /// Waits for a fresh reading (the sensor sends one when it starts)
  /// rather than showing the last one as live.
  @override
  void onResume() => value = const LightReading();

  @override
  void onSample(ScalarSample sample) =>
      value = LightReading(lux: sample.value, state: SensorState.ok);

  @override
  void onMissing() =>
      value = LightReading(lux: value.lux, state: SensorState.missing);
}
