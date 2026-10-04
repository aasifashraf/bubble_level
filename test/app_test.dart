import 'dart:math' as math;

import 'package:bubble_level/data/repositories/orientation_repository.dart';
import 'package:bubble_level/data/repositories/settings_repository.dart';
import 'package:bubble_level/data/services/sensor_availability_service.dart';
import 'package:bubble_level/data/services/sound_service.dart';
import 'package:bubble_level/domain/angles.dart';
import 'package:bubble_level/main.dart';
import 'package:bubble_level/ui/core/vial.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'helpers/fakes.dart';

const _allTools = [
  'Level',
  'Angle',
  'Compass',
  'Protractor',
  'Metal detector',
  'Vibration',
  'Altimeter',
];

void main() {
  late FakeMotionSensorService sensors;

  /// Phone-sized window unless [size] says otherwise.
  Future<void> pumpApp(
    WidgetTester tester, {
    Size size = const Size(411, 860),
    Map<String, Object> prefs = const {},
    Set<SensorKind> missing = const {},
    SoundService sound = const SilentSoundService(),
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
        sensors: sensors,
        missingSensors: missing,
        sound: sound,
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

  testWidgets('tools show help, not the theme toggle', (tester) async {
    await pumpApp(tester);
    for (final tool in _allTools) {
      await openTool(tester, tool);
      expect(find.byTooltip('Dark mode'), findsNothing, reason: tool);
      expect(find.byTooltip('Light mode'), findsNothing, reason: tool);

      await tester.tap(find.byTooltip('How to use'));
      await tester.pumpAndSettle();
      expect(find.text('How to use $tool'), findsOneWidget, reason: tool);
      await tester.ensureVisible(find.text('Got it'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Got it'));
      await tester.pumpAndSettle();
      expect(find.text('How to use $tool'), findsNothing, reason: tool);

      await tester.tap(find.byTooltip('Back'));
      await tester.pumpAndSettle();
    }
  });

  testWidgets('help fits a small phone with large text', (tester) async {
    await pumpApp(tester, size: const Size(320, 568));
    tester.platformDispatcher.textScaleFactorTestValue = 2;
    addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
    await openTool(tester, 'Level');
    await tester.tap(find.byTooltip('How to use'));
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
    // The sheet scrolls, so the last control is still reachable.
    await tester.ensureVisible(find.text('Got it'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Got it'));
    await tester.pumpAndSettle();
    expect(find.text('How to use Level'), findsNothing);
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
    for (final tool in _allTools) {
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
    ('phone landscape', const Size(860, 411)),
  ]) {
    testWidgets('no overflow on a $name with large text', (tester) async {
      tester.platformDispatcher.textScaleFactorTestValue = 1.6;
      addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
      await pumpApp(tester, size: size);
      expect(tester.takeException(), isNull, reason: 'home');
      for (final tool in _allTools) {
        await openTool(tester, tool);
        await send(tester, const Vec3(0.1, 0, 1));
        expect(tester.takeException(), isNull, reason: tool);
        await tester.tap(find.byTooltip('Back'));
        await tester.pumpAndSettle();
      }
    });
  }

  testWidgets('protractor: dragging an arm changes the angle', (tester) async {
    await pumpApp(tester);
    await openTool(tester, 'Protractor');
    final semantics = tester.ensureSemantics();
    expect(
      find.bySemanticsLabel('Angle between the arms 60.0°'),
      findsOneWidget,
    );

    final centre = tester.getCenter(
      find.bySemanticsLabel(RegExp('^Angle between')),
    );
    Offset at(double degrees) {
      final a = degrees * math.pi / 180;
      return centre + Offset(math.sin(a), -math.cos(a)) * 150;
    }

    final gesture = await tester.startGesture(at(60));
    await gesture.moveTo(at(75));
    await gesture.moveTo(at(90));
    await gesture.up();
    await tester.pump();
    expect(
      find.bySemanticsLabel('Angle between the arms 90.0°'),
      findsOneWidget,
    );

    await tester.tap(find.text('Reset'));
    await tester.pump();
    expect(
      find.bySemanticsLabel('Angle between the arms 60.0°'),
      findsOneWidget,
    );
    semantics.dispose();
  });

  testWidgets('metal detector: field, status and baseline', (tester) async {
    await pumpApp(tester);
    await openTool(tester, 'Metal detector');
    sensors
      ..sendMagnet(const Vec3(0, 45, 0))
      ..sendUp(Vec3.up);
    await tester.pump();
    await send(tester, Vec3.up);
    expect(find.text('No metal nearby'), findsOneWidget);
    expect(find.text('45 µT'), findsOneWidget);
    await tester.tap(find.text('Set baseline'));
    await tester.pump();
    expect(find.text('0 µT'), findsOneWidget); // change from baseline
  });

  testWidgets('vibration: live reading, status and peak reset', (tester) async {
    await pumpApp(tester);
    await openTool(tester, 'Vibration');
    expect(find.text('Waiting for sensors…'), findsOneWidget);
    for (var i = 0; i < 10; i++) {
      sensors.sendUserAccel(const Vec3(3, 0, 0));
    }
    await tester.pump();
    await tester.pump();
    expect(find.text('Strong vibration'), findsOneWidget);
    expect(find.text('3.0 m/s²'), findsWidgets);
    await tester.tap(find.text('Reset peak'));
    await tester.pump();
    expect(tester.takeException(), isNull);
  });

  testWidgets('altimeter: zeroing measures height', (tester) async {
    await pumpApp(tester);
    await openTool(tester, 'Altimeter');
    sensors.sendPressure(1013.25);
    await tester.pump();
    await tester.pump();
    expect(find.text('1013.3 hPa'), findsOneWidget);
    await tester.tap(find.text('Set zero here'));
    await tester.pump();
    expect(find.text('Measuring height from your zero'), findsOneWidget);
  });

  testWidgets('altimeter: phones without a barometer are told so', (
    tester,
  ) async {
    await pumpApp(tester);
    await openTool(tester, 'Altimeter');
    sensors.baro.addError(Exception('NO_SENSOR'));
    await tester.pump();
    await tester.pump();
    expect(find.textContaining('no barometer'), findsOneWidget);
  });

  testWidgets('home marks tools this phone can’t run and explains why', (
    tester,
  ) async {
    await pumpApp(tester, missing: {SensorKind.barometer});
    await tester.ensureVisible(find.text('Altimeter'));
    await tester.pumpAndSettle();
    expect(find.text('Not available on this phone'), findsOneWidget);

    await tester.tap(find.text('Altimeter'));
    await tester.pumpAndSettle();
    expect(find.text('Altimeter isn’t available'), findsOneWidget);
    expect(find.textContaining('needs a barometer'), findsOneWidget);
    // The tool itself didn't open.
    expect(find.text('Set zero here'), findsNothing);
    await tester.ensureVisible(find.text('OK'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();

    // Tools that don't need it still open.
    await openTool(tester, 'Level');
    expect(find.byTooltip('Back'), findsOneWidget);
  });

  testWidgets('grid view also marks unavailable tools', (tester) async {
    await pumpApp(
      tester,
      prefs: {'homeLayout': 'grid'},
      missing: {SensorKind.magnetometer},
    );
    // Compass and metal detector both need the magnetometer.
    expect(find.text('Not on this phone'), findsNWidgets(2));
  });

  testWidgets('a sensor that never reports gets a clear message', (
    tester,
  ) async {
    await pumpApp(tester);
    await openTool(tester, 'Compass');
    await send(tester, Vec3.up); // accelerometer works, compass sensor silent
    expect(find.text('Waiting for sensors…'), findsOneWidget);
    await tester.pump(const Duration(seconds: 5));
    expect(find.textContaining('No readings from the sensor'), findsOneWidget);
  });

  testWidgets('compass warns about magnetic interference', (tester) async {
    await pumpApp(tester);
    await openTool(tester, 'Compass');
    final pose = devicePose(heading: 90, pitch: 0);
    sensors
      ..sendUp(pose.up)
      ..sendMagnet(pose.field);
    await tester.pump();
    await send(tester, pose.up);
    expect(find.textContaining('Magnetic interference'), findsNothing);

    // A magnet next to the phone: far stronger than the Earth's field.
    for (var i = 0; i < 30; i++) {
      sensors.sendMagnet(pose.field * 4);
      await send(tester, pose.up);
    }
    expect(find.textContaining('Magnetic interference'), findsOneWidget);
  });

  testWidgets('phone landscape: readings sit beside the dial', (tester) async {
    await pumpApp(tester, size: const Size(860, 411));
    await openTool(tester, 'Level');
    await send(tester, const Vec3(0, 1, 0.02));
    final dial = tester.getRect(find.bySemanticsLabel(RegExp('level')));
    final hold = tester.getRect(find.text('Hold'));
    expect(hold.left, greaterThan(430), reason: 'footer on the right');
    expect(dial.right, lessThanOrEqualTo(hold.left));
    // The header title is the topmost "Level" (the status line also says it).
    final title = tester
        .widgetList<Text>(find.text('Level'))
        .map((t) => tester.getRect(find.byWidget(t)))
        .reduce((a, b) => a.top < b.top ? a : b);
    expect(dial.top, greaterThanOrEqualTo(title.bottom));
  });

  testWidgets('sheets fit phone landscape with large text', (tester) async {
    tester.platformDispatcher.textScaleFactorTestValue = 1.6;
    addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
    await pumpApp(tester, size: const Size(860, 411));
    await tester.tap(find.byTooltip('Settings'));
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull, reason: 'settings');
    tester.state<NavigatorState>(find.byType(Navigator).first).pop();
    await tester.pumpAndSettle();

    await openTool(tester, 'Vibration');
    await tester.tap(find.byTooltip('How to use'));
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull, reason: 'help');
  });

  group('level tube view', () {
    SpiritVial vial(WidgetTester tester, String label) => tester.widget(
      find.byWidgetPredicate(
        (w) => w is SpiritVial && w.semanticsLabel == label,
      ),
    );

    testWidgets('switches from the dial, and is remembered', (tester) async {
      await pumpApp(tester);
      await openTool(tester, 'Level');
      await send(tester, const Vec3(0.1, 0, 1)); // flat, right side high
      expect(find.byType(SpiritVial), findsNothing);

      await tester.tap(find.byTooltip('Tube view'));
      await tester.pump();
      // Flat: a left/right tube and a forward/back tube.
      expect(find.byType(SpiritVial), findsNWidgets(2));
      // The bubble floats toward the high (right) end.
      expect(vial(tester, 'Left and right tube').position, greaterThan(0.3));
      expect(vial(tester, 'Forward and back tube').position, closeTo(0, 0.05));

      // On an edge: one tube along it.
      for (var i = 0; i < 40; i++) {
        await send(tester, const Vec3(0, 1, 0.02));
      }
      expect(find.byType(SpiritVial), findsOneWidget);

      await tester.tap(find.byTooltip('Back'));
      await tester.pumpAndSettle();
      await openTool(tester, 'Level');
      for (var i = 0; i < 40; i++) {
        await send(tester, const Vec3(0.1, 0, 1));
      }
      expect(find.byType(SpiritVial), findsNWidgets(2));
      expect((await SettingsRepository.load()).levelStyle, LevelStyle.tube);
    });

    testWidgets('landscape: the tube fills the space below the header', (
      tester,
    ) async {
      await pumpApp(
        tester,
        size: const Size(860, 411),
        prefs: {'levelStyle': 'tube'},
      );
      await openTool(tester, 'Level');
      for (var i = 0; i < 40; i++) {
        await send(tester, const Vec3(0, 1, 0.02));
      }
      final tube = tester.getRect(find.byType(SpiritVial));
      final hold = tester.getRect(find.text('Hold'));
      expect(tube.width, greaterThan(250), reason: 'not squeezed');
      expect(tube.top, greaterThan(88), reason: 'below the header');
      expect(tube.right, lessThanOrEqualTo(hold.left));
    });

    for (final (name, size) in [
      ('small phone', const Size(320, 568)),
      ('phone landscape', const Size(860, 411)),
      ('tablet landscape', const Size(1200, 800)),
    ]) {
      testWidgets('no overflow on a $name with large text', (tester) async {
        tester.platformDispatcher.textScaleFactorTestValue = 1.6;
        addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
        await pumpApp(tester, size: size, prefs: {'levelStyle': 'tube'});
        await openTool(tester, 'Level');
        await send(tester, const Vec3(0.1, 0, 1));
        expect(tester.takeException(), isNull, reason: 'flat');
        for (var i = 0; i < 40; i++) {
          await send(tester, const Vec3(0, 1, 0.02));
        }
        expect(tester.takeException(), isNull, reason: 'edge');
      });
    }
  });

  group('sounds', () {
    testWidgets('metal detector beeps near metal; the speaker mutes it', (
      tester,
    ) async {
      final sound = RecordingSoundService();
      await pumpApp(tester, sound: sound);
      await openTool(tester, 'Metal detector');
      sensors.sendMagnet(const Vec3(0, 45, 0));
      await send(tester, Vec3.up);
      await tester.pump(const Duration(seconds: 2));
      expect(sound.ticks, 0, reason: 'no metal, no beep');

      // A magnet next to the phone: about 100 µT over the baseline.
      for (var i = 0; i < 30; i++) {
        sensors.sendMagnet(const Vec3(0, 145, 0));
        await send(tester, Vec3.up);
      }
      sound.ticks = 0;
      await tester.pump(const Duration(seconds: 2));
      expect(sound.ticks, greaterThan(8), reason: 'beeping fast');

      await tester.tap(find.byTooltip('Mute sound'));
      await tester.pump();
      expect(find.byTooltip('Turn sound on'), findsOneWidget);
      sound.ticks = 0;
      await tester.pump(const Duration(seconds: 2));
      expect(sound.ticks, 0, reason: 'muted');
      expect((await SettingsRepository.load()).sounds, isFalse);

      await tester.tap(find.byTooltip('Turn sound on'));
      await tester.pump();
      await tester.tap(find.byTooltip('Back'));
      await tester.pumpAndSettle();
      sound.ticks = 0;
      await tester.pump(const Duration(seconds: 2));
      expect(sound.ticks, 0, reason: 'closed');
    });

    testWidgets('Settings has a Sounds switch, remembered', (tester) async {
      await pumpApp(tester);
      await tester.tap(find.byTooltip('Settings'));
      await tester.pumpAndSettle();
      await tester.ensureVisible(find.text('Sounds'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Sounds'));
      await tester.pumpAndSettle();
      expect((await SettingsRepository.load()).sounds, isFalse);
    });
  });
}
