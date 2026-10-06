import 'dart:math' as math;

import 'package:flutter/foundation.dart';

import '../../../../data/repositories/orientation_repository.dart';
import '../../../../data/repositories/settings_repository.dart';
import '../../../../domain/angles.dart';
import '../../../../domain/orientation_reading.dart';
import '../../../core/sensor_view_model.dart';

/// Which side of the screen is measured on an edge: the lower one, the
/// edge resting on what's measured.
enum EdgeSide { left, right }

@immutable
class AngleState {
  const AngleState({
    required this.tilt,
    required this.rotation,
    this.moved,
    this.forwardBack,
    this.leftRight,
    this.screenRotation,
    this.turn,
    this.edge,
    this.side,
    this.surface,
  });

  /// Angle of the screen from horizontal (0° flat, 90° upright).
  final double tilt;

  /// Rotation in the screen plane relative to gravity, null when flat.
  final double? rotation;

  /// Since "Set zero": total angle moved, null when not zeroed.
  final double? moved;

  /// Since "Set zero": rotation about each screen axis, null when that axis
  /// is too close to vertical to measure it.
  final double? forwardBack, leftRight, screenRotation;

  /// Since "Set zero": turn about the vertical (compass) axis, null without a
  /// reliable magnetometer.
  final double? turn;

  /// Standing on an edge: the angle from level (0–90°) of the screen's
  /// side edges, the long ones in portrait; the bottom edge's is its
  /// complement. Null lying flat.
  final double? edge;

  /// On an edge: the side being measured.
  final EdgeSide? side;

  /// On an edge: the angle of level on the screen, degrees clockwise (the
  /// water's surface).
  final double? surface;

  bool get onEdge => edge != null;
  double? get bottomEdge => edge == null ? null : 90 - edge!;

  bool get zeroed => moved != null;
}

class AngleViewModel extends SensorViewModel {
  AngleViewModel({
    required OrientationRepository orientation,
    required this._settings,
  }) : super(orientation);

  final SettingsRepository _settings;
  Vec3? _zeroGravity;
  double? _zeroHeading;
  LevelMode _zeroMode = LevelMode.flat;
  LevelMode _mode = LevelMode.flat;
  AngleState? _state;

  /// The reading held by the lock, or null while live.
  OrientationReading? _frozen;

  AngleState? get state => _state;

  /// Flat on a surface, or on an edge. Picked by the user: switching by
  /// how the phone was held flipped modes when it tipped past upright.
  AngleMode get mode => _settings.angleMode;

  Future<void> setMode(AngleMode mode) async {
    await _settings.setAngleMode(mode);
    _refresh();
  }

  /// Held on-edge while the phone lies flat: no edge to read.
  bool get needsEdge => mode == AngleMode.edge && _state?.edge == null;

  /// The side last seen lower. It changes only once the other side is
  /// clearly lower, so standing upright it doesn't flicker between them.
  EdgeSide _side = EdgeSide.right;

  /// How far (sine of 2°) the other side must drop to take over.
  static final _sideMargin = math.sin(2 * math.pi / 180);

  /// Locked: the reading stays frozen so it can be read after the phone is
  /// lifted off what it measured.
  bool get locked => _frozen != null;

  /// The reading to measure: frozen while locked, else live.
  OrientationReading get _source => _frozen ?? reading;

  void toggleLock() {
    _frozen = _frozen == null && reading.gravity != null ? reading : null;
    update();
  }

  void setZero() {
    final g = _source.gravity;
    if (g == null) return;
    _zeroGravity = g;
    _zeroMode = _mode;
    _zeroHeading = _deviceHeading(_mode);
    _refresh();
  }

  void clearZero() {
    _zeroGravity = null;
    _zeroHeading = null;
    _refresh();
  }

  /// Recomputes even while locked: a new zero or mode applies to the
  /// frozen reading.
  void _refresh() {
    _state = _compute();
    notifyListeners();
  }

  @override
  void onActivate() => _frozen = null;

  /// Heading of a device-fixed axis, so the turn doesn't jump when the UI
  /// rotates. Null without a trustworthy magnetometer.
  double? _deviceHeading(LevelMode mode) => _source.magneticReliable
      ? _source.heading(flat: mode == LevelMode.flat, screen: false)
      : null;

  @override
  void update() {
    if (!locked) _state = _compute();
    notifyListeners();
  }

  AngleState? _compute() {
    final r = _source;
    final g = r.gravity, gs = r.screenGravity;
    if (g == null || gs == null) return null;
    // "From level" honours the Level tab's flat calibration.
    final tilt = tiltDeg(rotateFromTo(g, _settings.flatRef, Vec3.up));
    _mode = switch (_settings.angleMode) {
      AngleMode.flat => LevelMode.flat,
      AngleMode.edge => LevelMode.edge,
    };
    final rotation = planeAngleDeg(gs.x, gs.y);
    // On an edge the screen is upright whatever the slope, so read the
    // edge instead: the screen's side edges, so "left" and "right" are
    // what the user sees whichever way the UI is turned. Within ~17° of
    // flat the edge has no meaningful angle.
    final upright = planeAngleDeg(g.x / g.length, g.y / g.length) != null;
    final edge = _mode == LevelMode.edge && upright
        ? longEdgeDeg(gs, offset: _settings.edgeOffset)
        : null;
    if (edge != null) {
      // Up has +x when the right side is raised: the left one is lower.
      final lean = gs.x / gs.length;
      if (lean > _sideMargin) _side = EdgeSide.left;
      if (lean < -_sideMargin) _side = EdgeSide.right;
    }
    final side = edge == null ? null : _side;
    // Where level is on the screen, for the water's surface.
    final surface = edge == null || rotation == null
        ? null
        : wrap180(rotation - _settings.edgeOffset);

    final g0 = _zeroGravity;
    if (g0 == null) {
      return AngleState(
        tilt: tilt,
        rotation: rotation,
        edge: edge,
        side: side,
        surface: surface,
      );
    }

    final g0s = deviceToScreen(g0, r.quarterTurns);
    final h0 = _zeroHeading;
    final h = _mode == _zeroMode ? _deviceHeading(_mode) : null;
    return AngleState(
      tilt: tilt,
      rotation: rotation,
      moved: angleBetweenDeg(g0, g),
      forwardBack: axisDeltaDeg(g0s, gs, DeviceAxis.x),
      leftRight: axisDeltaDeg(g0s, gs, DeviceAxis.y),
      screenRotation: axisDeltaDeg(g0s, gs, DeviceAxis.z),
      turn: h0 == null || h == null ? null : wrap180(h - h0),
      edge: edge,
      side: side,
      surface: surface,
    );
  }
}
