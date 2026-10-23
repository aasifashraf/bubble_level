import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import '../../domain/orientation_reading.dart';
import '../../domain/sensor_filters.dart';
import '../services/display_rotation_service.dart';
import '../services/motion_sensor_service.dart';

/// Single source of truth for device orientation. Fuses the raw sensor
/// streams and publishes an [OrientationReading] on every accelerometer
/// sample. The sensors run only while something listens (an open motion
/// tool) and the app is visible, to save battery; the magnetometer only
/// while a tool that needs it ([useMagnetometer]) is open.
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
  var _gravity = GravityFilter();
  var _magnetic = MagneticFilter();
  var _strength = ScalarLowPass(0.25);
  final _subs = <StreamSubscription<Object?>>[];
  final _magneticSubs = <StreamSubscription<Object?>>[];
  var _magneticUsers = 0;
  Timer? _rotationPoll, _rotationRecheck;
  var _quarterTurns = 0;
  var _accel = SensorState.waiting,
      _gyro = SensorState.waiting,
      _magnet = SensorState.waiting;
  int? _magneticAccuracy;
  DateTime? _time;

  static double _seconds(DateTime t) => t.microsecondsSinceEpoch / 1e6;

  /// A tool that reads the magnetic field (the compass, the metal
  /// detector) asks for it while it is open; the others leave it off.
  void useMagnetometer(bool on) {
    _magneticUsers = (_magneticUsers + (on ? 1 : -1)).clamp(0, 1 << 20);
    if (_subs.isEmpty) return;
    if (_magneticUsers > 0) {
      _startMagnetic();
    } else {
      _stopMagnetic();
      _publish();
    }
  }

  void start() {
    if (_subs.isNotEmpty) return;
    _subs.addAll([
      _listen(_sensors.accelerometer(), (s) {
        _accel = SensorState.ok;
        _time = s.timestamp;
        _gravity.addAccel(s.value, _seconds(s.timestamp));
        _publish();
      }, () => _accel = SensorState.missing),
      _listen(_sensors.gyroscope(), (s) {
        _gyro = SensorState.ok;
        _gravity.addGyro(s.value, _seconds(s.timestamp));
        _magnetic.addGyro(s.value, _seconds(s.timestamp));
      }, () => _gyro = SensorState.missing),
    ]);
    if (_magneticUsers > 0) _startMagnetic();
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

  void _startMagnetic() {
    if (_magneticSubs.isNotEmpty) return;
    // iOS: sensors_plus gives the raw field there, bias and all; the
    // system's own calibrated one comes with its accuracy.
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      _magneticSubs.add(
        _sensors.calibratedMagnetometer().listen(
          (e) {
            _magneticAccuracy = e.accuracy;
            // Core Motion may send no field until it has calibrated.
            if (e.sample.value.length > 0) _addMagnetic(e.sample);
          },
          onError: (Object _) {
            _magnet = SensorState.missing;
            _publish();
          },
          cancelOnError: true,
        ),
      );
      return;
    }
    _magneticSubs.add(
      _listen(
        _sensors.magnetometer(),
        _addMagnetic,
        () => _magnet = SensorState.missing,
      ),
    );
    // Only Android reports it (MainActivity.kt); elsewhere it's unknown.
    if (defaultTargetPlatform == TargetPlatform.android) {
      _magneticSubs.add(
        _sensors.magneticAccuracy().listen(
          (a) => _magneticAccuracy = a,
          onError: (Object _) => _magneticAccuracy = null,
          cancelOnError: true,
        ),
      );
    }
  }

  void _addMagnetic(SensorSample s) {
    _magnet = SensorState.ok;
    _magnetic.add(s.value, _seconds(s.timestamp));
    _strength.add(s.value.length, _seconds(s.timestamp));
  }

  void _stopMagnetic() {
    for (final s in _magneticSubs) {
      s.cancel();
    }
    _magneticSubs.clear();
    _magnetic = MagneticFilter();
    _strength = ScalarLowPass(0.25);
    _magnet = SensorState.waiting;
    _magneticAccuracy = null;
  }

  /// Stops the sensors and forgets the last readings, so a tool opened
  /// later (or the app shown again) never starts from an old value.
  void stop() {
    for (final s in _subs) {
      s.cancel();
    }
    _subs.clear();
    _stopMagnetic();
    _rotationPoll?.cancel();
    _rotationPoll = null;
    _rotationRecheck?.cancel();
    _gravity = GravityFilter();
    _accel = _gyro = SensorState.waiting;
    _time = null;
    _publish();
  }

  /// The window changed size, most likely because the screen turned: ask
  /// now, and once more a moment later in case the platform reports the
  /// new rotation a frame late, so a heading never reads off the old one.
  @override
  void didChangeMetrics() {
    if (_rotationPoll == null) return;
    _refreshRotation();
    _rotationRecheck?.cancel();
    _rotationRecheck = Timer(
      const Duration(milliseconds: 120),
      _refreshRotation,
    );
  }

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
      magneticStrength: _strength.value,
      quarterTurns: _quarterTurns,
      accel: _accel,
      gyro: _gyro,
      magnet: _magnet,
      magneticAccuracy: _magneticAccuracy,
      time: _time,
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
