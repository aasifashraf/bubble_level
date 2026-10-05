import 'package:flutter/material.dart';

import '../../../../data/repositories/settings_repository.dart';
import '../../../core/controls.dart';
import '../../../core/dial.dart';
import '../../../core/format.dart';
import '../../../core/help.dart';
import '../../../core/l10n.dart';
import '../../../core/readout.dart';
import '../../../core/soft_switch.dart';
import '../../../core/theme.dart';
import '../../../core/tool_frame.dart';
import '../view_models/angle_view_model.dart';

/// Angle from the Earth, or — after "Set zero" — how far the phone has
/// moved from a starting position; the compass design with an arc.
class AngleScreen extends StatelessWidget {
  const AngleScreen({super.key, required this.viewModel, required this.onBack});

  final AngleViewModel viewModel;
  final VoidCallback onBack;

  static ToolHelp _help(AppLocalizations l) => ToolHelp(
    tool: l.toolAngle,
    steps: [
      l.angleHelp1,
      l.angleHelp2,
      l.angleHelp3,
      l.angleHelp4,
      l.angleHelp5,
      l.angleHelp6,
    ],
    tip: l.angleTip,
  );

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, _) {
        final state = viewModel.state;
        final degrees = state == null
            ? 0.0
            : state.moved ?? state.longEdge ?? state.tilt;
        final value = formatDegrees(degrees);
        final zeroed = state?.zeroed ?? false;
        final onEdge = !zeroed && (state?.onEdge ?? false);
        final needsEdge = !zeroed && viewModel.needsEdge;
        return ToolFrame(
          title: context.l10n.toolAngle,
          onBack: onBack,
          trailing: HelpButton(help: _help(context.l10n)),
          body: _withModeSwitch(
            context,
            SensorGate(
              reading: viewModel.reading,
              child: state == null
                  ? const SizedBox.shrink()
                  : InstrumentDial(
                      value: needsEdge ? '—' : value,
                      semanticsLabel: zeroed
                          ? context.l10n.movedFromZero(value)
                          : onEdge
                          ? context.l10n.edgeAngleSemantics(
                              value,
                              formatDegrees(state.shortEdge!),
                            )
                          : context.l10n.fromLevel(value),
                      arcSweep: needsEdge ? 0 : degrees,
                      ballAngle: needsEdge ? null : degrees,
                      reserved: 300,
                    ),
            ),
          ),
          footer: state == null
              ? null
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Landscape: the mode switch heads the controls column.
                    if (ToolFrame.sideBySide(context)) ...[
                      _modeSwitch(context),
                      const SizedBox(height: 16),
                    ],
                    _status(context, zeroed, onEdge, needsEdge),
                    if (onEdge)
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text(
                          context.l10n.shortEdge(
                            formatDegrees(state.shortEdge!),
                          ),
                          style: TextStyle(
                            fontSize: 14,
                            color: Palette.of(context).label,
                          ),
                        ),
                      ),
                    const SizedBox(height: 16),
                    Row(
                      spacing: 14,
                      children: [
                        Expanded(
                          child: zeroed
                              ? SoftButton(
                                  label: context.l10n.clearZero,
                                  icon: Icons.close_rounded,
                                  onPressed: viewModel.clearZero,
                                )
                              : SoftButton(
                                  label: context.l10n.setZeroHere,
                                  icon: Icons.adjust_rounded,
                                  onPressed: viewModel.setZero,
                                  emphasis: true,
                                ),
                        ),
                        // Freezes the reading to read it after lifting the
                        // phone off what it measured.
                        LockButton(
                          locked: viewModel.locked,
                          onPressed: viewModel.toggleLock,
                        ),
                      ],
                    ),
                  ],
                ),
        );
      },
    );
  }

  /// Portrait: the mode switch under the header, top right (as the Level's
  /// view switch). Landscape: it moves to the controls column.
  Widget _withModeSwitch(BuildContext context, Widget instrument) {
    if (ToolFrame.sideBySide(context)) return instrument;
    final top = ToolFrame.contentTop(context);
    return Stack(
      children: [
        Positioned.fill(child: instrument),
        PositionedDirectional(
          top: top + 4,
          end: 20,
          child: _modeSwitch(context),
        ),
      ],
    );
  }

  static Widget _glyph(Color color, {required bool flat}) => CustomPaint(
    painter: _PhoneGlyph(color: color, flat: flat),
  );

  Widget _modeSwitch(BuildContext context) {
    final l = context.l10n;
    return SoftSwitch<AngleMode>(
      value: viewModel.mode,
      onChanged: viewModel.setMode,
      options: [
        SoftSwitchOption(
          value: AngleMode.auto,
          icon: Icons.auto_mode_rounded,
          tooltip: l.angleModeAuto,
        ),
        SoftSwitchOption(
          value: AngleMode.flat,
          glyph: (c) => _glyph(c, flat: true),
          tooltip: l.angleModeFlat,
        ),
        SoftSwitchOption(
          value: AngleMode.edge,
          glyph: (c) => _glyph(c, flat: false),
          tooltip: l.angleModeEdge,
        ),
      ],
    );
  }

  Widget _status(
    BuildContext context,
    bool zeroed,
    bool onEdge,
    bool needsEdge,
  ) {
    final l = context.l10n;
    if (needsEdge) {
      return StatusBanner(
        glyph: (c) => _glyph(c, flat: false),
        text: l.standOnEdge,
        tone: StatusTone.warning,
      );
    }
    final text = zeroed
        ? l.measuringFromZero
        : onEdge
        ? l.longEdgeFromLevel
        : l.angleFlatStatus;
    if (viewModel.locked) {
      return StatusBanner(icon: Icons.lock_rounded, text: l.locked(text));
    }
    // The mode's own phone glyph, as on the switch above.
    return StatusBanner(
      icon: zeroed ? Icons.adjust_rounded : null,
      glyph: zeroed ? null : (c) => _glyph(c, flat: !onEdge),
      text: text,
    );
  }
}

