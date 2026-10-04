import '../../domain/orientation_reading.dart';
import '../../domain/sound.dart';
import '../services/microphone_service.dart';
import '../services/motion_sensor_service.dart';
import 'sensor_stream_repository.dart';

/// Sound level from the microphone: listens only while started and the app
/// is in front (the base class pauses it when hidden).
class SoundRepository
    extends SensorStreamRepository<ScalarSample, SoundReading> {
  SoundRepository({this._microphone = const MicrophoneService()})
    : super(const SoundReading());

  final MicrophoneService _microphone;
  final _meter = SoundMeter();

  /// Each block lasts 100 ms.
  static const _block = 0.1;

  @override
  Stream<ScalarSample> open() => _microphone.levels();

  @override
  void onSample(ScalarSample sample) {
    _meter.add(sample.value, _block);
    _publish(SensorState.ok);
  }

  @override
  void onMissing() => _publish(SensorState.missing);

  /// A fresh meter, for when the tool opens again.
  void clear() {
    _meter.clear();
    value = const SoundReading();
  }

  /// Starts Max and Average again.
  void resetStats() {
    _meter.reset();
    if (value.level != null) _publish(value.state);
  }

  void _publish(SensorState state) => value = SoundReading(
    level: _meter.level,
    max: _meter.max,
    average: _meter.average,
    state: state,
  );
}
