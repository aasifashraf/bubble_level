import 'package:flutter/foundation.dart';

import '../../../../domain/angles.dart';

/// On-screen protractor: two arms from the centre, at angles in degrees
/// clockwise from 12 o'clock. Lay an object on the screen and line the arms
/// up with its edges.
class ProtractorViewModel extends ChangeNotifier {
  static const _defaultArms = [0.0, 60.0];

  final _arms = [..._defaultArms];

  /// The arm being dragged.
  /// The arm being dragged; null when the touch began where no arm can be
  /// aimed (the very centre).
  int? _dragging = 0;

  bool _locked = false;

  /// Locked: the handles ignore touches, so placing or moving the object
  /// on the screen can't shift them.
  bool get locked => _locked;

  void toggleLock() {
    _locked = !_locked;
    notifyListeners();
  }

  /// Opens unlocked, so nobody returns to handles that won't move.
  void unlock() => _locked = false;

  double arm(int i) => _arms[i];

  /// Clockwise turn from arm 0 to arm 1, [0, 360).
  double get _turn => (_arms[1] - _arms[0]) % 360;

  /// The angle between the arms, 0 to 180°.
  double get angle => _turn <= 180 ? _turn : 360 - _turn;

  /// The other way round: 360° minus [angle].
  double get reflex => 360 - angle;

  /// Where the arc for [angle] starts, so it spans the smaller side.
  double get arcStart => _turn <= 180 ? _arms[0] : _arms[1];

  /// Index of the arm closest to [degrees].
  int nearestArm(double degrees) =>
      wrap180(degrees - _arms[0]).abs() <= wrap180(degrees - _arms[1]).abs()
      ? 0
      : 1;

  /// Moves arm [i] to [degrees], snapped to whole degrees.
  void setArm(int i, double degrees) {
    if (_locked) return;
    final snapped = degrees.round() % 360;
    if (_arms[i] == snapped) return;
    _arms[i] = snapped.toDouble();
    notifyListeners();
  }

  /// Starts dragging the arm nearest to [degrees] and moves it there.
  void beginDrag(double degrees) {
    if (_locked) return;
    _dragging = nearestArm(degrees);
    setArm(_dragging!, degrees);
  }

  /// A touch at the centre, where its direction means nothing: it moves no
  /// arm, and neither does the drag that follows.
  void ignoreDrag() => _dragging = null;

  /// Moves the arm being dragged to [degrees].
  void dragTo(double degrees) {
    final arm = _dragging;
    if (arm != null) setArm(arm, degrees);
  }

  void reset() {
    if (_locked) return;
    _arms
      ..[0] = _defaultArms[0]
      ..[1] = _defaultArms[1];
    notifyListeners();
  }
}
