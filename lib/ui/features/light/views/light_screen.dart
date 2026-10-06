import 'package:flutter/material.dart';

import '../../../../domain/light.dart';
import '../../../core/controls.dart';
import '../../../core/format.dart';
import '../../../core/help.dart';
import '../../../core/l10n.dart';
import '../../../core/readout.dart';
import '../../../core/tool_frame.dart';
import '../view_models/light_view_model.dart';
import 'light_sky.dart';

/// Light meter: a sky that follows the light (night when dark, the sun
/// high in sunlight), lux and foot-candles, and what the light is good for.
class LightScreen extends StatelessWidget {
  const LightScreen({super.key, required this.viewModel, required this.onBack});

  final LightViewModel viewModel;
  final VoidCallback onBack;

  static ToolHelp _help(AppLocalizations l) => ToolHelp(
    tool: l.toolLight,
    steps: [l.lightHelp1, l.lightHelp2, l.lightHelp3, l.lightHelp4],
    tip: l.lightTip,
  );

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
        final band = lux == null ? null : _band(l, LightBand.of(lux));
        return ToolFrame(
          title: l.toolLight,
          onBack: onBack,
          trailing: HelpButton(help: _help(l)),
          // A night sky behind the header: light title and status bar.
          headerOnDark:
              lux != null &&
              skyLevel(lux) < 0.45 &&
              !ToolFrame.sideBySide(context),
          body: SensorStateGate(
            state: r.state,
            ready: lux != null,
            missingText: l.noLightSensor,
            child: lux == null
                ? const SizedBox.shrink()
                : LightSky(
                    lux: lux,
                    value: formatLux(lux),
                    footCandles: '${formatLux(r.footCandles!)} fc',
                    semanticsLabel: l.lightSemantics(formatLux(lux)),
                    bottomInset: ToolFrame.sideBySide(context) ? 0 : 120,
                  ),
          ),
          footer: band == null
              ? null
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    StatusBanner(
                      icon: viewModel.locked
                          ? Icons.lock_rounded
                          : Icons.light_mode_rounded,
                      text: viewModel.locked ? l.locked(band) : band,
                    ),
                    const SizedBox(height: 16),
                    LockButton(
                      locked: viewModel.locked,
                      onPressed: viewModel.toggleLock,
                      wide: true,
                    ),
                  ],
                ),
        );
      },
    );
  }
}
