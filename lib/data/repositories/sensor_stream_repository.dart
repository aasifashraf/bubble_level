import 'dart:async';

import 'package:flutter/widgets.dart';

/// A repository fed by one sensor stream that runs only while wanted:
/// [start] when its tool opens, [stop] when it closes. It also pauses while
/// the app is hidden, and reports a missing sensor through [onMissing].
abstract class SensorStreamRepository<S, R> extends ValueNotifier<R> {
  SensorStreamRepository(super.value) {
    _lifecycle = AppLifecycleListener(onShow: _resume, onHide: _pause);
  }

  late final AppLifecycleListener _lifecycle;
  StreamSubscription<S>? _subscription;
  bool _wanted = false;

  /// Opens the sensor stream; it errors when the device lacks the sensor.
  @protected
  Stream<S> open();

  @protected
  void onSample(S sample);

  @protected
  void onMissing();

  /// Called before (re)subscribing, e.g. to reset filter timing.
  @protected
  void onResume() {}

  void start() {
    _wanted = true;
    _resume();
  }

  void stop() {
    _wanted = false;
    _pause();
  }

  void _resume() {
    if (!_wanted || _subscription != null) return;
    onResume();
    _subscription = open().listen(
      onSample,
      onError: (Object _) {
        _subscription = null;
        onMissing();
      },
      // A stream that ends (e.g. the microphone taken by a call) would
      // otherwise leave a frozen reading that looks live.
      onDone: () {
        _subscription = null;
        if (_wanted) onMissing();
      },
      cancelOnError: true,
    );
  }

  /// Subscribes again, e.g. to a fallback stream chosen in [onMissing].
  @protected
  void resubscribe() {
    _pause();
    _resume();
  }

  void _pause() {
    _subscription?.cancel();
    _subscription = null;
  }

  @override
  void dispose() {
    _pause();
    _lifecycle.dispose();
    super.dispose();
  }
}
