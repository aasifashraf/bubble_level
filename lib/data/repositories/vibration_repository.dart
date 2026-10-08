import '../../domain/orientation_reading.dart';
import '../../domain/sensor_filters.dart';
import '../../domain/vibration.dart';
import '../../domain/vibration_frequency.dart';
import '../services/motion_sensor_service.dart';
import 'sensor_stream_repository.dart';

/// Vibration from the acceleration without gravity: current, peak, RMS and
/// its frequency. The sensor runs as fast as the phone allows, so the
/// frequency can be measured up to about 100 Hz.
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
  final _frequency = FrequencyAnalyzer();
  Spectrum? _spectrum;
  double? _analyzedAt;

  /// How often the spectrum is worked out again, seconds.
  static const _every = 0.25;
  final _gravity = VectorLowPass(0.3);
  var _fromAccelerometer = false;

  @override
  Stream<SensorSample> open() => _fromAccelerometer
      ? _sensors.accelerometer(fast: true).map(_withoutGravity)
      : _sensors.userAccelerometer(fast: true);

  /// Gravity is the slow part of the raw acceleration; vibration is the rest.
  SensorSample _withoutGravity(SensorSample s) {
    _gravity.add(s.value, s.timestamp.microsecondsSinceEpoch / 1e6);
    return (value: s.value - _gravity.value!, timestamp: s.timestamp);
  }

  @override
  void onResume() => _gravity.resetTiming();

  @override
  void onSample(SensorSample sample) {
    final t = sample.timestamp.microsecondsSinceEpoch / 1e6;
    _meter.add(sample.value, t);
    _frequency.add(sample.value, t);
    if (_analyzedAt == null || t - _analyzedAt! >= _every || t < _analyzedAt!) {
      _analyzedAt = t;
      _spectrum = _frequency.analyze();
    }
    // The sensor runs as fast as it can (up to 200 a second) for the
    // analysis; the screen needs far fewer updates.
    if (_publishedAt == null ||
        t - _publishedAt! >= _redraw ||
        t < _publishedAt!) {
      _publishedAt = t;
      _publish(SensorState.ok);
    }
  }

  /// Seconds between screen updates (30 a second).
  static const _redraw = 1 / 30;
  double? _publishedAt;

  @override
  void onMissing() {
    if (_fromAccelerometer) return _publish(SensorState.missing);
    _fromAccelerometer = true;
    resubscribe();
  }

  /// A fresh start (no peak or frequency): when the tool opens again, or
  /// on Reset before measuring another machine.
  void clear() {
    _meter = VibrationMeter();
    _frequency.clear();
    _spectrum = null;
    _analyzedAt = null;
    _publishedAt = null;
    value = VibrationReading(state: value.state);
  }

  void _publish(SensorState state) {
    value = VibrationReading(
      current: _meter.current,
      peak: _meter.peak,
      rms: _meter.rms,
      history: _meter.history,
      spectrum: _spectrum,
      state: state,
    );
  }
}
