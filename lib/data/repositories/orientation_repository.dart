import 'dart:async';

import 'package:flutter/widgets.dart';

import '../../domain/orientation_reading.dart';
import '../../domain/sensor_filters.dart';
import '../services/display_rotation_service.dart';
import '../services/motion_sensor_service.dart';

/// Single source of truth for device orientation. Fuses the raw sensor
/// streams and publishes an [OrientationReading] on every accelerometer
/// sample. The sensors run only while something listens (an open motion
/// tool) and the app is visible, to save battery.
class OrientationRepository extends ValueNotifier<OrientationReading>
    with WidgetsBindingObserver {
  OrientationRepository({
    this._sensors = const MotionSensorService(),
    this._display = const DisplayRotationService(),
  }) : super(const OrientationReading()) {
    _lifecycle = AppLifecycleListener(
      onShow: () {
        if (hasListeners) start();
      },
      onHide: stop,
    );
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void addListener(VoidCallback listener) {
    final first = !hasListeners;
    super.addListener(listener);
    if (first) start();
  }

  @override
  void removeListener(VoidCallback listener) {
    super.removeListener(listener);
    if (!hasListeners) stop();
  }

  final MotionSensorService _sensors;
  final DisplayRotationService _display;
  late final AppLifecycleListener _lifecycle;
  final _gravity = GravityFilter();
  final _magnetic = VectorLowPass(0.25);
  final _subs = <StreamSubscription<Object?>>[];
  Timer? _rotationPoll;
  var _quarterTurns = 0;
  var _accel = SensorState.waiting,
      _gyro = SensorState.waiting,
      _magnet = SensorState.waiting;
  int? _magneticAccuracy;

  static double _seconds(DateTime t) => t.microsecondsSinceEpoch / 1e6;

  void start() {
    if (_subs.isNotEmpty) return;
    _gravity.resetTiming();
    _magnetic.resetTiming();
    _subs.addAll([
      _listen(_sensors.accelerometer(), (s) {
        _accel = SensorState.ok;
        _gravity.addAccel(s.value, _seconds(s.timestamp));
        _publish();
      }, () => _accel = SensorState.missing),
      _listen(_sensors.gyroscope(), (s) {
        _gyro = SensorState.ok;
        _gravity.addGyro(s.value, _seconds(s.timestamp));
      }, () => _gyro = SensorState.missing),
      _listen(_sensors.magnetometer(), (s) {
        _magnet = SensorState.ok;
        _magnetic.add(s.value, _seconds(s.timestamp));
      }, () => _magnet = SensorState.missing),
      // Not every platform reports it; then it's simply unknown.
      _sensors.magneticAccuracy().listen(
        (a) => _magneticAccuracy = a,
        onError: (Object _) => _magneticAccuracy = null,
        cancelOnError: true,
      ),
    ]);
    // A 180° flip doesn't change the window size, so metrics callbacks can
    // miss it; a cheap poll catches every rotation.
    _rotationPoll = Timer.periodic(
      const Duration(milliseconds: 250),
      (_) => _refreshRotation(),
    );
    _refreshRotation();
  }

  StreamSubscription<SensorSample> _listen(
    Stream<SensorSample> stream,
    void Function(SensorSample) onData,
    void Function() onMissing,
  ) => stream.listen(
    onData,
    onError: (Object _) {
      onMissing();
      _publish();
    },
    cancelOnError: true,
  );

  void stop() {
    for (final s in _subs) {
      s.cancel();
    }
    _subs.clear();
    _rotationPoll?.cancel();
    _rotationPoll = null;
  }

  @override
  void didChangeMetrics() => _refreshRotation();

  Future<void> _refreshRotation() async {
    final turns = await _display.quarterTurns();
    if (turns == _quarterTurns || _rotationPoll == null) return;
    _quarterTurns = turns;
    _publish();
  }

  void _publish() {
    value = OrientationReading(
      gravity: _gravity.value,
      magnetic: _magnetic.value,
      quarterTurns: _quarterTurns,
      accel: _accel,
      gyro: _gyro,
      magnet: _magnet,
      magneticAccuracy: _magneticAccuracy,
    );
  }

  @override
  void dispose() {
    stop();
    WidgetsBinding.instance.removeObserver(this);
    _lifecycle.dispose();
    super.dispose();
  }
}
