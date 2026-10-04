import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';

import 'controls.dart';
import 'dial.dart';
import 'readout.dart';
import 'theme.dart';

// Design previews for the Flutter Widget Previewer (VS Code sidebar, or
// `flutter widget-preview start`). They render with fixed values, so no
// sensors are needed.

/// Wraps a preview in the app's real theme and background.
Widget lightTheme(Widget child) => _themed(Brightness.light, child);
Widget darkTheme(Widget child) => _themed(Brightness.dark, child);

Widget _themed(Brightness brightness, Widget child) {
  final theme = buildTheme(brightness);
  return Theme(
    data: theme,
    child: ColoredBox(color: theme.colorScheme.surface, child: child),
  );
}

/// Each gauge in light and dark, at gauge size.
final class GaugePreview extends MultiPreview {
  const GaugePreview(this.name);

  final String name;

  @override
  List<Preview> get previews => const [
    Preview(name: 'light', wrapper: lightTheme),
    Preview(name: 'dark', wrapper: darkTheme),
  ];

  @override
  List<Preview> transform() => [
    for (final p in super.transform())
      (p.toBuilder()
            ..name = '$name · ${p.name}'
            ..group = 'Gauges'
            ..size = const Size(375, 812))
          .build(),
  ];
}

@GaugePreview('Level – flat, off')
Widget levelOffPreview() => const InstrumentDial(
  value: '1.2°',
  semanticsLabel: 'Tilt from level 1.2°',
  labels: false,
  bubble: Offset(0.45, -0.3),
);

@GaugePreview('Level – flat, level')
Widget levelLockedPreview() => const InstrumentDial(
  value: '0.0°',
  semanticsLabel: 'Tilt from level 0.0°',
  labels: false,
  bubble: Offset.zero,
  locked: true,
);

@GaugePreview('Level – on an edge')
Widget edgePreview() => const InstrumentDial(
  value: '2.4°',
  semanticsLabel: 'From level 2.4°',
  waterAngle: 2.4,
  ballAngle: 92.4,
);

@GaugePreview('Angle')
Widget anglePreview() => const InstrumentDial(
  value: '32.5°',
  semanticsLabel: 'From level 32.5°',
  arcSweep: 32.5,
  ballAngle: 32.5,
);

@GaugePreview('Compass')
Widget compassPreview() => const InstrumentDial(
  value: '260°',
  label: 'W',
  semanticsLabel: 'Magnetic heading 260 degrees, W',
  letters: true,
  ballAngle: 260,
);

@Preview(name: 'Status and buttons · light', group: 'Text', wrapper: lightTheme)
@Preview(name: 'Status and buttons · dark', group: 'Text', wrapper: darkTheme)
Widget detailsPreview() => Padding(
  padding: const EdgeInsets.all(24),
  child: Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const StatusBanner(
        icon: Icons.arrow_forward_rounded,
        text: 'Right side high',
      ),
      const SizedBox(height: 12),
      const StatusBanner(
        icon: Icons.check_circle_rounded,
        text: 'Level',
        tone: StatusTone.success,
      ),
      const SizedBox(height: 12),
      const StatusBanner(
        icon: Icons.warning_amber_rounded,
        text: 'Magnetic interference · move away from metal',
        tone: StatusTone.warning,
      ),
      const SizedBox(height: 16),
      Row(
        spacing: 14,
        children: [
          Expanded(
            child: SoftButton(
              label: 'Hold',
              icon: Icons.pause_rounded,
              onPressed: () {},
            ),
          ),
          Expanded(
            child: SoftButton(
              label: 'Set zero',
              icon: Icons.adjust_rounded,
              onPressed: () {},
              emphasis: true,
            ),
          ),
        ],
      ),
    ],
  ),
);
