import 'package:flutter/material.dart';

import '../../../../domain/ruler.dart';
import '../../../core/controls.dart';
import '../../../core/format.dart';
import '../../../core/help.dart';
import '../../../core/l10n.dart';
import '../../../core/readout.dart';
import '../../../core/soft_switch.dart';
import '../../../core/theme.dart';
import '../../../core/tool_frame.dart';
import '../view_models/ruler_view_model.dart';

/// Ruler: millimetres down one edge and inches down the other, two orange
/// lines dragged to an object's ends, and the length between them.
class RulerScreen extends StatelessWidget {
  const RulerScreen({super.key, required this.viewModel, required this.onBack});

  final RulerViewModel viewModel;
  final VoidCallback onBack;

  static ToolHelp _help(AppLocalizations l) => ToolHelp(
    tool: l.toolRuler,
    steps: [l.rulerHelp1, l.rulerHelp2, l.rulerHelp3, l.rulerHelp4],
    tip: l.rulerTip,
  );

  /// Space between the ruler's zero and the start of its area.
  static const _inset = 8.0;

  @override
  Widget build(BuildContext context) {
    final view = View.of(context);
    final dpr = view.devicePixelRatio;
    final display = view.display.size;
    // The panel's own size, orientation-free (the window can be smaller).
    final physical = display.isEmpty ? view.physicalSize : display;
    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, _) {
        final scale = viewModel.scaleFor(dpr, physical);
        return ToolFrame(
          title: context.l10n.toolRuler,
          onBack: onBack,
          trailing: HelpButton(help: _help(context.l10n)),
          bodyBottomInset: 150,
          footerBelowInLandscape: true,
          body: _body(context, scale, dpr),
          footer: viewModel.calibrating
              ? _calibrationFooter(context, dpr, physical)
              : _footer(context, scale, dpr, physical),
        );
      },
    );
  }

  Widget _body(BuildContext context, ScreenScale scale, double dpr) {
    final top = ToolFrame.sideBySide(context)
        ? 0.0
        : MediaQuery.paddingOf(context).top + ToolFrame.headerHeight;
    return Padding(
      padding: EdgeInsets.only(top: top + _inset, bottom: _inset),
      // A physical instrument: never mirrored for right-to-left languages.
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: LayoutBuilder(
          builder: (context, box) {
            final vertical = box.maxHeight >= box.maxWidth;
            final length = vertical ? box.maxHeight : box.maxWidth;
            final maxMm = scale.mm(length, dpr);
            viewModel.setRulerLength(maxMm);
            double along(Offset p) => vertical ? p.dy : p.dx;
            double mmAt(Offset p) => scale.mm(along(p), dpr);
            final aligning = viewModel.calibrating;
            final referenceMm = viewModel.referenceMm;
            final l = context.l10n;
            final mm = viewModel.lengthMm;
            final unit = _unit(context);
            return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onPanStart: (d) => aligning
                  ? viewModel.dragReference(along(d.localPosition), length)
                  : viewModel.beginDrag(mmAt(d.localPosition), maxMm),
              onPanUpdate: (d) => aligning
                  ? viewModel.dragReference(along(d.localPosition), length)
                  : viewModel.dragTo(mmAt(d.localPosition), maxMm),
              onTapUp: (d) => aligning
                  ? viewModel.dragReference(along(d.localPosition), length)
                  : viewModel.beginDrag(mmAt(d.localPosition), maxMm),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Semantics(
                      // Its own node: the length, read as one phrase.
                      container: true,
                      label: aligning
                          ? null
                          : l.rulerSemantics(
                              formatDecimal(mm),
                              formatDecimal(mm / mmPerInch, digits: 2),
                            ),
                      child: CustomPaint(
                        painter: _RulerPainter(
                          palette: Palette.of(context),
                          scale: scale,
                          dpr: dpr,
                          vertical: vertical,
                          ends: [
                            viewModel.shown(0, maxMm),
                            viewModel.shown(1, maxMm),
                          ],
                          referenceSpan: aligning
                              ? viewModel.referenceSpan
                              : null,
                          card: viewModel.method == CalibrationMethod.card,
                          cardMm: referenceMm,
                        ),
                      ),
                    ),
                  ),
                  // In landscape the ruler is short: its reading and unit
                  // switch sit in the footer instead, so nothing covers it.
                  if (!ToolFrame.sideBySide(context))
                    Center(
                      // Shrinks rather than overflows in a very short window.
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: aligning
                            ? _Reading(
                                main: viewModel.method == CalibrationMethod.card
                                    ? '${formatDecimal(referenceMm, digits: 2)} mm'
                                    : _mark(
                                        referenceMm,
                                        inches: viewModel.inches,
                                      ),
                              )
                            : Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  _reading(mm, unit),
                                  const SizedBox(height: 14),
                                  _unitSwitch(context, unit),
                                ],
                              ),
                      ),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  /// The reading's unit: the user's pick, else by region.
  LengthUnit _unit(BuildContext context) =>
      viewModel.unit ??
      (_usesInches(context) ? LengthUnit.inch : LengthUnit.mm);

  /// The length in [unit], big, with the other system small.
  static Widget _reading(double mm, LengthUnit unit, {bool inline = false}) =>
      _Reading(
        main: formatLength(mm, unit),
        sub: formatLength(
          mm,
          unit == LengthUnit.inch ? LengthUnit.mm : LengthUnit.inch,
        ),
        inline: inline,
      );

  Widget _unitSwitch(BuildContext context, LengthUnit unit) {
    final l = context.l10n;
    return SoftSwitch<LengthUnit>(
      value: unit,
      onChanged: viewModel.setUnit,
      options: [
        SoftSwitchOption(
          value: LengthUnit.mm,
          label: 'mm',
          tooltip: l.unitMillimetres,
        ),
        SoftSwitchOption(
          value: LengthUnit.cm,
          label: 'cm',
          tooltip: l.unitCentimetres,
        ),
        SoftSwitchOption(
          value: LengthUnit.inch,
          label: 'in',
          tooltip: l.unitInches,
        ),
      ],
    );
  }

  /// A ruler mark as printed: "10 cm" or "4 in".
  static String _mark(double mm, {required bool inches}) =>
      inches ? '${(mm / mmPerInch).round()} in' : '${(mm / 10).round()} cm';

  /// A typed screen size shown back: "6.1", or "6.27" when it had two
  /// decimals.
  static String _inches(double v) {
    final tenths = (v * 10).roundToDouble() / 10;
    return formatDecimal(v, digits: (v - tenths).abs() < 0.005 ? 1 : 2);
  }

  /// Rulers in the US are read in inches.
  static bool _usesInches(BuildContext context) => const {
    'US',
    'LR',
    'MM',
  }.contains(View.of(context).platformDispatcher.locale.countryCode);

  /// Offers the ways to calibrate (and to forget a calibration), then
  /// starts the one picked.
  Future<void> _chooseMethod(
    BuildContext context,
    ScreenScale scale,
    double dpr,
    Size physical,
  ) async {
    final l = context.l10n;
    final inches = _usesInches(context);
    final fits = viewModel.referenceFits;
    void align(CalibrationMethod method) => viewModel.startCalibration(
      method,
      scale: scale,
      dpr: dpr,
      inches: inches,
    );
    final action = await showOptionsSheet<VoidCallback>(
      context,
      title: l.calibrateHow,
      options: [
        (
          value: () => align(CalibrationMethod.card),
          icon: Icons.credit_card_rounded,
          title: l.methodCard,
          subtitle: fits ? l.methodCardInfo : l.rotateToCalibrate,
          enabled: fits,
        ),
        (
          value: () => align(CalibrationMethod.ruler),
          icon: Icons.straighten_rounded,
          title: l.methodRuler,
          subtitle: fits ? l.methodRulerInfo : l.rotateToCalibrate,
          enabled: fits,
        ),
        (
          value: () => showAppSheet<void>(
            context,
            (_) => _ScreenSizeSheet(
              viewModel: viewModel,
              dpr: dpr,
              physical: physical,
            ),
          ),
          icon: Icons.smartphone_rounded,
          title: l.methodScreen,
          subtitle: l.methodScreenInfo,
          enabled: true,
        ),
        if (viewModel.savedMethod(physical) != null)
          (
            value: () => viewModel.usePhoneDefault(physical),
            icon: Icons.restart_alt_rounded,
            title: l.usePhoneDefault,
            subtitle: l.usePhoneDefaultInfo,
            enabled: true,
          ),
      ],
    );
    if (context.mounted) action?.call();
  }

  Widget _footer(
    BuildContext context,
    ScreenScale scale,
    double dpr,
    Size physical,
  ) {
    final l = context.l10n;
    final (icon, text, tone) = switch (scale.source) {
      ScaleSource.calibrated => (
        Icons.verified_rounded,
        switch (viewModel.savedMethod(physical)) {
          CalibrationMethod.ruler => l.rulerCalibratedRuler,
          CalibrationMethod.screenSize => l.rulerCalibratedScreen(
            _inches(
              diagonalInches(scale.pxPerMm, physical.width, physical.height),
            ),
          ),
          _ => l.rulerCalibrated,
        },
        StatusTone.neutral,
      ),
      ScaleSource.reported => (
        Icons.straighten_rounded,
        l.rulerReported,
        StatusTone.neutral,
      ),
      ScaleSource.estimated => (
        Icons.warning_amber_rounded,
        l.rulerEstimated,
        StatusTone.warning,
      ),
    };
    final message = viewModel.locked
        ? StatusBanner(icon: Icons.lock_rounded, text: l.handlesLocked)
        : StatusBanner(icon: icon, text: text, tone: tone);
    final calibrate = SoftButton(
      label: l.calibrateCard,
      icon: Icons.tune_rounded,
      emphasis: scale.source == ScaleSource.estimated,
      onPressed: viewModel.locked
          ? null
          : () => _chooseMethod(context, scale, dpr, physical),
    );
    final lock = SoftIconButton(
      icon: viewModel.locked ? Icons.lock_rounded : Icons.lock_open_rounded,
      tooltip: viewModel.locked ? l.unlock : l.lockHandles,
      active: viewModel.locked,
      onPressed: viewModel.toggleLock,
    );
    if (!ToolFrame.sideBySide(context)) {
      return _arrange(
        context,
        gap: 16,
        message: message,
        buttons: [(calibrate, true), (lock, false)],
      );
    }
    // Landscape, under the full-width ruler: what you read on top (the
    // length and its status), everything you tap below.
    final unit = _unit(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          // Any space the reading doesn't need goes between, so the status
          // ends flush with Calibrate and the lock below.
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          spacing: 14,
          children: [
            // Both shrink rather than overflow in a narrow window.
            Flexible(
              flex: 2,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: _reading(viewModel.lengthMm, unit, inline: true),
              ),
            ),
            Expanded(
              flex: 3,
              child: Align(
                alignment: AlignmentDirectional.centerEnd,
                child: message,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          spacing: 14,
          children: [
            Expanded(
              child: Align(
                alignment: AlignmentDirectional.centerStart,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: _unitSwitch(context, unit),
                ),
              ),
            ),
            SizedBox(width: 140, child: calibrate),
            lock,
          ],
        ),
      ],
    );
  }

  /// The footer: [message] above its [buttons] in portrait, beside them in
  /// landscape (where the ruler takes the full width above). A button
  /// marked `true` widens to share the portrait row.
  Widget _arrange(
    BuildContext context, {
    required Widget message,
    required List<(Widget, bool)> buttons,
    double gap = 14,
  }) {
    if (ToolFrame.sideBySide(context)) {
      return Row(
        spacing: 14,
        children: [
          Expanded(child: message),
          for (final (button, wide) in buttons)
            wide ? SizedBox(width: 140, child: button) : button,
        ],
      );
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        message,
        SizedBox(height: gap),
        Row(
          spacing: 14,
          children: [
            for (final (button, wide) in buttons)
              wide ? Expanded(child: button) : button,
          ],
        ),
      ],
    );
  }

  Widget _calibrationFooter(BuildContext context, double dpr, Size physical) {
    final l = context.l10n;
    final p = Palette.of(context);
    final card = viewModel.method == CalibrationMethod.card;
    final mark = _mark(viewModel.referenceMm, inches: viewModel.inches);
    return _arrange(
      context,
      message: !viewModel.referenceFits
          ? StatusBanner(
              icon: Icons.screen_rotation_rounded,
              text: l.rotateToCalibrate,
              tone: StatusTone.warning,
            )
          : viewModel.calibrationFailed
          ? StatusBanner(
              icon: Icons.warning_amber_rounded,
              text: card ? l.cardMismatch : l.rulerMismatch(mark),
              tone: StatusTone.warning,
            )
          : Text(
              !card
                  ? l.rulerInstructions(mark)
                  : viewModel.referenceMm == cardShortMm
                  ? l.cardShortEdge
                  : l.cardLongEdge,
              textAlign: ToolFrame.sideBySide(context)
                  ? TextAlign.start
                  : TextAlign.center,
              style: TextStyle(fontSize: 14, height: 1.4, color: p.ink),
            ),
      buttons: [
        (
          SoftButton(
            label: l.cancel,
            icon: Icons.close_rounded,
            onPressed: viewModel.cancelCalibration,
          ),
          true,
        ),
        (
          SoftButton(
            label: l.save,
            icon: Icons.check_rounded,
            emphasis: true,
            onPressed: !viewModel.referenceFits
                ? null
                : () => viewModel.saveAlignment(dpr: dpr, physical: physical),
          ),
          true,
        ),
      ],
    );
  }
}

