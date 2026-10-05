import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/scheduler.dart';

import '../../../../data/repositories/settings_repository.dart';
import '../../../../data/services/display_rotation_service.dart';
import '../../../../domain/ruler.dart';

/// The on-screen ruler: two lines dragged to an object's ends, measured
/// with the screen's physical scale (the user's calibration, else the
/// phone's reported density, else an estimate that asks for calibration).
class RulerViewModel extends ChangeNotifier {
  RulerViewModel({required this._settings, required this._display});

  final SettingsRepository _settings;
  final DisplayRotationService _display;

  static const _defaultEnds = [0.0, 50.0];

  /// The two lines, in millimetres from the ruler's zero.
  final _ends = [..._defaultEnds];
  int _dragging = 0;
  bool _locked = false;

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

  /// Opens fresh: unlocked, not mid-calibration.
  void open() {
    _locked = false;
    _method = null;
    _calibrationFailed = false;
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

  /// Distance between the lines as drawn (kept on a ruler that got
  /// shorter), snapped to 0.5 mm.
  double get lengthMm =>
      snapMm((shown(1, _rulerLengthMm) - shown(0, _rulerLengthMm)).abs());

  bool get locked => _locked;

  /// The reading's unit, or null until the user picks one (the view then
  /// picks by region).
  LengthUnit? get unit => _settings.rulerUnit;

  Future<void> setUnit(LengthUnit unit) async {
    await _settings.setRulerUnit(unit);
    notifyListeners();
  }

  void toggleLock() {
    _locked = !_locked;
    notifyListeners();
  }

  /// Starts dragging the line nearest [mm]; [maxMm] is the ruler's end.
  void beginDrag(double mm, double maxMm) {
    if (_locked) return;
    _dragging = (mm - shown(0, maxMm)).abs() <= (mm - shown(1, maxMm)).abs()
        ? 0
        : 1;
    dragTo(mm, maxMm);
  }

  void dragTo(double mm, double maxMm) {
    if (_locked) return;
    final v = snapMm(mm.clamp(0.0, math.max(0.0, maxMm)));
    if (v == _ends[_dragging]) return;
    _ends[_dragging] = v;
    notifyListeners();
  }

  /// Keeps both lines on a ruler that got shorter (rotation, resize).
  double shown(int i, double maxMm) => _ends[i].clamp(0.0, math.max(0, maxMm));

  void reset() {
    if (_locked) return;
    _ends
      ..[0] = _defaultEnds[0]
      ..[1] = _defaultEnds[1];
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

  /// Called by the view during layout; a real change (rotation, resize)
  /// rebuilds the controls after this frame.
  void setRulerLength(double mm) {
    if ((mm - _rulerLengthMm).abs() < 0.5) return;
    _rulerLengthMm = mm;
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
