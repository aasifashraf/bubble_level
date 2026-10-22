import 'package:bubble_level/data/repositories/orientation_repository.dart';
import 'package:bubble_level/data/repositories/settings_repository.dart';
import 'package:bubble_level/domain/ruler.dart';
import 'package:bubble_level/main.dart';
import 'package:bubble_level/ui/core/controls.dart';
import 'package:bubble_level/ui/core/format.dart';
import 'package:bubble_level/ui/core/theme.dart';
import 'package:bubble_level/ui/features/ruler/view_models/ruler_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'helpers/fakes.dart';

/// A 6.4" phone: 1080 × 2400 px at 411 dpi, density 2.625.
const _panel = Size(1080, 2400);
const _dpi = 411.0;
const _dpr = 2.625;

/// Logical pixels per mm on that phone.
const _perMm = _dpi / 25.4 / _dpr;

/// Top of the ruler's area: the header (18 + 70) plus the 8 px inset.
const _top = 96.0;

void main() {
  final microphone = FakeMicrophoneService();
  late FakeDisplayRotationService display;

  Future<void> pumpRuler(
    WidgetTester tester, {
    ({double xdpi, double ydpi})? ppi = (xdpi: _dpi, ydpi: _dpi),
    Size panel = _panel,
    Size? window,
    double dpr = _dpr,
    Map<String, Object> prefs = const {},
  }) async {
    tester.view.physicalSize = window ?? panel;
    tester.view.devicePixelRatio = dpr;
    tester.view.display.size = panel;
    addTearDown(tester.view.reset);
    addTearDown(tester.view.display.reset);
    SharedPreferences.setMockInitialValues(prefs);
    final settings = await SettingsRepository.load();
    final sensors = FakeMotionSensorService();
    display = FakeDisplayRotationService()..ppi = ppi;
    await tester.pumpWidget(
      BubbleLevelApp(
        microphone: microphone,
        settings: settings,
        orientation: OrientationRepository(sensors: sensors, display: display),
        sensors: sensors,
        display: display,
      ),
    );
    await tester.ensureVisible(find.text('Ruler'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Ruler'));
    await tester.pumpAndSettle();
  }

  Finder length(String mm, String inches) =>
      find.bySemanticsLabel('Length $mm millimetres, $inches inches');

  void useLocale(WidgetTester tester, Locale locale) {
    tester.platformDispatcher.localeTestValue = locale;
    addTearDown(tester.platformDispatcher.clearLocaleTestValue);
  }

  Future<void> calibrateWith(WidgetTester tester, String method) async {
    await tester.tap(find.text('Calibrate'));
    await tester.pumpAndSettle();
    await tester.tap(find.text(method));
    await tester.pumpAndSettle();
  }

  testWidgets('trusted screen size: the default lines are 50 mm apart, and '
      'dragging measures exactly', (tester) async {
    final semantics = tester.ensureSemantics();
    await pumpRuler(tester);
    expect(
      find.text('Screen size from the phone · calibrate for ±0.5 mm'),
      findsOneWidget,
    );
    expect(length('50.0', '1.97'), findsOneWidget);
    expect(find.text('50.0 mm'), findsOneWidget);

    // Drag the 50 mm line down by exactly 50 mm worth of screen.
    await tester.dragFrom(
      const Offset(200, _top + 50 * _perMm),
      const Offset(0, 50 * _perMm),
    );
    await tester.pumpAndSettle();
    expect(length('100.0', '3.94'), findsOneWidget);
    semantics.dispose();
  });

  testWidgets('a zoomed "display size" setting measures the same', (
    tester,
  ) async {
    // Same panel, but the UI is drawn at density 3.0.
    final semantics = tester.ensureSemantics();
    await pumpRuler(tester, dpr: 3.0);
    const perMm = _dpi / 25.4 / 3.0;
    await tester.dragFrom(
      const Offset(180, _top + 50 * perMm),
      const Offset(0, 25 * perMm),
    );
    await tester.pumpAndSettle();
    expect(length('75.0', '2.95'), findsOneWidget);
    semantics.dispose();
  });

  testWidgets('a placeholder density from the phone is not trusted', (
    tester,
  ) async {
    await pumpRuler(tester, ppi: (xdpi: 160, ydpi: 160));
    expect(
      find.text('Not calibrated · lengths may be 10% off'),
      findsOneWidget,
    );
  });

  testWidgets('no density at all (iPhone) asks for calibration', (
    tester,
  ) async {
    await pumpRuler(tester, ppi: null);
    expect(
      find.text('Not calibrated · lengths may be 10% off'),
      findsOneWidget,
    );
  });

  testWidgets('calibrating with a card fixes the scale and is remembered', (
    tester,
  ) async {
    final semantics = tester.ensureSemantics();
    // iPhone-like: nothing reported, so it starts from the estimate.
    await pumpRuler(tester, ppi: null);
    await calibrateWith(tester, 'A bank card');
    expect(find.textContaining('long edge along the ruler'), findsOneWidget);

    // The line starts where a card would end at the estimated 420 dpi;
    // drag it to where the real card ends at 411 dpi.
    const estimatedEnd = 85.6 * 420 / 25.4 / _dpr;
    const realEnd = 85.6 * _perMm;
    await tester.dragFrom(
      const Offset(200, _top + estimatedEnd),
      const Offset(0, realEnd - estimatedEnd - 20),
    );
    await tester.dragFrom(
      const Offset(200, _top + realEnd - 20),
      const Offset(0, 20),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();

    expect(find.text('Calibrated with a card · ±0.5 mm'), findsOneWidget);
    final saved = (await SettingsRepository.load()).rulerPxPerMm('1080x2400');
    expect(saved, closeTo(_dpi / 25.4, 0.05)); // within 0.3%
    // Lengths now use the card's scale: 50 mm reads 50 mm at 411 dpi.
    await tester.dragFrom(
      const Offset(200, _top + 50 * _perMm),
      const Offset(0, 30 * _perMm),
    );
    await tester.pumpAndSettle();
    expect(length('80.0', '3.15'), findsOneWidget);
    semantics.dispose();
  });

  testWidgets('a misplaced card is refused and nothing is saved', (
    tester,
  ) async {
    await pumpRuler(tester);
    await calibrateWith(tester, 'A bank card');
    // Line dragged far short of a card.
    await tester.dragFrom(
      const Offset(200, _top + 85.6 * _perMm),
      const Offset(0, -380),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();
    expect(
      find.text(
        'That doesn’t match a card. Line it up with the dark line and try '
        'again.',
      ),
      findsOneWidget,
    );
    expect((await SettingsRepository.load()).rulerPxPerMm('1080x2400'), null);

    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();
    expect(find.text('Calibrate'), findsOneWidget);
  });

  testWidgets('a calibration belongs to its own screen; a corrupted one is '
      'ignored', (tester) async {
    await pumpRuler(tester, prefs: {'rulerPxPerMm:1080x2400': 16.2});
    expect(find.text('Calibrated with a card · ±0.5 mm'), findsOneWidget);
    // "Use the phone's screen size" forgets it.
    await calibrateWith(tester, 'Use the phone’s screen size');
    await tester.pumpAndSettle();
    expect(
      find.text('Screen size from the phone · calibrate for ±0.5 mm'),
      findsOneWidget,
    );
  });

  testWidgets('a QHD resolution or the other panel of a foldable does not '
      'reuse the calibration', (tester) async {
    await pumpRuler(
      tester,
      panel: const Size(1440, 3200),
      dpr: 3.5,
      ppi: (xdpi: 548, ydpi: 548),
      prefs: {'rulerPxPerMm:1080x2400': 16.2},
    );
    expect(
      find.text('Screen size from the phone · calibrate for ±0.5 mm'),
      findsOneWidget,
    );
  });

  testWidgets('a corrupted saved calibration is ignored', (tester) async {
    await pumpRuler(tester, prefs: {'rulerPxPerMm:1080x2400': 0.5});
    expect(
      find.text('Screen size from the phone · calibrate for ±0.5 mm'),
      findsOneWidget,
    );
  });

  testWidgets('a short screen calibrates with the card’s short edge', (
    tester,
  ) async {
    // 360 × 640 logical at density 2, 320 dpi: about 61 mm of ruler.
    await pumpRuler(
      tester,
      panel: const Size(720, 1280),
      dpr: 2,
      ppi: (xdpi: 320, ydpi: 320),
    );
    await calibrateWith(tester, 'A bank card');
    expect(find.textContaining('short edge along the ruler'), findsOneWidget);
  });

  testWidgets('landscape: the ruler spans the full width with the controls '
      'below, so even a small phone fits the card’s long edge', (tester) async {
    final semantics = tester.ensureSemantics();
    // 640 × 360 logical at 320 dpi: about 99 mm across.
    await pumpRuler(
      tester,
      panel: const Size(720, 1280),
      window: const Size(1280, 720),
      dpr: 2,
      ppi: (xdpi: 320, ydpi: 320),
    );
    await tester.pump();
    final ruler = tester.getRect(find.bySemanticsLabel(RegExp('^Length ')));
    final calibrate = tester.getRect(find.text('Calibrate'));
    expect(ruler.width, 640);
    expect(calibrate.top, greaterThan(ruler.bottom));
    // The status sits above; Calibrate and the lock share the lower row.
    final status = tester.getRect(
      find.text('Screen size from the phone · calibrate for ±0.5 mm'),
    );
    expect(status.bottom, lessThan(calibrate.top));
    expect(
      tester.getRect(find.byTooltip('Lock handles')).center.dy,
      closeTo(calibrate.center.dy, 4),
    );

    await calibrateWith(tester, 'A bank card');
    expect(find.textContaining('long edge along the ruler'), findsOneWidget);
    expect(find.text('Save'), findsOneWidget);
    semantics.dispose();
  });

  testWidgets('landscape: nothing covers the ruler; the reading and units '
      'sit in a row under it', (tester) async {
    useLocale(tester, const Locale('en', 'GB'));
    // This emulator turned: 1920 × 1080 at density 2.625.
    await pumpRuler(
      tester,
      panel: const Size(1080, 1920),
      window: const Size(1920, 1080),
      ppi: (xdpi: 420, ydpi: 420),
    );
    await tester.pump();
    final ruler = tester.getRect(find.bySemanticsLabel(RegExp('^Length ')));
    final reading = tester.getRect(find.text('50.0 mm'));
    final units = tester.getRect(find.byTooltip('Centimetres'));
    final calibrate = tester.getRect(find.text('Calibrate'));
    expect(reading.top, greaterThanOrEqualTo(ruler.bottom));
    expect(units.top, greaterThanOrEqualTo(ruler.bottom));
    final status = tester.getRect(
      find.text('Screen size from the phone · calibrate for ±0.5 mm'),
    );
    // Read on top: the length, its status at the far end.
    expect(reading.bottom, lessThan(calibrate.top), reason: 'row above');
    expect(status.center.dy, closeTo(reading.center.dy, 8));
    expect(status.left, greaterThan(reading.right));
    // Flush right, in line with the lock below.
    final lock = tester.getRect(find.byTooltip('Lock handles'));
    expect(status.right, closeTo(lock.right, 2));
    // The picked unit is in the indicator orange, readable on its pill.
    Color? unitColor(String label) =>
        tester.widget<Text>(find.text(label)).style?.color;
    expect(unitColor('mm'), Palette.light.accentText);
    expect(unitColor('cm'), Palette.light.label);
    // Large text, which is what makes 3:1 enough for the orange.
    final style = tester.widget<Text>(find.text('mm')).style!;
    expect(style.fontSize, greaterThanOrEqualTo(18.66));
    expect(style.fontWeight, FontWeight.w700);
    // Tap below: the units at the start, Calibrate and the lock at the end.
    expect(units.center.dy, closeTo(calibrate.center.dy, 8));
    expect(units.right, lessThan(calibrate.left));
    expect(tester.getRect(find.byTooltip('Millimetres')).left, lessThan(60));
    expect(ruler.height, greaterThan(150), reason: 'room for both scales');
    // Units still switch from there.
    await tester.tap(find.byTooltip('Centimetres'));
    await tester.pump();
    expect(find.text('5.00 cm'), findsOneWidget);
  });

  testWidgets('when no card or mark fits (a tiny split-screen window) those '
      'are disabled; the screen size still works', (tester) async {
    // 340 × 280 logical at 320 dpi: about 54 mm across.
    await pumpRuler(
      tester,
      panel: const Size(720, 1280),
      window: const Size(680, 560),
      dpr: 2,
      ppi: (xdpi: 320, ydpi: 320),
    );
    await tester.pump();
    await tester.tap(find.text('Calibrate'));
    await tester.pumpAndSettle();
    expect(find.text('Turn to portrait to calibrate'), findsNWidgets(2));
    // Disabled: tapping the card does nothing.
    await tester.tap(find.text('A bank card'));
    await tester.pumpAndSettle();
    expect(find.text('Calibrate with'), findsOneWidget);
    // The sheet scrolls in so short a window.
    await tester.ensureVisible(find.text('The screen size'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('The screen size'));
    await tester.pumpAndSettle();
    expect(find.textContaining('screen size in inches'), findsOneWidget);
  });

  testWidgets('a ruler calibrates over the longest whole centimetre that '
      'surely fits, and says so', (tester) async {
    final semantics = tester.ensureSemantics();
    useLocale(tester, const Locale('en', 'GB'));
    await pumpRuler(tester, ppi: null);
    await calibrateWith(tester, 'A ruler');
    // About 105 mm of ruler, which may be 10% off uncalibrated: 8 cm.
    expect(find.textContaining('to the 8 cm mark'), findsOneWidget);
    expect(find.text('8 cm'), findsOneWidget);

    // From where 8 cm is at the estimated 420 dpi to the real 411 dpi.
    const estimatedEnd = 80 * 420 / 25.4 / _dpr;
    const realEnd = 80 * _perMm;
    await tester.dragFrom(
      const Offset(200, _top + estimatedEnd),
      const Offset(0, realEnd - estimatedEnd - 20),
    );
    await tester.dragFrom(
      const Offset(200, _top + realEnd - 20),
      const Offset(0, 20),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();

    expect(find.text('Calibrated with a ruler · ±0.5 mm'), findsOneWidget);
    final settings = await SettingsRepository.load();
    expect(settings.rulerPxPerMm('1080x2400'), closeTo(_dpi / 25.4, 0.05));
    expect(settings.rulerMethod('1080x2400'), CalibrationMethod.ruler);
    semantics.dispose();
  });

  testWidgets('a ruler dragged to the wrong mark is refused', (tester) async {
    useLocale(tester, const Locale('en', 'GB'));
    await pumpRuler(tester);
    await calibrateWith(tester, 'A ruler');
    expect(find.text('9 cm'), findsOneWidget);
    // Stopped at 4.5 cm instead of 9 cm.
    await tester.dragFrom(
      const Offset(200, _top + 90 * _perMm),
      const Offset(0, -45 * _perMm),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();
    expect(find.textContaining('doesn’t match 9 cm'), findsOneWidget);
    expect((await SettingsRepository.load()).rulerPxPerMm('1080x2400'), null);
  });

  testWidgets('in the US the ruler mark is in inches', (tester) async {
    useLocale(tester, const Locale('en', 'US'));
    await pumpRuler(tester);
    await calibrateWith(tester, 'A ruler');
    expect(find.textContaining('to the 3 in mark'), findsOneWidget);
  });

  testWidgets('typing the screen size calibrates to about 1%', (tester) async {
    final semantics = tester.ensureSemantics();
    // iPhone-like: nothing reported.
    await pumpRuler(tester, ppi: null);
    await calibrateWith(tester, 'The screen size');

    // Not a number, then a size that can't be this screen: refused.
    await tester.enterText(find.byType(TextField), 'six');
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();
    expect(find.textContaining('doesn’t fit this screen'), findsOneWidget);
    await tester.enterText(find.byType(TextField), '12.9');
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pumpAndSettle();
    expect(find.textContaining('doesn’t fit this screen'), findsOneWidget);
    expect((await SettingsRepository.load()).rulerPxPerMm('1080x2400'), null);

    // The real size (1080 × 2400 at 411 dpi is 6.4").
    await tester.enterText(find.byType(TextField), '6.4');
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();
    expect(find.text('Set for a 6.4-inch screen · about 1%'), findsOneWidget);
    final settings = await SettingsRepository.load();
    expect(settings.rulerPxPerMm('1080x2400'), closeTo(_dpi / 25.4, 0.05));
    expect(settings.rulerMethod('1080x2400'), CalibrationMethod.screenSize);
    // Lengths use it.
    await tester.dragFrom(
      const Offset(200, _top + 50 * _perMm),
      const Offset(0, 30 * _perMm),
    );
    await tester.pumpAndSettle();
    expect(length('80.0', '3.15'), findsOneWidget);
    semantics.dispose();
  });

  testWidgets('cancelling the method sheet changes nothing', (tester) async {
    await pumpRuler(tester);
    await tester.tap(find.text('Calibrate'));
    await tester.pumpAndSettle();
    // Nothing saved, so nothing to forget.
    expect(find.text('Use the phone’s screen size'), findsNothing);
    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();
    expect(
      find.text('Screen size from the phone · calibrate for ±0.5 mm'),
      findsOneWidget,
    );
    expect(find.text('Calibrate'), findsOneWidget);
  });

  testWidgets('width: the box button adds lines across, the reading shows '
      'length × width and area, and it is off again next time', (tester) async {
    useLocale(tester, const Locale('en', 'GB'));
    final semantics = tester.ensureSemantics();
    await pumpRuler(tester);
    expect(find.text('50.0 mm'), findsOneWidget);
    await tester.tap(find.byTooltip('Measure width too'));
    await tester.pump();
    expect(find.text('50.0 × 30.0 mm'), findsOneWidget);
    expect(find.text('Area 15.0 cm²'), findsOneWidget);
    // Smaller than a single length (40).
    expect(
      tester.widget<Text>(find.text('50.0 × 30.0 mm')).style?.fontSize,
      22,
    );
    expect(
      find.bySemanticsLabel(
        'Length 50.0 millimetres, width 30.0 millimetres, '
        'area 15.0 square centimetres',
      ),
      findsOneWidget,
    );

    // The far width line, grabbed away from the length lines.
    await tester.dragFrom(
      const Offset(40 * _perMm, _top + 70 * _perMm),
      const Offset(10 * _perMm, 0),
    );
    await tester.pumpAndSettle();
    expect(find.text('50.0 × 40.0 mm'), findsOneWidget);

    await tester.tap(find.byTooltip('Centimetres'));
    await tester.pump();
    expect(find.text('5.00 × 4.00 cm'), findsOneWidget);
    expect(find.text('Area 20.0 cm²'), findsOneWidget);
    await tester.tap(find.byTooltip('Inches'));
    await tester.pump();
    expect(find.text('1.97 × 1.57 in'), findsOneWidget);
    expect(find.text('Area 3.10 in²'), findsOneWidget);

    await tester.tap(find.byTooltip('Measure width too'));
    await tester.pump();
    expect(find.text('1.97 in'), findsOneWidget);

    // Back out and in: length only again.
    await tester.tap(find.byTooltip('Measure width too'));
    await tester.pump();
    await tester.tap(find.bySemanticsLabel('Back'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Ruler'));
    await tester.pumpAndSettle();
    expect(find.textContaining('×'), findsNothing);
    semantics.dispose();
  });

  testWidgets('one finger holds the object while another drags; neither '
      'its rest nor its lift moves a line', (tester) async {
    final semantics = tester.ensureSemantics();
    await pumpRuler(tester);
    // Holding the object between the lines.
    final hold = await tester.startGesture(
      const Offset(150, _top + 25 * _perMm),
      pointer: 1,
    );
    await tester.pump(const Duration(milliseconds: 200));
    final drag = await tester.startGesture(
      const Offset(200, _top + 50 * _perMm),
      pointer: 2,
    );
    for (var i = 1; i <= 10; i++) {
      await drag.moveTo(Offset(200, _top + (50 + 2 * i) * _perMm));
      await tester.pump(const Duration(milliseconds: 16));
    }
    await drag.up();
    await tester.pump(const Duration(milliseconds: 300));
    expect(length('70.0', '2.76'), findsOneWidget);
    await hold.moveBy(const Offset(4, 30));
    await tester.pump(const Duration(milliseconds: 300));
    await hold.up();
    await tester.pumpAndSettle();
    expect(length('70.0', '2.76'), findsOneWidget);
    semantics.dispose();
  });

  testWidgets('two fingers move both lines at once', (tester) async {
    final semantics = tester.ensureSemantics();
    await pumpRuler(tester);
    final a = await tester.startGesture(
      const Offset(200, _top + 1),
      pointer: 1,
    );
    final b = await tester.startGesture(
      const Offset(200, _top + 50 * _perMm),
      pointer: 2,
    );
    await a.moveTo(const Offset(200, _top + 10 * _perMm));
    await b.moveTo(const Offset(200, _top + 90 * _perMm));
    await tester.pump();
    await a.up();
    await b.up();
    await tester.pumpAndSettle();
    expect(length('80.0', '3.15'), findsOneWidget);
    semantics.dispose();
  });

  testWidgets('portrait: the units sit in the footer row with Calibrate and '
      'the lock; only the reading is on the ruler', (tester) async {
    useLocale(tester, const Locale('en', 'GB'));
    await pumpRuler(tester);
    final ruler = tester.getRect(find.bySemanticsLabel(RegExp('^Length ')));
    final units = tester.getRect(find.byTooltip('Centimetres'));
    final calibrate = tester.getRect(find.text('Calibrate'));
    final lock = tester.getRect(find.byTooltip('Lock handles'));
    expect(units.top, greaterThanOrEqualTo(ruler.bottom));
    expect(units.center.dy, closeTo(calibrate.center.dy, 8));
    expect(units.center.dy, closeTo(lock.center.dy, 8));
    expect(units.right, lessThan(calibrate.left));
    // The orange stays large text, readable at 3:1.
    expect(tester.widget<Text>(find.text('mm')).style?.fontSize, 19);
    // Calibrate keeps its word at full size on this phone.
    expect(
      tester.getSize(find.widgetWithText(SoftButton, 'Calibrate')).width,
      greaterThan(110),
    );
    await tester.tap(find.byTooltip('Centimetres'));
    await tester.pump();
    expect(find.text('5.00 cm'), findsOneWidget);
  });

  testWidgets('locked lines ignore drags; Calibrate waits for unlock', (
    tester,
  ) async {
    final semantics = tester.ensureSemantics();
    await pumpRuler(tester);
    await tester.tap(find.byTooltip('Lock handles'));
    await tester.pump();
    await tester.dragFrom(
      const Offset(200, _top + 50 * _perMm),
      const Offset(0, 100),
    );
    await tester.pumpAndSettle();
    expect(length('50.0', '1.97'), findsOneWidget);
    final calibrate = tester.widget<SoftButton>(
      find.widgetWithText(SoftButton, 'Calibrate'),
    );
    expect(calibrate.onPressed, isNull);
    semantics.dispose();
  });

  group('units', () {
    /// The big reading's size (40) or the small line's (18).
    double? size(WidgetTester tester, String text) =>
        tester.widget<Text>(find.text(text)).style?.fontSize;

    testWidgets('outside the US it starts in mm, inches small', (tester) async {
      useLocale(tester, const Locale('en', 'GB'));
      await pumpRuler(tester);
      expect(size(tester, '50.0 mm'), 40);
      expect(size(tester, '1.97 in'), 18);
    });

    testWidgets('in the US it starts in inches, mm small', (tester) async {
      useLocale(tester, const Locale('en', 'US'));
      await pumpRuler(tester);
      expect(size(tester, '1.97 in'), 40);
      expect(size(tester, '50.0 mm'), 18);
    });

    testWidgets('picking a unit changes the reading, is remembered, and a '
        'drag still measures exactly', (tester) async {
      useLocale(tester, const Locale('en', 'GB'));
      await pumpRuler(tester);
      await tester.tap(find.byTooltip('Centimetres'));
      await tester.pump();
      expect(size(tester, '5.00 cm'), 40);
      expect(size(tester, '1.97 in'), 18);
      expect((await SettingsRepository.load()).rulerUnit, LengthUnit.cm);

      await tester.dragFrom(
        const Offset(200, _top + 50 * _perMm),
        const Offset(0, 30 * _perMm),
      );
      await tester.pumpAndSettle();
      expect(size(tester, '8.00 cm'), 40);

      await tester.tap(find.byTooltip('Inches'));
      await tester.pump();
      expect(size(tester, '3.15 in'), 40);
      expect(size(tester, '80.0 mm'), 18);
      expect((await SettingsRepository.load()).rulerUnit, LengthUnit.inch);
    });

    testWidgets('a saved unit wins over the region', (tester) async {
      useLocale(tester, const Locale('en', 'US'));
      await pumpRuler(tester, prefs: {'rulerUnit': 'cm'});
      expect(size(tester, '5.00 cm'), 40);
    });

    testWidgets('the switch hides while calibrating', (tester) async {
      await pumpRuler(tester);
      expect(find.byTooltip('Centimetres'), findsOneWidget);
      await calibrateWith(tester, 'A bank card');
      expect(find.byTooltip('Centimetres'), findsNothing);
      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();
      expect(find.byTooltip('Centimetres'), findsOneWidget);
    });

    test('lengths format per unit, with the language’s decimal mark', () {
      expect(formatLength(50, LengthUnit.mm), '50.0 mm');
      expect(formatLength(50.5, LengthUnit.cm), '5.05 cm');
      expect(formatLength(50.8, LengthUnit.inch), '2.00 in');
      final previous = Intl.defaultLocale;
      Intl.defaultLocale = 'de';
      addTearDown(() => Intl.defaultLocale = previous);
      expect(formatLength(50.5, LengthUnit.cm), '5,05 cm');
      expect(formatLength(50.8, LengthUnit.inch), '2,00 in');
    });
  });

  testWidgets('German uses decimal commas', (tester) async {
    await pumpRuler(tester, prefs: {'language': 'de'}).catchError((_) {});
    // The tool is called "Lineal" in German; open it by its name.
    await tester.tap(find.text('Lineal'));
    await tester.pumpAndSettle();
    expect(find.text('50,0 mm'), findsOneWidget);
    expect(find.text('1,97 in'), findsOneWidget);
  });

  group('RulerViewModel', () {
    late RulerViewModel vm;

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      vm = RulerViewModel(
        settings: await SettingsRepository.load(),
        display: FakeDisplayRotationService(),
      );
    });

    const t0 = Duration.zero;
    Duration ms(int v) => Duration(milliseconds: v);

    /// Finger [id] down at [along] (and [across]) mm, grabbing within 4 mm.
    void down(int id, double along, {double across = 30, Duration? at}) =>
        vm.pointerDown(id, along, across, time: at ?? t0, grabMm: 4);

    test('a finger near a line takes it, snapped to 0.5 mm, kept on the '
        'ruler', () {
      vm.setRulerLength(100, widthMm: 60);
      down(1, 48.2);
      expect(vm.end(1), 48.0);
      vm.pointerMove(1, 130, 30);
      expect(vm.end(1), 100);
      vm.pointerMove(1, -5, 30);
      expect(vm.end(1), 0);
      expect(vm.end(0), 0);
    });

    testWidgets('on a shorter ruler the length and the nearest line are '
        'those drawn', (tester) async {
      vm.setRulerLength(130);
      down(1, 50);
      vm
        ..pointerMove(1, 120, 30)
        ..pointerUp(1, time: ms(500));
      expect(vm.lengthMm, 120);
      // Turned to a 60 mm ruler: the line is drawn at 60, so it reads 60.
      vm.setRulerLength(60);
      expect(vm.lengthMm, 60);
      // A touch at 57 mm takes that line, not the one at 0.
      down(2, 57);
      expect(vm.end(1), 57);
      await tester.pump();
    });

    test('lines beyond a shorter ruler (after rotating) stay visible', () {
      vm.setRulerLength(120);
      down(1, 50);
      vm.pointerMove(1, 110, 30);
      expect(vm.shown(1, 60), 60);
      expect(vm.end(1), 110); // kept for when it fits again
    });

    test('two fingers move two lines at once', () {
      vm.setRulerLength(120);
      down(1, 1);
      down(2, 49);
      vm
        ..pointerMove(1, 20, 30)
        ..pointerMove(2, 80, 30);
      expect(vm.end(0), 20);
      expect(vm.end(1), 80);
      expect(vm.lengthMm, 60);
    });

    test('a finger resting on the object moves nothing, before or after the '
        'other finger lets go', () {
      vm.setRulerLength(120);
      down(1, 25); // holding the object, between the lines
      down(2, 50, at: ms(200)); // dragging the far line
      vm
        ..pointerMove(2, 70, 30)
        ..pointerUp(2, time: ms(900));
      expect(vm.end(1), 70);
      // The holding finger shifts and lifts: nothing jumps to it.
      vm
        ..pointerMove(1, 31, 34)
        ..pointerUp(1, time: ms(1500));
      expect(vm.end(0), 0);
      expect(vm.end(1), 70);
    });

    test('a quick lone tap moves the nearest line there; a long press does '
        'not', () {
      vm.setRulerLength(120);
      down(1, 20);
      vm.pointerUp(1, time: ms(120));
      expect(vm.end(0), 20);
      down(2, 40, at: ms(1000));
      vm.pointerUp(2, time: ms(1600));
      expect(vm.end(1), 50);
    });

    test('a lone finger dragging from elsewhere takes the nearest line once '
        'it really moves', () {
      vm.setRulerLength(120);
      down(1, 30); // 30 from line 0, 20 from line 1
      vm.pointerMove(1, 31, 30);
      expect(vm.end(1), 50, reason: 'not past the slop yet');
      vm.pointerMove(1, 36, 30);
      expect(vm.end(1), 36);
      expect(vm.end(0), 0);
    });

    test('width lines take part only with width on', () {
      vm.setRulerLength(120, widthMm: 60);
      // Off: a touch on the width line's spot moves nothing across.
      down(1, 90, across: 40);
      vm.pointerUp(1, time: ms(1000));
      expect(vm.end(3), 40);
      vm.toggleWidth();
      expect(vm.width, isTrue);
      expect(vm.widthMm, 30);
      down(2, 90, across: 39);
      vm.pointerMove(2, 90, 55);
      expect(vm.end(3), 55);
      expect(vm.widthMm, 45);
      // Kept on a narrower ruler, like the length lines.
      vm.setRulerLength(120, widthMm: 50);
      expect(vm.widthMm, 40);
      // Turning width off lets go of a held width line.
      vm
        ..toggleWidth()
        ..pointerMove(2, 90, 20);
      expect(vm.end(3), 55);
    });

    test('locked: no finger moves a line', () {
      vm
        ..setRulerLength(120)
        ..toggleLock();
      down(1, 50);
      vm
        ..pointerMove(1, 80, 30)
        ..pointerUp(1, time: ms(100));
      down(2, 10);
      vm.pointerUp(2, time: ms(100));
      expect(vm.end(0), 0);
      expect(vm.end(1), 50);
    });

    test('opening again unlocks, turns width off and leaves calibration', () {
      vm
        ..toggleLock()
        ..toggleWidth()
        ..startCalibration(
          CalibrationMethod.card,
          scale: estimatedScale(2),
          dpr: 2,
        )
        ..open();
      expect(vm.locked, isFalse);
      expect(vm.width, isFalse);
      expect(vm.calibrating, isFalse);
    });
  });
}
