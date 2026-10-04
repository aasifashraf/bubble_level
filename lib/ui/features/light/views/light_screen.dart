import 'package:flutter/material.dart';

import '../../../../domain/light.dart';
import '../../../core/controls.dart';
import '../../../core/dial.dart';
import '../../../core/format.dart';
import '../../../core/help.dart';
import '../../../core/l10n.dart';
import '../../../core/readout.dart';
import '../../../core/theme.dart';
import '../../../core/tool_frame.dart';
import '../view_models/light_view_model.dart';

/// Light meter: lux on a logarithmic dial (each step ten times brighter),
/// foot-candles, and what the light is good for.
class LightScreen extends StatelessWidget {
  const LightScreen({super.key, required this.viewModel, required this.onBack});

  final LightViewModel viewModel;
  final VoidCallback onBack;

  static ToolHelp _help(AppLocalizations l) => ToolHelp(
    tool: l.toolLight,
    steps: [l.lightHelp1, l.lightHelp2, l.lightHelp3, l.lightHelp4],
    tip: l.lightTip,
  );

  /// Every 30°; the tenfold steps (60° apart) are labelled.
  static const _scale = [
    '1', '', '10', '', '100', '', //
    '1k', '', '10k', '', '100k', '',
  ];

  /// Red too dark to read, orange dim, green good for reading and desk
  /// work, orange again for glare.
  static List<DialZone> _zones(Palette p) => [
    (from: 0, color: p.gaugeDanger),
    (from: lightSweep(tooDarkLux), color: p.gaugeCaution),
    (from: lightSweep(readingLux), color: p.gaugeSafe),
    (from: lightSweep(glareLux), color: p.gaugeCaution),
  ];

  static String _band(AppLocalizations l, LightBand band) => switch (band) {
    LightBand.dark => l.lightDark,
    LightBand.dim => l.lightDim,
    LightBand.livingRoom => l.lightLivingRoom,
    LightBand.reading => l.lightReading,
    LightBand.bright => l.lightBright,
    LightBand.overcast => l.lightOvercast,
    LightBand.daylight => l.lightDaylight,
    LightBand.sun => l.lightSun,
  };

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, _) {
        final l = context.l10n;
        final r = viewModel.reading;
        final lux = r.lux;
        final sweep = lux == null ? 0.0 : lightSweep(lux);
        return ToolFrame(
          title: l.toolLight,
          onBack: onBack,
          trailing: HelpButton(help: _help(l)),
          bodyBottomInset: 120,
          body: SensorStateGate(
            state: r.state,
            ready: lux != null,
            missingText: l.noLightSensor,
            child: lux == null
                ? const SizedBox.shrink()
                : InstrumentDial(
                    value: formatLux(lux),
                    label: 'lx',
                    semanticsLabel: l.lightSemantics(formatLux(lux)),
                    scaleLabels: _scale,
                    arcSweep: sweep,
                    ballAngle: sweep,
                    zones: _zones(Palette.of(context)),
                    reserved: 200,
                  ),
          ),
          footer: lux == null
              ? null
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      spacing: 14,
                      children: [
                        Expanded(
                          child: ValueTile(
                            value: '${formatLux(lux)} lx',
                            caption: l.illuminance,
                          ),
                        ),
                        Expanded(
                          child: ValueTile(
                            value: '${formatLux(r.footCandles!)} fc',
                            caption: l.footCandles,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    viewModel.locked
                        ? StatusBanner(
                            icon: Icons.lock_rounded,
                            text: l.locked(_band(l, LightBand.of(lux))),
                          )
                        : StatusBanner(
                            icon: Icons.light_mode_rounded,
                            text: _band(l, LightBand.of(lux)),
                          ),
                    const SizedBox(height: 16),
                    SoftButton(
                      label: viewModel.locked ? l.unlock : l.lock,
                      icon: viewModel.locked
                          ? Icons.lock_rounded
                          : Icons.lock_open_rounded,
                      emphasis: viewModel.locked,
                      onPressed: viewModel.toggleLock,
                    ),
                  ],
                ),
        );
      },
    );
  }
}
