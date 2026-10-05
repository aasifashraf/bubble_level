import '../../domain/orientation_reading.dart';
import '../../domain/sensor_filters.dart';
import '../../domain/vibration.dart';
import '../services/motion_sensor_service.dart';
import 'sensor_stream_repository.dart';

/// Vibration from the acceleration without gravity: current, peak, RMS and
/// a short history for the graph.
///
/// Phones without a linear-acceleration sensor (common when there is no
/// gyroscope) fall back to the plain accelerometer with gravity removed, so
/// the meter still works there.
class VibrationRepository
    extends SensorStreamRepository<SensorSample, VibrationReading> {
  VibrationRepository({this._sensors = const MotionSensorService()})
    : super(const VibrationReading());

  final MotionSensorService _sensors;
  var _meter = VibrationMeter();
  final _gravity = VectorLowPass(0.3);
  var _fromAccelerometer = false;

  @override
  Stream<SensorSample> open() => _fromAccelerometer
      ? _sensors.accelerometer().map(_withoutGravity)
      : _sensors.userAccelerometer();

  /// Gravity is the slow part of the raw acceleration; vibration is the rest.
  SensorSample _withoutGravity(SensorSample s) {
    _gravity.add(s.value, s.timestamp.microsecondsSinceEpoch / 1e6);
    return (value: s.value - _gravity.value!, timestamp: s.timestamp);
  }

  @override
  void onResume() => _gravity.resetTiming();

  @override
  void onSample(SensorSample sample) {
    _meter.add(sample.value, sample.timestamp.microsecondsSinceEpoch / 1e6);
    _publish(SensorState.ok);
  }

  @override
  void onMissing() {
    if (_fromAccelerometer) return _publish(SensorState.missing);
    _fromAccelerometer = true;
    resubscribe();
  }

  /// A fresh meter (no peak or graph), for when the tool opens again.
  void clear() {
    _meter = VibrationMeter();
    value = const VibrationReading();
  }

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
