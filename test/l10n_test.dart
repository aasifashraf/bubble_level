import 'dart:convert';
import 'dart:io';

import 'package:bubble_level/data/repositories/orientation_repository.dart';
import 'package:bubble_level/data/repositories/settings_repository.dart';
import 'package:bubble_level/domain/angles.dart';
import 'package:bubble_level/main.dart';
import 'package:bubble_level/ui/core/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'helpers/fakes.dart';

/// Placeholders like {tool} and the plural selector {count, plural, …}.
Set<String> _placeholders(String text) =>
    RegExp(r'\{(\w+)(?=[},])').allMatches(text).map((m) => m[1]!).toSet()
      ..removeWhere((p) => p.startsWith(RegExp('[A-Z]')));

void main() {
  final microphone = FakeMicrophoneService();
  group('translations', () {
    Map<String, dynamic> read(String code) =>
        jsonDecode(File('lib/l10n/app_$code.arb').readAsStringSync())
            as Map<String, dynamic>;
    final en = read('en');
    final keys = en.keys.where((k) => !k.startsWith('@')).toList();

    test('every language is offered in Settings', () {
      final supported = AppLocalizations.supportedLocales
          .map((l) => l.languageCode)
          .toSet();
      expect(supported, languageNames.keys.toSet());
    });

    for (final code in languageNames.keys.where((c) => c != 'en')) {
      test('$code has every string, with the same placeholders', () {
        final arb = read(code);
        for (final key in keys) {
          expect(arb[key], isA<String>(), reason: '$code is missing $key');
          final want = _placeholders(en[key] as String)
            ..removeWhere((p) => !en[key].toString().contains('{$p'));
          final got = _placeholders(arb[key] as String);
          expect(
            got.intersection({'tool', 'count', 'sensors', 'value', 'heading'}),
            want.intersection({'tool', 'count', 'sensors', 'value', 'heading'}),
            reason: '$code $key',
          );
        }
      });
    }
  });

  group('app in other languages', () {
    late FakeMotionSensorService sensors;

    Future<void> pumpIn(
      WidgetTester tester,
      String code, {
      Size size = const Size(411, 860),
    }) async {
      tester.view.physicalSize = size;
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.reset);
      SharedPreferences.setMockInitialValues({'language': code});
      final settings = await SettingsRepository.load();
      sensors = FakeMotionSensorService();
      await tester.pumpWidget(
        BubbleLevelApp(
          microphone: microphone,
          settings: settings,
          orientation: OrientationRepository(
            sensors: sensors,
            display: FakeDisplayRotationService(),
          ),
          sensors: sensors,
        ),
      );
      await tester.pumpAndSettle();
    }

    Future<void> send(WidgetTester tester, Vec3 up) async {
      sensors.sendUp(up);
      await tester.pump();
      await tester.pump();
    }

    for (final code in languageNames.keys) {
      testWidgets('$code: every tool and its guide fit a small phone with '
          'large text', (tester) async {
        tester.platformDispatcher.textScaleFactorTestValue = 1.6;
        addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
        await pumpIn(tester, code, size: const Size(320, 568));
        final l = lookupAppLocalizations(Locale(code));
        expect(find.text(l.homeTitle), findsWidgets);
        expect(tester.takeException(), isNull, reason: 'home');
        for (final tool in [
          l.toolLevel,
          l.toolAngle,
          l.toolCompass,
          l.toolProtractor,
          l.toolRuler,
          l.toolMetal,
          l.toolVibration,
          l.toolSound,
          l.toolLight,
          l.toolAltimeter,
          l.toolHeight,
          l.toolCamera,
          l.toolGForce,
        ]) {
          final tile = find.text(tool).first;
          await tester.ensureVisible(tile);
          await tester.pumpAndSettle();
          await tester.tap(tile);
          await tester.pumpAndSettle();
          sensors.sendMagnet(const Vec3(0, 20, -40));
          await send(tester, const Vec3(0.1, 0, 1));
          expect(tester.takeException(), isNull, reason: '$code $tool');

          await tester.tap(find.byTooltip(l.howToUse));
          await tester.pumpAndSettle();
          expect(tester.takeException(), isNull, reason: '$code $tool help');
          await tester.ensureVisible(find.text(l.gotIt));
          await tester.pumpAndSettle();
          await tester.tap(find.text(l.gotIt));
          await tester.pumpAndSettle();

          await tester.tap(find.byTooltip(l.back));
          await tester.pumpAndSettle();
        }
      });
    }

    for (final code in ['ar', 'ur']) {
      testWidgets('$code reads right to left; Back still works', (
        tester,
      ) async {
        await pumpIn(tester, code);
        final l = lookupAppLocalizations(Locale(code));
        expect(
          Directionality.of(tester.element(find.text(l.homeTitle).first)),
          TextDirection.rtl,
        );
        await tester.tap(find.text(l.toolLevel).first);
        await tester.pumpAndSettle();
        final back = tester.getCenter(find.byTooltip(l.back));
        expect(back.dx, greaterThan(300), reason: 'back tab on the right');
        await tester.tap(find.byTooltip(l.back));
        await tester.pumpAndSettle();
        expect(find.text(l.tools), findsOneWidget);
      });
    }

    testWidgets('numbers use the language’s decimal separator', (tester) async {
      await pumpIn(tester, 'de');
      final l = lookupAppLocalizations(const Locale('de'));
      await tester.ensureVisible(find.text(l.toolAltimeter));
      await tester.pumpAndSettle();
      await tester.tap(find.text(l.toolAltimeter));
      await tester.pumpAndSettle();
      sensors.sendPressure(1013.25);
      await tester.pump();
      await tester.pump();
      expect(find.text('1013,3 hPa'), findsOneWidget);
    });

    testWidgets('choosing a language in Settings switches and is remembered', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(411, 860);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.reset);
      SharedPreferences.setMockInitialValues({});
      final settings = await SettingsRepository.load();
      final s = FakeMotionSensorService();
      await tester.pumpWidget(
        BubbleLevelApp(
          microphone: microphone,
          settings: settings,
          orientation: OrientationRepository(
            sensors: s,
            display: FakeDisplayRotationService(),
          ),
          sensors: s,
        ),
      );
      expect(find.text('Bubble Level'), findsOneWidget);

      await tester.tap(find.byTooltip('Settings'));
      await tester.pumpAndSettle();
      await tester.ensureVisible(find.text('Language'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Language'));
      await tester.pumpAndSettle();
      await tester.ensureVisible(find.text('Deutsch'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Deutsch'));
      await tester.pumpAndSettle();

      expect((await SettingsRepository.load()).language, 'de');
      expect(find.text('Einstellungen'), findsOneWidget);

      await settings.setLanguage(null);
      await tester.pumpAndSettle();
      expect(find.text('Settings'), findsOneWidget);
    });
  });
}
