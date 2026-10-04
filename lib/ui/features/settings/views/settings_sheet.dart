import 'package:flutter/material.dart';

import '../../../../data/repositories/settings_repository.dart';

Future<void> showSettingsSheet(
  BuildContext context,
  SettingsRepository settings,
) => showModalBottomSheet<void>(
  context: context,
  showDragHandle: true,
  isScrollControlled: true,
  builder: (context) => ListenableBuilder(
    listenable: settings,
    builder: (context, _) => SafeArea(
      child: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.only(bottom: 16),
        children: [
          ListTile(
            title: const Text('Appearance'),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 8),
              child: SegmentedButton<ThemeMode>(
                segments: const [
                  ButtonSegment(
                    value: ThemeMode.system,
                    icon: Icon(Icons.brightness_auto_outlined),
                    label: Text('System'),
                  ),
                  ButtonSegment(
                    value: ThemeMode.light,
                    icon: Icon(Icons.light_mode_outlined),
                    label: Text('Light'),
                  ),
                  ButtonSegment(
                    value: ThemeMode.dark,
                    icon: Icon(Icons.dark_mode_outlined),
                    label: Text('Dark'),
                  ),
                ],
                selected: {settings.themeMode},
                onSelectionChanged: (s) => settings.setThemeMode(s.first),
              ),
            ),
          ),
          ListTile(
            title: const Text('Level units'),
            trailing: SegmentedButton<AngleUnit>(
              segments: const [
                ButtonSegment(value: AngleUnit.degrees, label: Text('°')),
                ButtonSegment(value: AngleUnit.percent, label: Text('%')),
              ],
              selected: {settings.unit},
              onSelectionChanged: (s) => settings.setUnit(s.first),
            ),
          ),
          SwitchListTile(
            title: const Text('Vibrate when level'),
            value: settings.haptics,
            onChanged: settings.setHaptics,
          ),
          ListTile(
            title: const Text('Reset calibration'),
            subtitle: Text(
              settings.isCalibrated
                  ? 'Use the factory sensor zero again'
                  : 'Not calibrated',
            ),
            enabled: settings.isCalibrated,
            leading: const Icon(Icons.restart_alt),
            onTap: settings.resetCalibration,
          ),
        ],
      ),
    ),
  ),
);
