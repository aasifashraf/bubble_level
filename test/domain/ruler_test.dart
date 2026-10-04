import 'package:bubble_level/domain/ruler.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // A typical 6.4" phone: 1080 × 2400 px at 411 dpi, density 2.625.
  const w = 1080.0, h = 2400.0, dpr = 2.625, dpi = 411.0;

  group('reported density', () {
    test('a real phone is trusted and converts exactly', () {
      final s = reportedScale(
        xdpi: dpi,
        ydpi: dpi,
        dpr: dpr,
        widthPx: w,
        heightPx: h,
      )!;
      expect(s.source, ScaleSource.reported);
      // 100 mm is 100 / 25.4 × 411 px = 1618.1 physical px.
      expect(s.logical(100, dpr) * dpr, closeTo(1618.11, 0.01));
      expect(s.mm(s.logical(37.5, dpr), dpr), closeTo(37.5, 1e-9));
    });

    test('a placeholder 160 dpi on a dense screen is rejected', () {
      expect(
        reportedScale(xdpi: 160, ydpi: 160, dpr: dpr, widthPx: w, heightPx: h),
        isNull,
      );
    });

    test('zero, negative, NaN or infinite values are rejected', () {
      for (final bad in [0.0, -411.0, double.nan, double.infinity]) {
        expect(
          reportedScale(
            xdpi: bad,
            ydpi: dpi,
            dpr: dpr,
            widthPx: w,
            heightPx: h,
          ),
          isNull,
          reason: '$bad',
        );
      }
    });

    test('x and y that disagree (non-square pixels) are rejected', () {
      expect(
        reportedScale(xdpi: 411, ydpi: 480, dpr: dpr, widthPx: w, heightPx: h),
        isNull,
      );
      // Small rounding differences are fine.
      expect(
        reportedScale(
          xdpi: 409.4,
          ydpi: 411.1,
          dpr: dpr,
          widthPx: w,
          heightPx: h,
        ),
        isNotNull,
      );
    });

    test('a value implying an impossible screen size is rejected', () {
      // 2400 px tall at 1600 dpi would be a 1.6" screen.
      expect(
        reportedScale(
          xdpi: 1600,
          ydpi: 1600,
          dpr: dpr,
          widthPx: w,
          heightPx: h,
        ),
        isNull,
      );
    });

    test('a changed "display size" setting still works', () {
      // The user zoomed the UI: density 3.0, same physical panel.
      expect(
        reportedScale(xdpi: dpi, ydpi: dpi, dpr: 3.0, widthPx: w, heightPx: h),
        isNotNull,
      );
      final s = reportedScale(
        xdpi: dpi,
        ydpi: dpi,
        dpr: 3.0,
        widthPx: w,
        heightPx: h,
      )!;
      // Lengths depend on physical pixels, not the zoom.
      expect(s.mm(s.logical(50, 3.0), 3.0), closeTo(50, 1e-9));
    });

    test('a tablet is trusted', () {
      // 10.1" 1200 × 1920 at 224 dpi, density 1.5.
      expect(
        reportedScale(
          xdpi: 224,
          ydpi: 224,
          dpr: 1.5,
          widthPx: 1200,
          heightPx: 1920,
        ),
        isNotNull,
      );
    });
  });

  group('choosing the scale', () {
    final reported = reportedScale(
      xdpi: dpi,
      ydpi: dpi,
      dpr: dpr,
      widthPx: w,
      heightPx: h,
    );

    test('calibration beats reported beats estimated', () {
      expect(
        bestScale(dpr: dpr, calibratedPxPerMm: 16.3, reported: reported).source,
        ScaleSource.calibrated,
      );
      expect(
        bestScale(dpr: dpr, reported: reported).source,
        ScaleSource.reported,
      );
      expect(bestScale(dpr: dpr).source, ScaleSource.estimated);
    });

    test('a corrupted saved calibration is ignored', () {
      expect(
        bestScale(dpr: dpr, calibratedPxPerMm: 0.2, reported: reported).source,
        ScaleSource.reported,
      );
    });

    test('the estimate is the density bucket (Android 160 dpi baseline)', () {
      expect(estimatedScale(dpr).pxPerMm, closeTo(2.625 * 160 / 25.4, 1e-9));
    });

    test('a calibration belongs to one physical screen', () {
      expect(screenKey(1080, 2400), screenKey(2400, 1080)); // rotated
      expect(screenKey(1080, 2400), isNot(screenKey(1440, 3200))); // QHD
      expect(screenKey(1080, 2400), isNot(screenKey(1812, 2176))); // fold
    });
  });

  group('card calibration', () {
    test('a correctly placed card gives the true scale', () {
      // The card spans 85.6 mm at 411 dpi: 1385.3 px = 527.7 logical px.
      final span = 85.6 / 25.4 * dpi / dpr;
      final pxPerMm = calibrate(
        spanLogical: span,
        dpr: dpr,
        referenceMm: 85.6,
      )!;
      expect(pxPerMm, closeTo(dpi / 25.4, 1e-6));
    });

    test('a badly misplaced line or the wrong edge is refused', () {
      // Line left at the top: 2 mm wide "card".
      expect(calibrate(spanLogical: 13, dpr: dpr, referenceMm: 85.6), isNull);
      // Short edge measured but long edge assumed: 37% off.
      final shortSpan = 53.98 / 25.4 * dpi / dpr;
      expect(
        calibrate(spanLogical: shortSpan, dpr: dpr, referenceMm: 85.6),
        isNull,
      );
      // Nonsense input.
      expect(calibrate(spanLogical: 0, dpr: dpr, referenceMm: 85.6), isNull);
      expect(calibrate(spanLogical: 500, dpr: dpr, referenceMm: 0), isNull);
    });

    test('small screens calibrate with the short edge', () {
      expect(calibrationCardMm(130), cardLongMm);
      expect(calibrationCardMm(91.6), cardLongMm);
      expect(calibrationCardMm(85), cardShortMm);
    });
  });

  group('ruler calibration', () {
    test('the mark is the longest whole cm or inch that surely fits', () {
      // A tall phone (140 mm of ruler): 10 cm, or 4 in in the US.
      expect(rulerMarkMm(140), 100);
      expect(rulerMarkMm(140, inches: true), 4 * 25.4);
      // 100 mm measured might be 89 mm real: 8 cm still fits.
      expect(rulerMarkMm(100), 80);
      expect(100 / 1.12, greaterThan(80));
      // The smallest screen that can calibrate gets 5 cm / 2 in.
      expect(rulerMarkMm(cardShortMm + 2), 50);
      expect(rulerMarkMm(cardShortMm + 2, inches: true), 2 * 25.4);
      // Not laid out yet (infinite) doesn't throw.
      expect(rulerMarkMm(double.infinity), 100);
    });

    test('a ruler span calibrates like a card', () {
      final span = 100 / 25.4 * dpi / dpr;
      expect(
        calibrate(spanLogical: span, dpr: dpr, referenceMm: 100),
        closeTo(dpi / 25.4, 1e-6),
      );
      // Dragged to 5 cm while the mark is 10 cm: refused.
      expect(
        calibrate(spanLogical: span / 2, dpr: dpr, referenceMm: 100),
        isNull,
      );
    });
  });

  group('screen size calibration', () {
    test('the advertised diagonal gives the scale to within 1%', () {
      // 1080 × 2400 at 411 dpi is a 6.40" diagonal.
      final s = scaleFromDiagonal(
        diagonalIn: 6.4,
        widthPx: w,
        heightPx: h,
        dpr: dpr,
      )!;
      expect(s / (dpi / 25.4), closeTo(1, 0.01));
      // Shown back as the size typed.
      expect(diagonalInches(s, w, h), closeTo(6.4, 1e-9));
    });

    test('a size that can’t be this screen is refused', () {
      for (final bad in <double>[0, -6, 1.5, 25, double.nan, 3, 12.9]) {
        expect(
          scaleFromDiagonal(diagonalIn: bad, widthPx: w, heightPx: h, dpr: dpr),
          isNull,
          reason: '$bad',
        );
      }
    });

    test('typed sizes are read in any common form', () {
      expect(parseInches('6.1'), 6.1);
      expect(parseInches('6,1'), 6.1);
      expect(parseInches(' 6.1" '), 6.1);
      expect(parseInches('6.1 in'), 6.1);
      expect(parseInches('7'), 7);
      expect(parseInches('٦٫١'), 6.1); // Arabic digits
      expect(parseInches('۶٫۱'), 6.1); // Urdu digits
      expect(parseInches(''), isNull);
      expect(parseInches('abc'), isNull);
    });
  });

  test('lengths snap to half millimetres', () {
    expect(snapMm(47.26), 47.5);
    expect(snapMm(47.24), 47.0);
    expect(snapMm(-0.2), -0.0);
  });
}
