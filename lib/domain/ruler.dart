import 'dart:math' as math;

import 'package:flutter/foundation.dart';

const mmPerInch = 25.4;

/// ISO/IEC 7810 ID-1: every bank, ID and driving-licence card.
const cardLongMm = 85.60, cardShortMm = 53.98;

/// Android's baseline: one logical pixel is 1/160 inch at density 1.0.
const _nominalDpi = 160.0;

/// Where the screen's physical size comes from, best first.
enum ScaleSource {
  /// Set by the user (see [CalibrationMethod]): ±0.5 mm against a card or
  /// ruler, about 1% from the screen size.
  calibrated,

  /// The phone's reported pixels per inch, which passed every check.
  reported,

  /// Nothing reliable is known: the platform's nominal density, which can
  /// be off by around 10%. The app asks for a calibration.
  estimated,
}

/// The unit the ruler's reading is shown in.
enum LengthUnit { mm, cm, inch }

/// How the user calibrated: against a card, a real ruler, or by typing the
/// screen's size.
enum CalibrationMethod { card, ruler, screenSize }

/// Physical pixels per millimetre of the screen, and how it was found.
@immutable
class ScreenScale {
  const ScreenScale(this.pxPerMm, this.source);

  final double pxPerMm;
  final ScaleSource source;

  /// Millimetres spanned by [logical] logical pixels at [dpr].
  double mm(double logical, double dpr) => logical * dpr / pxPerMm;

  /// Logical pixels spanning [mm] millimetres at [dpr].
  double logical(double mm, double dpr) => mm * pxPerMm / dpr;

  @override
  bool operator ==(Object other) =>
      other is ScreenScale &&
      other.pxPerMm == pxPerMm &&
      other.source == source;

  @override
  int get hashCode => Object.hash(pxPerMm, source);
}

/// Identifies the physical screen a calibration belongs to: its resolution
/// in physical pixels, orientation-free. A different screen (the other
/// panel of a foldable, a changed screen resolution) gets its own entry.
String screenKey(double widthPx, double heightPx) {
  final a = widthPx.round(), b = heightPx.round();
  return '${math.min(a, b)}x${math.max(a, b)}';
}

/// The nominal scale: the platform's density bucket. Always available.
ScreenScale estimatedScale(double dpr) =>
    ScreenScale(dpr * _nominalDpi / mmPerInch, ScaleSource.estimated);

/// Whether [pxPerMm] is believable for a screen at [dpr]. Real phones and
/// tablets are 3–40 px/mm (76–1016 dpi) and within about a third of their
/// density bucket, which also covers a changed "display size" setting.
bool plausibleScale(double pxPerMm, double dpr) {
  if (!pxPerMm.isFinite || pxPerMm < 3 || pxPerMm > 40) return false;
  final nominal = dpr * _nominalDpi / mmPerInch;
  return (pxPerMm / nominal - 1).abs() <= 0.35;
}

/// The phone's reported density, or null when it can't be trusted: some
/// phones report placeholder values (160, 0, wildly different x and y).
ScreenScale? reportedScale({
  required double xdpi,
  required double ydpi,
  required double dpr,
  required double widthPx,
  required double heightPx,
}) {
  if (!xdpi.isFinite || !ydpi.isFinite || xdpi <= 0 || ydpi <= 0) {
    return null;
  }
  // Square pixels: x and y must agree.
  if ((xdpi - ydpi).abs() / math.max(xdpi, ydpi) > 0.05) return null;
  final dpi = (xdpi + ydpi) / 2;
  // The diagonal it implies must be a real phone or tablet screen.
  final diagonalIn = math.sqrt(widthPx * widthPx + heightPx * heightPx) / dpi;
  if (diagonalIn < 2.5 || diagonalIn > 20) return null;
  final pxPerMm = dpi / mmPerInch;
  if (!plausibleScale(pxPerMm, dpr)) return null;
  return ScreenScale(pxPerMm, ScaleSource.reported);
}

/// The scale to measure with: a saved card calibration, else the reported
/// density, else the estimate.
ScreenScale bestScale({
  required double dpr,
  double? calibratedPxPerMm,
  ScreenScale? reported,
}) {
  final c = calibratedPxPerMm;
  if (c != null && plausibleScale(c, dpr)) {
    return ScreenScale(c, ScaleSource.calibrated);
  }
  return reported ?? estimatedScale(dpr);
}

/// The card edge to calibrate with: the long one when it fits along the
/// ruler with a margin, else the short one (very small screens).
double calibrationCardMm(double availableMm) =>
    availableMm >= cardLongMm + 6 ? cardLongMm : cardShortMm;

/// The mark to drag to on a real ruler: the longest whole centimetre (or
/// inch) up to 10 cm (4 in) that fits along [availableMm] even when that
/// length is the 10%-off estimate. Never below 5 cm (2 in).
double rulerMarkMm(double availableMm, {bool inches = false}) {
  final unit = inches ? mmPerInch : 10.0;
  final usable = math.min(availableMm, 1000.0) / 1.12 - 4;
  final whole = (usable / unit).floor().clamp(inches ? 2 : 5, inches ? 4 : 10);
  return whole * unit;
}

/// Pixels per mm from a reference [referenceMm] long (a card's edge, a
/// ruler's mark) spanning [spanLogical] logical pixels, or null when that
/// can't be right on this screen (misaligned, or the wrong edge or mark).
double? calibrate({
  required double spanLogical,
  required double dpr,
  required double referenceMm,
}) {
  if (referenceMm <= 0 || spanLogical <= 0) return null;
  final pxPerMm = spanLogical * dpr / referenceMm;
  return plausibleScale(pxPerMm, dpr) ? pxPerMm : null;
}

/// Pixels per mm from the screen's advertised diagonal [diagonalIn] and
/// its resolution, or null when that size can't be this screen. Makers
/// round the size, so this is good to about 1%.
double? scaleFromDiagonal({
  required double diagonalIn,
  required double widthPx,
  required double heightPx,
  required double dpr,
}) {
  if (!diagonalIn.isFinite || diagonalIn < 2.5 || diagonalIn > 20) {
    return null;
  }
  final pxPerMm =
      math.sqrt(widthPx * widthPx + heightPx * heightPx) /
      diagonalIn /
      mmPerInch;
  return plausibleScale(pxPerMm, dpr) ? pxPerMm : null;
}

/// The diagonal, in inches, that [pxPerMm] implies for a screen of that
/// resolution: shows a screen-size calibration back to the user.
double diagonalInches(double pxPerMm, double widthPx, double heightPx) =>
    math.sqrt(widthPx * widthPx + heightPx * heightPx) / pxPerMm / mmPerInch;

/// A typed screen size: "6.1", "6,1", `6.1"` or "6.1 in", in Western or
/// Arabic digits. Null when there's no number.
double? parseInches(String text) {
  final ascii = String.fromCharCodes(
    text.runes.map((c) {
      if (c >= 0x0660 && c <= 0x0669) return c - 0x0660 + 0x30; // ٠–٩
      if (c >= 0x06F0 && c <= 0x06F9) return c - 0x06F0 + 0x30; // ۰–۹
      if (c == 0x066B) return 0x2E; // Arabic decimal separator
      return c;
    }),
  );
  final m = RegExp(r'\d+(?:[.,]\d+)?').firstMatch(ascii);
  return m == null ? null : double.tryParse(m[0]!.replaceAll(',', '.'));
}

/// A length snapped to the ruler's resolution, 0.5 mm.
double snapMm(double mm) => (mm * 2).round() / 2;
