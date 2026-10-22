import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/scheduler.dart';

import '../../../../data/repositories/settings_repository.dart';
import '../../../../data/services/display_rotation_service.dart';
import '../../../../domain/ruler.dart';

/// A finger on the ruler that holds no line (yet): where it went down,
/// when, and whether another finger was on the ruler meanwhile.
class _Touch {
  _Touch(this.along, this.across, this.time);

  final double along, across;
  final Duration time;
  bool shared = false;
  bool moved = false;
}

/// The on-screen ruler: two lines dragged to an object's ends (and, with
/// width on, two across it), measured with the screen's physical scale
/// (the user's calibration, else the phone's reported density, else an
/// estimate that asks for calibration).
///
/// Every finger moves its own line, so one hand can hold the object on the
/// screen while the other drags, or two lines move at once. A finger near
/// a line takes it at once; a lone finger elsewhere takes the nearest line
/// once it drags, or moves it there with a quick tap. A finger that only
/// rests on the screen (holding the object) moves nothing.
class RulerViewModel extends ChangeNotifier {
  RulerViewModel({required this._settings, required this._display});

  final SettingsRepository _settings;
  final DisplayRotationService _display;

  static const _defaultEnds = [0.0, 50.0, 10.0, 40.0];

  /// A quick tap moves a line; a longer touch is a finger holding the
  /// object.
  static const tapTime = Duration(milliseconds: 300);

  /// The lines, in millimetres from the zero of their scale: 0 and 1 along
  /// the ruler (length), 2 and 3 across it (width).
  final _ends = [..._defaultEnds];

  /// Which line each finger holds, and the fingers that hold none.
  final _held = <int, int>{};
  final _touches = <int, _Touch>{};
  bool _locked = false;
  bool _width = false;

  ({double xdpi, double ydpi})? _ppi;
  bool _loaded = false;

  bool _calibrationFailed = false;

  /// Asks the platform for the screen density once.
  Future<void> load() async {
    if (_loaded) return;
    _ppi = await _display.pixelsPerInch();
    _loaded = true;
    notifyListeners();
  }

  /// Opens fresh: unlocked, length only, not mid-calibration.
  void open() {
    _locked = false;
    _width = false;
    _method = null;
    _calibrationFailed = false;
    _held.clear();
    _touches.clear();
    load();
  }

  /// The scale for this screen: [dpr] logical-to-physical, [physical] the
  /// display's size in physical pixels.
  ScreenScale scaleFor(double dpr, Size physical) {
    final ppi = _ppi;
    return bestScale(
      dpr: dpr,
      calibratedPxPerMm: _settings.rulerPxPerMm(
        screenKey(physical.width, physical.height),
      ),
      reported: ppi == null
          ? null
          : reportedScale(
              xdpi: ppi.xdpi,
              ydpi: ppi.ydpi,
              dpr: dpr,
              widthPx: physical.width,
              heightPx: physical.height,
            ),
    );
  }

  double end(int i) => _ends[i];

  /// Distance between the length lines as drawn (kept on a ruler that got
  /// shorter), snapped to 0.5 mm.
  double get lengthMm =>
      snapMm((shown(1, _rulerLengthMm) - shown(0, _rulerLengthMm)).abs());

  /// Distance between the width lines as drawn, snapped to 0.5 mm.
  double get widthMm =>
      snapMm((shown(3, _rulerWidthMm) - shown(2, _rulerWidthMm)).abs());

  bool get locked => _locked;

  /// Whether the two lines across the ruler (width and area) are on.
  bool get width => _width;

  void toggleWidth() {
    _width = !_width;
    // A width line held when width goes off lets go.
    _held.removeWhere((_, line) => line >= 2);
    notifyListeners();
  }

  /// The reading's unit, or null until the user picks one (the view then
  /// picks by region).
  LengthUnit? get unit => _settings.rulerUnit;

  Future<void> setUnit(LengthUnit unit) async {
    await _settings.setRulerUnit(unit);
    notifyListeners();
  }

