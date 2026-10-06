import 'package:flutter/material.dart';

import '../../../../domain/sound.dart';
import '../../../core/controls.dart';
import '../../../core/dial.dart';
import '../../../core/format.dart';
import '../../../core/help.dart';
import '../../../core/l10n.dart';
import '../../../core/readout.dart';
import '../../../core/theme.dart';
import '../../../core/tool_frame.dart';
import '../view_models/sound_view_model.dart';
import 'sound_ripples.dart';

/// Sound meter: the level spreading like ripples on water, average and
/// maximum, and what the level means for hearing. Asks for the microphone only after
/// saying why, and that nothing is recorded.
class SoundScreen extends StatelessWidget {
  const SoundScreen({super.key, required this.viewModel, required this.onBack});

  final SoundViewModel viewModel;
  final VoidCallback onBack;

  static ToolHelp _help(AppLocalizations l) => ToolHelp(
    tool: l.toolSound,
    steps: [
      l.soundHelp1,
      l.soundHelp2,
      l.soundHelp3,
      l.soundHelp4,
      l.soundHelp5,
    ],
    tip: l.soundTip,
  );

  static String _band(AppLocalizations l, SoundBand band) => switch (band) {
    SoundBand.veryQuiet => l.soundVeryQuiet,
    SoundBand.quiet => l.soundQuiet,
    SoundBand.moderate => l.soundModerate,
    SoundBand.loud => l.soundLoud,
    SoundBand.veryLoud => l.soundVeryLoud,
    SoundBand.dangerous => l.soundDangerous,
  };

  /// The bands by level (dB): green while quiet, yellow for a
  /// conversation, orange once loud, red where hearing is at risk, crimson
  /// when dangerous.
  static List<DialZone> _zones(Palette p) => [
    (from: 0, color: p.gaugeSafe),
    (from: moderateDb, color: p.gaugeModerate),
    (from: loudDb, color: p.gaugeCaution),
    (from: harmfulDb, color: p.gaugeDanger),
    (from: dangerousDb, color: p.gaugeExtreme),
  ];

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, _) {
        final l = context.l10n;
        final granted = viewModel.access == MicAccess.granted;
        final r = viewModel.reading;
        final db = r.level;
        return ToolFrame(
          title: l.toolSound,
          onBack: onBack,
          trailing: HelpButton(help: _help(l)),
          bodyBottomInset: granted ? 205 : 0,
          body: switch (viewModel.access) {
            MicAccess.checking => const SizedBox.shrink(),
            MicAccess.needed => _Permission(
              title: l.micTitle,
              body: l.micBody,
              actions: [
                SoftButton(
                  label: l.micAllow,
                  icon: Icons.mic_rounded,
                  emphasis: true,
                  onPressed: viewModel.allow,
                ),
              ],
            ),
            MicAccess.denied => _Permission(
              title: l.micDeniedTitle,
              body: l.micDeniedBody,
              actions: [
                SoftButton(
                  label: l.openSettings,
                  icon: Icons.settings_rounded,
                  emphasis: true,
                  onPressed: viewModel.openSettings,
                ),
                SoftButton(
                  label: l.tryAgain,
                  icon: Icons.refresh_rounded,
                  onPressed: viewModel.allow,
                ),
              ],
            ),
            MicAccess.granted => SensorStateGate(
              state: r.state,
              ready: db != null,
              missingText: l.noMicrophone,
              child: db == null
                  ? const SizedBox.shrink()
                  : SoundRipples(
                      level: db,
                      history: r.history,
                      zones: _zones(Palette.of(context)),
                      value: formatDb(db),
                      unit: l.decibelsApprox,
                      semanticsLabel: l.soundSemantics(formatDb(db)),
                      animate: !viewModel.locked,
                    ),
            ),
          },
          footer: !granted || db == null ? null : _footer(context, r, db),
        );
      },
    );
  }

  Widget _footer(BuildContext context, SoundReading r, double db) {
    final l = context.l10n;
    final band = viewModel.band ?? SoundBand.of(db);
    final text = _band(l, band);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ValueTiles([
          ('${formatDb(r.average!)} dB', l.average),
          ('${formatDb(r.max!)} dB', l.soundMax),
        ]),
        const SizedBox(height: 16),
        StatusBanner(
          icon: viewModel.locked
              ? Icons.lock_rounded
              : band.harmful
              ? Icons.hearing_disabled_rounded
              : Icons.graphic_eq_rounded,
          text: viewModel.locked ? l.locked(text) : text,
          tone: band.harmful
              ? StatusTone.danger
              : band == SoundBand.loud
              ? StatusTone.warning
              : StatusTone.neutral,
        ),
        const SizedBox(height: 16),
        Row(
          spacing: 14,
          children: [
            Expanded(
              child: SoftButton(
                label: l.reset,
                icon: Icons.restart_alt_rounded,
                onPressed: viewModel.locked ? null : viewModel.reset,
              ),
            ),
            LockButton(
              locked: viewModel.locked,
              onPressed: viewModel.toggleLock,
            ),
          ],
        ),
      ],
    );
  }
}

/// Why the microphone is needed (and that nothing is recorded), with the
/// way forward.
class _Permission extends StatelessWidget {
  const _Permission({
    required this.title,
    required this.body,
    required this.actions,
  });

  final String title, body;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    final p = Palette.of(context);
    final top = ToolFrame.sideBySide(context)
        ? 0.0
        : ToolFrame.contentTop(context);
    return SafeArea(
      top: false,
      child: Padding(
        padding: EdgeInsets.fromLTRB(28, top, 28, 24),
        child: Center(
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 84,
                    height: 84,
                    decoration: softSurface(
                      p,
                      radius: BorderRadius.circular(42),
                    ),
                    child: Icon(Icons.mic_rounded, size: 40, color: p.ballDark),
                  ),
                  const SizedBox(height: 22),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: p.inkStrong,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    body,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 15, height: 1.45, color: p.ink),
                  ),
                  const SizedBox(height: 24),
                  for (final (i, a) in actions.indexed) ...[
                    if (i > 0) const SizedBox(height: 12),
                    a,
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
