import '../../domain/g_force.dart';
import '../../domain/orientation_reading.dart';
import '../services/motion_sensor_service.dart';
import 'sensor_stream_repository.dart';

/// The g-force meter's accelerometer: raw readings (gravity included), so
/// Zero can learn which way is down. Zeroes itself once on opening; the
/// user zeroes again while the car stands still.
class GForceRepository extends SensorStreamRepository<SensorSample, GReading> {
  GForceRepository({this._sensors = const MotionSensorService()})
    : super(const GReading());

  final MotionSensorService _sensors;
  var _meter = GMeter();

  @override
  Stream<SensorSample> open() => _sensors.accelerometer();

  @override
  void onSample(SensorSample sample) {
    _meter.add(sample.value, sample.timestamp.microsecondsSinceEpoch / 1e6);
    if (!_meter.zeroed && _meter.canAutoZero) _meter.zero();
    value = _meter.reading(SensorState.ok);
  }

  @override
  void onMissing() => value = _meter.reading(SensorState.missing);

  /// Learns down and forward from the last half second.
  void zero() {
    if (_meter.zero()) value = _meter.reading(value.state);
  }

  void resetPeaks() {
    _meter.resetPeaks();
    value = _meter.reading(value.state);
  }

  /// A fresh start for when the tool opens again.
  void clear() {
    _meter = GMeter();
    value = GReading(state: value.state);
  }
}
