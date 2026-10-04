import 'package:bubble_level/data/repositories/orientation_repository.dart';
import 'package:bubble_level/data/repositories/settings_repository.dart';
import 'package:bubble_level/domain/angles.dart';
import 'package:bubble_level/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'helpers/fakes.dart';

void main() {
  late FakeMotionSensorService sensors;

  /// Phone-sized window unless [size] says otherwise.
  Future<void> pumpApp(
    WidgetTester tester, {
    Size size = const Size(411, 860),
    Map<String, Object> prefs = const {},
  }) async {
    tester.view.physicalSize = size;
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    SharedPreferences.setMockInitialValues(prefs);
    final settings = await SettingsRepository.load();
    sensors = FakeMotionSensorService();
    await tester.pumpWidget(
      BubbleLevelApp(
        settings: settings,
        orientation: OrientationRepository(
          sensors: sensors,
          display: FakeDisplayRotationService(),
        ),
      ),
    );
  }

  Future<void> openTool(WidgetTester tester, String name) async {
    // On small screens the list scrolls; bring the tool into view first.
    await tester.ensureVisible(find.text(name));
    await tester.pumpAndSettle();
    await tester.tap(find.text(name));
    await tester.pumpAndSettle();
  }

  /// Sends one accelerometer sample and lets the screen rebuild: the
  /// stream event lands after the first frame, the rebuild in the second.
  Future<void> send(WidgetTester tester, Vec3 up) async {
    sensors.sendUp(up);
    await tester.pump();
    await tester.pump();
  }

  testWidgets('home lists the three tools', (tester) async {
    await pumpApp(tester);
    expect(find.text('Compass'), findsOneWidget);
    expect(find.text('Level'), findsOneWidget);
    expect(find.text('Angle'), findsOneWidget);
    expect(find.byType(NavigationBar), findsNothing);
  });

  testWidgets('home: list by default, grid on request, remembered', (
    tester,
  ) async {
    await pumpApp(tester);
    double y(String t) => tester.getCenter(find.text(t)).dy;
    double x(String t) => tester.getCenter(find.text(t)).dx;

    // List: Level, Angle, Compass from top to bottom.
    expect(find.text('Bubble and spirit level'), findsOneWidget);
    expect(y('Level') < y('Angle') && y('Angle') < y('Compass'), isTrue);

    await tester.tap(find.byTooltip('Grid view'));
    await tester.pumpAndSettle();
    // Grid: one row, same order left to right, no descriptions.
    expect(find.text('Bubble and spirit level'), findsNothing);
    expect(y('Level'), y('Compass'));
    expect(x('Level') < x('Angle') && x('Angle') < x('Compass'), isTrue);
    final reloaded = await SettingsRepository.load();
    expect(reloaded.homeLayout, HomeLayout.grid);

    // Tools still open from the grid.
    await openTool(tester, 'Angle');
    await send(tester, Vec3.up);
    expect(find.text('Angle from the Earth'), findsOneWidget);
  });

  testWidgets('a tool opens full screen and the back tab returns home', (
    tester,
  ) async {
    await pumpApp(tester);
    await openTool(tester, 'Level');
    expect(find.text('Waiting for sensors…'), findsOneWidget);

    await tester.tap(find.byTooltip('Back'));
    await tester.pumpAndSettle();
    expect(find.text('Compass'), findsOneWidget);
    expect(find.text('Waiting for sensors…'), findsNothing);
  });

  testWidgets('level: reading, guidance, hold and release', (tester) async {
    await pumpApp(tester);
    await openTool(tester, 'Level');
    final semantics = tester.ensureSemantics();

    await send(tester, Vec3.up);
    expect(find.bySemanticsLabel('Tilt from level 0.0°'), findsOneWidget);
    expect(find.text('Level'), findsWidgets);

    await tester.tap(find.text('Hold'));
    await tester.pump();
    expect(find.text('Held · Level'), findsOneWidget);
    await tester.tap(find.text('Release'));
    await tester.pump();
    expect(find.text('Held · Level'), findsNothing);
    semantics.dispose();
  });

  testWidgets('level: guidance says which side is high', (tester) async {
    await pumpApp(tester);
    await openTool(tester, 'Level');
    await send(tester, const Vec3(0.1, 0, 1)); // right edge raised ~5.7°
    expect(find.text('Right side high'), findsOneWidget);
  });

  testWidgets('level: shows X and Y tilt', (tester) async {
    await pumpApp(tester);
    await openTool(tester, 'Level');
    await send(tester, const Vec3(0.1, 0, 1)); // right edge raised ~5.7°
    expect(find.text('X · left / right'), findsOneWidget);
    expect(find.text('+5.7°'), findsOneWidget);
    expect(find.text('Y · forward / back'), findsOneWidget);
    expect(find.text('0.0°'), findsOneWidget);
  });

  testWidgets('level: on an edge it reads the angle from level', (
    tester,
  ) async {
    await pumpApp(tester);
    await openTool(tester, 'Level');
    final semantics = tester.ensureSemantics();
    await send(tester, const Vec3(0.05, 1, 0)); // upright, about 2.9° off
    expect(find.bySemanticsLabel('From level 2.9°'), findsOneWidget);
    expect(find.text('Left end low'), findsOneWidget);
    semantics.dispose();
  });

  testWidgets('angle: set and clear zero', (tester) async {
    await pumpApp(tester);
    await openTool(tester, 'Angle');
    await send(tester, Vec3.up);
    expect(find.text('Angle from the Earth'), findsOneWidget);

    await tester.tap(find.text('Set zero here'));
    await tester.pump();
    expect(find.text('Measuring from your zero'), findsOneWidget);

    await tester.tap(find.text('Clear zero'));
    await tester.pump();
    expect(find.text('Set zero here'), findsOneWidget);
  });

  testWidgets('compass: just the dial, reading the heading', (tester) async {
    await pumpApp(tester);
    await openTool(tester, 'Compass');
    final semantics = tester.ensureSemantics();
    final pose = devicePose(heading: 200, pitch: 0);
    sensors
      ..sendUp(pose.up)
      ..sendMagnet(pose.field);
    await tester.pump();
    await send(tester, pose.up);
    expect(
      find.bySemanticsLabel(RegExp(r'^Magnetic heading 200 degrees')),
      findsOneWidget,
    );
    // Nothing but the instrument and the header on the compass.
    expect(find.byType(FilledButton), findsNothing);
    expect(find.byType(NavigationBar), findsNothing);
    semantics.dispose();
  });

  testWidgets('compass without a magnetometer explains why', (tester) async {
    await pumpApp(tester);
    await openTool(tester, 'Compass');
    await send(tester, Vec3.up);
    sensors.magnet.addError(Exception('NO_SENSOR'));
    await tester.pump();
    await tester.pump();
    expect(find.textContaining('no magnetometer'), findsOneWidget);
  });

  testWidgets('the sun/moon button switches theme and is remembered', (
    tester,
  ) async {
    await pumpApp(tester);
    expect(
      Theme.of(tester.element(find.text('Compass'))).brightness,
      Brightness.light,
    );
    await tester.tap(find.byTooltip('Dark mode'));
    await tester.pumpAndSettle();
    expect(
      Theme.of(tester.element(find.text('Compass'))).brightness,
      Brightness.dark,
    );
    expect(find.byTooltip('Light mode'), findsOneWidget);
    final reloaded = await SettingsRepository.load();
    expect(reloaded.themeMode, ThemeMode.dark);
  });

  testWidgets('settings sheet: theme and vibration are saved', (tester) async {
    await pumpApp(tester);
    await tester.tap(find.byTooltip('Settings'));
    await tester.pumpAndSettle();
    expect(find.text('Settings'), findsOneWidget);

    await tester.tap(find.text('Dark'));
    await tester.pumpAndSettle();
    expect(
      Theme.of(tester.element(find.text('Settings'))).brightness,
      Brightness.dark,
    );

    // The vibration switch: the knob toggles on tap.
    await tester.tap(find.text('Vibrate when level'));
    await tester.pumpAndSettle();
    final reloaded = await SettingsRepository.load();
    expect(reloaded.themeMode, ThemeMode.dark);
    expect(reloaded.haptics, isFalse);
  });

  testWidgets('settings sheet switches units', (tester) async {
    await pumpApp(tester);
    await tester.tap(find.byTooltip('Settings'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('%'));
    await tester.pumpAndSettle();
    await tester.tapAt(const Offset(10, 10)); // dismiss
    await tester.pumpAndSettle();

    await openTool(tester, 'Level');
    final semantics = tester.ensureSemantics();
    await send(tester, Vec3.up);
    expect(find.bySemanticsLabel('Tilt from level 0.0%'), findsOneWidget);
    semantics.dispose();
  });

  testWidgets('dark theme renders every screen without errors', (tester) async {
    await pumpApp(tester, prefs: {'themeMode': 'dark'});
    final pose = devicePose(heading: 120, pitch: 0);
    for (final tool in ['Compass', 'Level', 'Angle']) {
      await openTool(tester, tool);
      sensors
        ..sendUp(pose.up)
        ..sendMagnet(pose.field);
      await tester.pump();
      await send(tester, pose.up);
      expect(tester.takeException(), isNull, reason: tool);
      await tester.tap(find.byTooltip('Back'));
      await tester.pumpAndSettle();
    }
  });

  for (final (name, size) in [
    ('small phone', const Size(320, 568)),
    ('tablet landscape', const Size(1200, 800)),
  ]) {
    testWidgets('no overflow on a $name with large text', (tester) async {
      tester.platformDispatcher.textScaleFactorTestValue = 1.6;
      addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
      await pumpApp(tester, size: size);
      expect(tester.takeException(), isNull, reason: 'home');
      for (final tool in ['Compass', 'Level', 'Angle']) {
        await openTool(tester, tool);
        await send(tester, const Vec3(0.1, 0, 1));
        expect(tester.takeException(), isNull, reason: tool);
        await tester.tap(find.byTooltip('Back'));
        await tester.pumpAndSettle();
      }
    });
  }
}
