import 'package:flutter/foundation.dart';

import '../../data/repositories/orientation_repository.dart';
import '../../domain/orientation_reading.dart';

/// Base for view models driven by the orientation sensors. A view model only
/// follows the sensors while [active] (its screen is showing), so hidden tabs
/// cost nothing and can't fire side effects such as haptics.
abstract class SensorViewModel extends ChangeNotifier {
  SensorViewModel(this._orientation);

  final OrientationRepository _orientation;
  bool _active = false;

  OrientationReading get reading => _orientation.value;
  bool get active => _active;

  set active(bool value) {
    if (value == _active) return;
    _active = value;
    if (value) {
      _orientation.addListener(update);
      update();
    } else {
      _orientation.removeListener(update);
    }
  }

  /// Recomputes state from [reading] and notifies listeners.
  @protected
  void update();

  @override
  void dispose() {
    active = false;
    super.dispose();
  }
}
