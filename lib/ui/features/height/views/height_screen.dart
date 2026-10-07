import 'package:flutter/material.dart';

import '../../../../domain/height.dart';
import '../../../../domain/ruler.dart';
import '../../../core/controls.dart';
import '../../../core/format.dart';
import '../../../core/help.dart';
import '../../../core/l10n.dart';
import '../../../core/readout.dart';
import '../../../core/theme.dart';
import '../../../core/tool_frame.dart';
import '../view_models/height_view_model.dart';
import 'height_scene.dart';

/// Height & distance: a side view of you, the phone and the object. Aim
/// the phone's top edge at the object's base, then its top; the panel shows
/// the distance, the height and the eye height they're worked out from.
class HeightScreen extends StatelessWidget {
  const HeightScreen({
    super.key,
    required this.viewModel,
    required this.onBack,
  });

  final HeightViewModel viewModel;
  final VoidCallback onBack;

  static ToolHelp _help(AppLocalizations l) => ToolHelp(
    tool: l.toolHeight,
    steps: [l.heightHelp1, l.heightHelp2, l.heightHelp3, l.heightHelp4],
    tip: l.heightTip,
  );

  /// The footer's height: the ground sits just above it.
  static const _footer = 196.0;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, _) {
        final l = context.l10n;
        final vm = viewModel;
        final feet = vm.imperial;
        final distance = vm.distance, height = vm.height, live = vm.live;
        String show(double? m) =>
            m == null ? '—' : formatDistance(m, feet: feet);
        return ToolFrame(
          title: l.toolHeight,
          onBack: onBack,
          trailing: HelpButton(help: _help(l)),
          body: Stack(
            children: [
              Positioned.fill(
                child: ExcludeSemantics(
                  child: HeightScene(
                    live: vm.step == HeightStep.done ? null : live,
                    eyeHeight: vm.eyeHeight,
                    distance: distance,
                    height: height,
                    feet: feet,
                    bottomInset: ToolFrame.sideBySide(context) ? 0 : _footer,
                  ),
                ),
              ),
              Positioned(
                left: 24,
                top: MediaQuery.paddingOf(context).top + 96,
                child: _SightAngle(angle: live, caption: l.sightAngle),
              ),
            ],
          ),
          footer: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              StatPanel(
                [
                  (show(distance), l.distance),
                  (show(height), l.objectHeight),
                  (show(vm.eyeHeight), l.eyeHeight),
                ],
                onTap: [
                  () => _editDistance(context),
                  null,
                  () => _editEyeHeight(context),
                ],
              ),
              const SizedBox(height: 12),
              _status(l),
              const SizedBox(height: 12),
              Row(
                spacing: 14,
                children: [
                  Expanded(
                    child: SoftButton(
                      label: switch (vm.step) {
                        HeightStep.base => l.lockBase,
                        HeightStep.top => l.lockTop,
                        HeightStep.done => l.measureAgain,
                      },
                      icon: vm.step == HeightStep.done
                          ? Icons.replay_rounded
                          : Icons.my_location_rounded,
                      emphasis: true,
                      onPressed: vm.canLock ? vm.lock : null,
                    ),
                  ),
                  SoftIconButton(
                    icon: Icons.restart_alt_rounded,
                    tooltip: l.reset,
                    onPressed: vm.reset,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _status(AppLocalizations l) {
    final vm = viewModel;
    if (vm.step == HeightStep.done) {
      return StatusBanner(
        icon: Icons.check_circle_rounded,
        text: l.heightDone,
        tone: StatusTone.success,
      );
    }
    if (vm.live == null) {
      return StatusBanner(
        icon: Icons.screen_rotation_alt_rounded,
        text: l.heightHoldFlatter,
      );
    }
    return switch (vm.advice) {
      SightAdvice.tooFar => StatusBanner(
        icon: Icons.warning_amber_rounded,
        text: l.heightTooFar,
        tone: StatusTone.warning,
      ),
      SightAdvice.stepBack => StatusBanner(
        icon: Icons.warning_amber_rounded,
        text: l.heightStepBack,
        tone: StatusTone.warning,
      ),
      SightAdvice.ok => StatusBanner(
        icon: Icons.my_location_rounded,
        text: vm.step == HeightStep.base ? l.heightAimBase : l.heightAimTop,
      ),
    };
  }

  /// Feet in, feet out, when the panel shows feet.
  double get _unit => viewModel.imperial ? feetPerMetre : 1;

  Future<void> _editDistance(BuildContext context) async {
    final l = context.l10n;
    final typed = viewModel.knownDistance;
    final result = await _NumberSheet.show(
      context,
      title: l.knownDistance,
      hint: l.knownDistanceHint,
      value: typed == null ? null : typed * _unit,
      unit: viewModel.imperial ? 'ft' : 'm',
      clearable: typed != null,
    );
    if (result == null) return;
    viewModel.setKnownDistance(result.isNaN ? null : result / _unit);
  }

  Future<void> _editEyeHeight(BuildContext context) async {
    final l = context.l10n;
    final result = await _NumberSheet.show(
      context,
      title: l.eyeHeight,
      hint: l.eyeHeightHint,
      value: viewModel.eyeHeight * _unit,
      unit: viewModel.imperial ? 'ft' : 'm',
    );
    if (result == null || result.isNaN) return;
    await viewModel.setEyeHeight(result / _unit);
  }
}

/// The live sight angle on a soft raised disc.
class _SightAngle extends StatelessWidget {
  const _SightAngle({required this.angle, required this.caption});

  final double? angle;
  final String caption;

  @override
  Widget build(BuildContext context) {
    final p = Palette.of(context);
    final value = angle == null ? '—' : '${formatSignedDecimal(angle!)}°';
    return Semantics(
      label: '$caption $value',
      excludeSemantics: true,
      child: Container(
        width: 92,
        height: 92,
        decoration: softSurface(p, radius: BorderRadius.circular(46)),
        padding: const EdgeInsets.all(10),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                value,
                textDirection: TextDirection.ltr,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  fontFeatures: readoutFeatures,
                  color: p.inkStrong,
                ),
              ),
              Text(
                caption,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: p.label,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// A sheet to type a length. Pops the number, NaN for "Clear", or null
/// when cancelled.
class _NumberSheet extends StatefulWidget {
  const _NumberSheet({
    required this.title,
    required this.hint,
    required this.value,
    required this.unit,
    required this.clearable,
  });

  final String title, hint, unit;
  final double? value;
  final bool clearable;

  static Future<double?> show(
    BuildContext context, {
    required String title,
    required String hint,
    required double? value,
    required String unit,
    bool clearable = false,
  }) => showAppSheet<double>(
    context,
    (_) => _NumberSheet(
      title: title,
      hint: hint,
      value: value,
      unit: unit,
      clearable: clearable,
    ),
  );

  @override
  State<_NumberSheet> createState() => _NumberSheetState();
}

class _NumberSheetState extends State<_NumberSheet> {
  late final _text = TextEditingController(
    text: widget.value == null ? '' : formatDecimal(widget.value!),
  );

  @override
  void dispose() {
    _text.dispose();
    super.dispose();
  }

  double? get _parsed {
    final v = parseInches(_text.text);
    return v != null && v > 0 && v < 10000 ? v : null;
  }

  void _save() {
    if (_parsed case final v?) Navigator.of(context).pop(v);
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final p = Palette.of(context);
    return AppSheet(
      title: widget.title,
      action: Row(
        spacing: 14,
        children: [
          Expanded(
            child: widget.clearable
                ? SoftButton(
                    label: l.clear,
                    icon: Icons.close_rounded,
                    onPressed: () => Navigator.of(context).pop(double.nan),
                  )
                : SoftButton(
                    label: l.cancel,
                    icon: Icons.close_rounded,
                    onPressed: () => Navigator.of(context).pop(),
                  ),
          ),
          Expanded(
            child: ListenableBuilder(
              listenable: _text,
              builder: (context, _) => SoftButton(
                label: l.save,
                icon: Icons.check_rounded,
                emphasis: true,
                onPressed: _parsed == null ? null : _save,
              ),
            ),
          ),
        ],
      ),
      children: [
        Text(
          widget.hint,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 15, height: 1.45, color: p.ink),
        ),
        Container(
          height: 56,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          alignment: Alignment.center,
          decoration: insetSurface(p, radius: BorderRadius.circular(28)),
          child: TextField(
            controller: _text,
            autofocus: true,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            textInputAction: TextInputAction.done,
            textAlign: TextAlign.center,
            onSubmitted: (_) => _save(),
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              fontFeatures: readoutFeatures,
              color: p.inkStrong,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              isCollapsed: true,
              suffixText: widget.unit,
              suffixStyle: TextStyle(fontSize: 16, color: p.label),
            ),
          ),
        ),
      ],
    );
  }
}