/// The screen size typed in inches, in its own sheet so the keyboard
/// doesn't squeeze the ruler.
class _ScreenSizeSheet extends StatefulWidget {
  const _ScreenSizeSheet({
    required this.viewModel,
    required this.dpr,
    required this.physical,
  });

  final RulerViewModel viewModel;
  final double dpr;
  final Size physical;

  @override
  State<_ScreenSizeSheet> createState() => _ScreenSizeSheetState();
}

class _ScreenSizeSheetState extends State<_ScreenSizeSheet> {
  final _text = TextEditingController();
  bool _failed = false;

  @override
  void dispose() {
    _text.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final ok = await widget.viewModel.saveScreenSize(
      _text.text,
      dpr: widget.dpr,
      physical: widget.physical,
    );
    if (!mounted) return;
    if (ok) {
      Navigator.of(context).pop();
    } else {
      setState(() => _failed = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final p = Palette.of(context);
    return AppSheet(
      title: l.methodScreen,
      action: Row(
        spacing: 14,
        children: [
          Expanded(
            child: SoftButton(
              label: l.cancel,
              icon: Icons.close_rounded,
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          Expanded(
            child: SoftButton(
              label: l.save,
              icon: Icons.check_rounded,
              emphasis: true,
              onPressed: _save,
            ),
          ),
        ],
      ),
      children: [
        if (_failed)
          StatusBanner(
            icon: Icons.warning_amber_rounded,
            text: l.screenSizeMismatch,
            tone: StatusTone.warning,
          )
        else
          Text(
            l.screenSizeInstructions,
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
            onChanged: (_) {
              if (_failed) setState(() => _failed = false);
            },
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
              hintText: formatDecimal(6.1),
              hintStyle: TextStyle(color: p.label),
              suffixText: 'in',
              suffixStyle: TextStyle(fontSize: 16, color: p.label),
            ),
          ),
        ),
      ],
    );
  }
}

/// The length between the lines: big millimetres, small inches.
class _Reading extends StatelessWidget {
  const _Reading({required this.main, this.sub, this.inline = false});

  final String main;
  final String? sub;

  /// On one line (landscape footer) rather than stacked.
  final bool inline;

  @override
  Widget build(BuildContext context) {
    final p = Palette.of(context);
    // The ruler's label already says it; read it once.
    return IgnorePointer(
      child: ExcludeSemantics(
        child: Flex(
          direction: inline ? Axis.horizontal : Axis.vertical,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: inline
              ? CrossAxisAlignment.baseline
              : CrossAxisAlignment.center,
          textBaseline: TextBaseline.alphabetic,
          spacing: inline ? 14 : 0,
          children: [
            Text(
              main,
              textDirection: TextDirection.ltr,
              textScaler: TextScaler.noScaling,
              style: TextStyle(
                fontSize: inline ? 32 : 40,
                fontWeight: FontWeight.w700,
                fontFeatures: readoutFeatures,
                color: p.inkStrong,
              ),
            ),
            if (sub != null)
              Text(
                sub!,
                textDirection: TextDirection.ltr,
                textScaler: TextScaler.noScaling,
                style: TextStyle(
                  fontSize: 18,
                  fontFeatures: readoutFeatures,
                  color: p.label,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _RulerPainter extends CustomPainter {
  _RulerPainter({
    required this.palette,
    required this.scale,
    required this.dpr,
    required this.vertical,
    required this.ends,
    required this.referenceSpan,
    required this.card,
    required this.cardMm,
  });

  final Palette palette;
  final ScreenScale scale;
  final double dpr;
  final bool vertical;
  final List<double> ends;

  /// Where the line being aligned is, or null when measuring.
  final double? referenceSpan;

  /// Whether that's a card, drawn as its outline.
  final bool card;
  final double cardMm;

  @override
  void paint(Canvas canvas, Size size) {
    final p = palette;
    final length = vertical ? size.height : size.width;
    final across = vertical ? size.width : size.height;
    Offset at(double along, double a) =>
        vertical ? Offset(a, along) : Offset(along, a);
    double pos(double mm) => scale.logical(mm, dpr);

    final minor = Paint()
      ..strokeWidth = 1
      ..color = p.tickMinor;
    final major = Paint()
      ..strokeWidth = 1.4
      ..color = p.tickMajor;

    // Millimetres along the start edge, numbered every centimetre.
    for (var mm = 0; pos(mm.toDouble()) <= length; mm++) {
      final x = pos(mm.toDouble());
      final len = mm % 10 == 0
          ? 26.0
          : mm % 5 == 0
          ? 17.0
          : 10.0;
      canvas.drawLine(at(x, 0), at(x, len), mm % 5 == 0 ? major : minor);
      if (mm % 10 == 0 && mm > 0) {
        _label(canvas, '${mm ~/ 10}', at(x, 36), p.ink);
      }
    }
    // Inches along the other edge, in eighths.
    final eighth = mmPerInch / 8;
    for (var i = 0; pos(i * eighth) <= length; i++) {
      final x = pos(i * eighth);
      final len = i % 8 == 0
          ? 26.0
          : i % 4 == 0
          ? 19.0
          : i.isEven
          ? 13.0
          : 8.0;
      canvas.drawLine(
        at(x, across),
        at(x, across - len),
        i % 4 == 0 ? major : minor,
      );
      if (i % 8 == 0 && i > 0) {
        _label(canvas, '${i ~/ 8}', at(x, across - 36), p.ink);
      }
    }

    final reference = referenceSpan;
    if (reference != null) {
      _reference(canvas, reference, across, at);
      return;
    }

    // The span between the lines, then the lines with their handles.
    final a = pos(ends[0]), b = pos(ends[1]);
    final span = Path()
      ..addPolygon([at(a, 0), at(b, 0), at(b, across), at(a, across)], true);
    canvas.drawPath(span, Paint()..color = p.ballDark.withValues(alpha: 0.07));
    for (final x in [a, b]) {
      _line(canvas, x, across, at);
    }
  }

  void _line(
    Canvas canvas,
    double x,
    double across,
    Offset Function(double, double) at,
  ) {
    final p = palette;
    canvas.drawLine(
      at(x, 0),
      at(x, across),
      Paint()
        ..strokeWidth = 2
        ..color = p.ballDark,
    );
    final ball = at(x, across * 0.78);
    canvas
      ..drawCircle(
        ball + const Offset(1, 2),
        11,
        Paint()
          ..color = p.ballDark.withValues(alpha: 0.3)
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4),
      )
      ..drawCircle(
        ball,
        11,
        Paint()
          ..shader = RadialGradient(
            center: const Alignment(-0.2, -0.3),
            colors: [p.ballLight, p.ballDark],
          ).createShader(Rect.fromCircle(center: ball, radius: 11)),
      );
  }

  /// The dark zero line, the movable line at [span] and, for a card, its
  /// outline between them.
  void _reference(
    Canvas canvas,
    double span,
    double across,
    Offset Function(double, double) at,
  ) {
    final p = palette;
    if (card) {
      final r = Rect.fromPoints(at(0, across * 0.18), at(span, across * 0.82));
      canvas.drawRRect(
        RRect.fromRectAndRadius(r, Radius.circular(scale.logical(3.18, dpr))),
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.5
          ..color = p.ink.withValues(alpha: 0.5),
      );
    }
    canvas.drawLine(
      at(0, 0),
      at(0, across),
      Paint()
        ..strokeWidth = 2
        ..color = p.ink,
    );
    _line(canvas, span, across, at);
  }

  void _label(Canvas canvas, String text, Offset centre, Color color) {
    final tp = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          fontFeatures: readoutFeatures,
          color: color,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(canvas, centre - Offset(tp.width / 2, tp.height / 2));
  }

  @override
  bool shouldRepaint(_RulerPainter old) =>
      old.scale != scale ||
      old.dpr != dpr ||
      old.vertical != vertical ||
      old.ends[0] != ends[0] ||
      old.ends[1] != ends[1] ||
      old.referenceSpan != referenceSpan ||
      old.card != card ||
      old.cardMm != cardMm ||
      old.palette != palette;
}