  void toggleLock() {
    _locked = !_locked;
    _held.clear();
    _touches.clear();
    notifyListeners();
  }

  /// Keeps line [i] on a ruler that got shorter (rotation, resize): [maxMm]
  /// is the length of its scale.
  double shown(int i, double maxMm) => _ends[i].clamp(0.0, math.max(0, maxMm));

  double _max(int line) => line < 2 ? _rulerLengthMm : _rulerWidthMm;

  /// Where [line] is drawn, and how far a touch at [along], [across] is
  /// from it, in mm.
  double _distance(int line, double along, double across) =>
      ((line < 2 ? along : across) - shown(line, _max(line))).abs();

  /// The line nearest a touch that no other finger holds, if any.
  int? _nearestFree(double along, double across) {
    int? best;
    for (var line = 0; line < (_width ? 4 : 2); line++) {
      if (_held.containsValue(line)) continue;
      if (best == null ||
          _distance(line, along, across) < _distance(best, along, across)) {
        best = line;
      }
    }
    return best;
  }

  void _move(int line, double along, double across) {
    final v = snapMm(
      (line < 2 ? along : across).clamp(0.0, math.max(0.0, _max(line))),
    );
    if (v == _ends[line]) return;
    _ends[line] = v;
    notifyListeners();
  }

  /// A finger [id] went down at [along], [across] (mm from the zeros) at
  /// [time]. Within [grabMm] of a free line it takes that line.
  void pointerDown(
    int id,
    double along,
    double across, {
    required Duration time,
    required double grabMm,
  }) {
    if (_locked) return;
    final shared = _held.isNotEmpty || _touches.isNotEmpty;
    for (final t in _touches.values) {
      t.shared = true;
    }
    final line = _nearestFree(along, across);
    if (line != null && _distance(line, along, across) <= grabMm) {
      _held[id] = line;
      _move(line, along, across);
      return;
    }
    _touches[id] = _Touch(along, across, time)..shared = shared;
  }

  /// Finger [id] moved to [along], [across]. A lone finger that held no
  /// line takes the nearest one once it has moved [slopMm].
  void pointerMove(int id, double along, double across, {double slopMm = 3}) {
    if (_locked) return;
    final line = _held[id];
    if (line != null) return _move(line, along, across);
    final t = _touches[id];
    if (t == null || t.shared) return;
    final dx = along - t.along, dy = across - t.across;
    if (!t.moved && dx * dx + dy * dy < slopMm * slopMm) return;
    t.moved = true;
    final free = _nearestFree(along, across);
    if (free == null) return;
    _touches.remove(id);
    _held[id] = free;
    _move(free, along, across);
  }

  /// Finger [id] lifted at [time]. A quick tap by a lone finger moves the
  /// nearest line to it; a finger that rested (held the object) moves
  /// nothing.
  void pointerUp(int id, {required Duration time}) {
    _held.remove(id);
    final t = _touches.remove(id);
    if (_locked || t == null || t.shared || t.moved) return;
    if (time - t.time > tapTime) return;
    final line = _nearestFree(t.along, t.across);
    if (line != null) _move(line, t.along, t.across);
  }

  void pointerCancel(int id) {
    _held.remove(id);
    _touches.remove(id);
  }

  void reset() {
    if (_locked) return;
    _ends.setAll(0, _defaultEnds);
    notifyListeners();
  }

  // ---- Calibration: a line dragged to a card's end or a ruler's mark,
  // or the screen size typed in.

  CalibrationMethod? _method;
  bool _inches = false;

  /// The card or ruler being lined up, or null when measuring.
  CalibrationMethod? get method => _method;

  bool get calibrating => _method != null;

  double _rulerLengthMm = double.infinity;
  double _rulerWidthMm = double.infinity;