/// A phone with the bubble its mode uses, for the mode switch: portrait
/// with a round bubble for flat (as the Level's dial), landscape on a
/// ground line with a tube bubble for on-edge (as the Level's tube). Front
/// views, like every common phone icon; the bubble tells the mode.
class _PhoneGlyph extends CustomPainter {
  const _PhoneGlyph({required this.color, required this.flat});

  final Color color;
  final bool flat;

  @override
  void paint(Canvas canvas, Size size) {
    canvas
      ..save()
      ..scale(size.width / 24, size.height / 24);
    final stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.7
      ..strokeCap = StrokeCap.round
      ..color = color;
    final fill = Paint()..color = color;
    if (flat) {
      // Portrait phone; on its screen a round bubble with a dot.
      canvas
        ..drawRRect(
          RRect.fromLTRBR(6, 2, 18, 22, const Radius.circular(2.6)),
          stroke,
        )
        ..drawCircle(const Offset(12, 12), 3.6, stroke..strokeWidth = 1.4)
        ..drawCircle(const Offset(12, 12), 1.3, fill);
    } else {
      // Landscape phone standing on the ground; on its screen a tube
      // bubble.
      canvas
        ..drawRRect(
          RRect.fromLTRBR(2, 6, 22, 17.5, const Radius.circular(2.6)),
          stroke,
        )
        ..drawRRect(
          RRect.fromLTRBR(6.5, 10, 17.5, 13.5, const Radius.circular(1.75)),
          stroke..strokeWidth = 1.4,
        )
        ..drawCircle(const Offset(12, 11.75), 1.1, fill)
        ..drawLine(
          const Offset(1, 21),
          const Offset(23, 21),
          stroke..strokeWidth = 1.7,
        );
    }
    canvas.restore();
  }

  @override
  bool shouldRepaint(_PhoneGlyph old) => old.color != color || old.flat != flat;
}
