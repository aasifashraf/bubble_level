import 'package:flutter/foundation.dart';

import '../../data/repositories/orientation_repository.dart';
import '../../domain/orientation_reading.dart';

/// Base for view models that only do work while [active] (their screen is
/// showing), so hidden tools cost nothing and can't fire side effects such
/// as haptics. It follows [source] while active; subclasses can also start
/// and stop their own sensors in [onActivate] / [onDeactivate].
abstract class ActiveViewModel extends ChangeNotifier {
  ActiveViewModel(this._source);

  final Listenable _source;
  bool _active = false;

  bool get active => _active;

  set active(bool value) {
    if (value == _active) return;
    _active = value;
    if (value) {
      onActivate();
      _source.addListener(update);
      update();
    } else {
      _source.removeListener(update);
      onDeactivate();
    }
  }

  @protected
  void onActivate() {}

  @protected
  void onDeactivate() {}

  /// Recomputes state from the source and notifies listeners.
  @protected
  void update();

  @override
  void dispose() {
    active = false;
    super.dispose();
  }
}

/// A view model driven by the shared orientation sensors.
abstract class SensorViewModel extends ActiveViewModel {
  SensorViewModel(this._orientation) : super(_orientation);

  final OrientationRepository _orientation;

  OrientationReading get reading => _orientation.value;
}
