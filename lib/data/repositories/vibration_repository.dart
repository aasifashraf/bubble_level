import '../../domain/orientation_reading.dart';
import '../../domain/vibration.dart';
import '../services/motion_sensor_service.dart';
import 'sensor_stream_repository.dart';

/// Vibration from the acceleration without gravity: current, peak, RMS and
/// a short history for the graph.
class VibrationRepository
    extends SensorStreamRepository<SensorSample, VibrationReading> {
  VibrationRepository({this._sensors = const MotionSensorService()})
    : super(const VibrationReading());

  final MotionSensorService _sensors;
  final _meter = VibrationMeter();

  @override
  Stream<SensorSample> open() => _sensors.userAccelerometer();

  @override
  void onSample(SensorSample sample) {
    _meter.add(sample.value, sample.timestamp.microsecondsSinceEpoch / 1e6);
    _publish(SensorState.ok);
  }

  @override
  void onMissing() => _publish(SensorState.missing);

  void resetPeak() {
    _meter.resetPeak();
    _publish(value.state);
  }

  void _publish(SensorState state) {
    value = VibrationReading(
      current: _meter.current,
      peak: _meter.peak,
      rms: _meter.rms,
      history: _meter.history,
      state: state,
    );
  }
}