  /// Called by the view during layout with the ruler's length and, for the
  /// width lines, its width; a real change (rotation, resize) rebuilds the
  /// controls after this frame.
  void setRulerLength(double mm, {double? widthMm}) {
    final w = widthMm ?? _rulerWidthMm;
    if ((mm - _rulerLengthMm).abs() < 0.5 && (w - _rulerWidthMm).abs() < 0.5) {
      return;
    }
    _rulerLengthMm = mm;
    _rulerWidthMm = w;
    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (hasListeners) notifyListeners();
    });
  }

  /// The length to line up: the card edge that fits, or the ruler mark.
  double get referenceMm => _method == CalibrationMethod.ruler
      ? rulerMarkMm(_rulerLengthMm, inches: _inches)
      : calibrationCardMm(_rulerLengthMm);

  /// Whether the ruler mark is in inches (US) rather than centimetres.
  bool get inches => _inches;

  /// Whether a card's short edge (and so a 5 cm mark) fits along the
  /// ruler; it may not in landscape on a small phone.
  bool get referenceFits => _rulerLengthMm >= cardShortMm + 2;

  /// Where the reference's far end is, in logical pixels from the zero.
  double get referenceSpan => _referenceSpan;
  double _referenceSpan = 0;

  /// The last Save didn't match the reference or the screen.
  bool get calibrationFailed => _calibrationFailed;

  CalibrationMethod? savedMethod(Size physical) {
    final key = screenKey(physical.width, physical.height);
    return _settings.rulerPxPerMm(key) == null
        ? null
        : _settings.rulerMethod(key);
  }

  /// Starts lining up a card or a ruler ([method]); the line starts where
  /// it would end at the current [scale].
  void startCalibration(
    CalibrationMethod method, {
    required ScreenScale scale,
    required double dpr,
    bool inches = false,
  }) {
    assert(method != CalibrationMethod.screenSize, 'typed, not lined up');
    _method = method;
    _inches = inches;
    _calibrationFailed = false;
    _referenceSpan = scale.logical(referenceMm, dpr);
    notifyListeners();
  }

  void dragReference(double logical, double maxLogical) {
    _referenceSpan = logical.clamp(0.0, math.max(0.0, maxLogical));
    _calibrationFailed = false;
    notifyListeners();
  }

  void cancelCalibration() {
    _method = null;
    _calibrationFailed = false;
    notifyListeners();
  }

  /// Saves the dragged span as this screen's scale; false (and nothing
  /// saved) when it can't be the reference.
  Future<bool> saveAlignment({
    required double dpr,
    required Size physical,
  }) async {
    final method = _method;
    if (method == null) return false;
    final pxPerMm = calibrate(
      spanLogical: _referenceSpan,
      dpr: dpr,
      referenceMm: referenceMm,
    );
    if (pxPerMm == null) {
      _calibrationFailed = true;
      notifyListeners();
      return false;
    }
    await _store(physical, pxPerMm, method);
    return true;
  }

  /// Saves the scale from a typed screen size; false (and nothing saved)
  /// when it isn't a number or can't be this screen.
  Future<bool> saveScreenSize(
    String text, {
    required double dpr,
    required Size physical,
  }) async {
    final inches = parseInches(text);
    final pxPerMm = inches == null
        ? null
        : scaleFromDiagonal(
            diagonalIn: inches,
            widthPx: physical.width,
            heightPx: physical.height,
            dpr: dpr,
          );
    if (pxPerMm == null) return false;
    await _store(physical, pxPerMm, CalibrationMethod.screenSize);
    return true;
  }

  /// Forgets this screen's calibration.
  Future<void> usePhoneDefault(Size physical) => _store(physical, null);

  Future<void> _store(
    Size physical,
    double? pxPerMm, [
    CalibrationMethod method = CalibrationMethod.card,
  ]) async {
    await _settings.setRulerCalibration(
      screenKey(physical.width, physical.height),
      pxPerMm,
      method,
    );
    _method = null;
    _calibrationFailed = false;
    notifyListeners();
  }
}
