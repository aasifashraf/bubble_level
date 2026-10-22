import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
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
/// lines dragged to an object's ends, and the length between them. With
/// width on, two more lines across the ruler give the width and area.
class RulerScreen extends StatelessWidget {
  const RulerScreen({super.key, required this.viewModel, required this.onBack});

  final RulerViewModel viewModel;
  final VoidCallback onBack;

  static ToolHelp _help(AppLocalizations l) => ToolHelp(
    tool: l.toolRuler,
    steps: [
      l.rulerHelp1,
      l.rulerHelp2,
      l.rulerHelp5,
      l.rulerHelp3,
      l.rulerHelp4,
    ],
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
          action: viewModel.calibrating
              ? null
              : _WidthButton(
                  on: viewModel.width,
                  onPressed: viewModel.toggleWidth,
                ),
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
        : ToolFrame.contentTop(context);
    return Padding(
      padding: EdgeInsets.only(top: top + _inset, bottom: _inset),
      // A physical instrument: never mirrored for right-to-left languages.
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: LayoutBuilder(
          builder: (context, box) {
            final vertical = box.maxHeight >= box.maxWidth;
            final length = vertical ? box.maxHeight : box.maxWidth;
            final across = vertical ? box.maxWidth : box.maxHeight;
            final maxMm = scale.mm(length, dpr);
            final maxAcrossMm = scale.mm(across, dpr);
            viewModel.setRulerLength(maxMm, widthMm: maxAcrossMm);
            double along(Offset p) => vertical ? p.dy : p.dx;
            double side(Offset p) => vertical ? p.dx : p.dy;
            final aligning = viewModel.calibrating;
            final width = viewModel.width && !aligning;
            final referenceMm = viewModel.referenceMm;
            final l = context.l10n;
            final mm = viewModel.lengthMm;
            final widthMm = viewModel.widthMm;
            final unit = _unit(context);
            // Every finger on its own: one can hold the object while
            // another drags, or two lines move at once.
            void down(PointerDownEvent e) => aligning
                ? viewModel.dragReference(along(e.localPosition), length)
                : viewModel.pointerDown(
                    e.pointer,
                    scale.mm(along(e.localPosition), dpr),
                    scale.mm(side(e.localPosition), dpr),
                    time: e.timeStamp,
                    grabMm: scale.mm(_grab, dpr),
                  );
            void move(PointerMoveEvent e) => aligning
                ? viewModel.dragReference(along(e.localPosition), length)
                : viewModel.pointerMove(
                    e.pointer,
                    scale.mm(along(e.localPosition), dpr),
                    scale.mm(side(e.localPosition), dpr),
                    slopMm: scale.mm(kTouchSlop, dpr),
                  );
            return Stack(
              children: [
                Positioned.fill(
                  child: Listener(
                    behavior: HitTestBehavior.opaque,
                    onPointerDown: down,
                    onPointerMove: move,
                    onPointerUp: (e) =>
                        viewModel.pointerUp(e.pointer, time: e.timeStamp),
                    onPointerCancel: (e) => viewModel.pointerCancel(e.pointer),
                    child: Semantics(
                      // Its own node: the measurement, read as one phrase.
                      container: true,
                      label: aligning
                          ? null
                          : width
                          ? l.rulerBoxSemantics(
                              formatDecimal(mm),
                              formatDecimal(widthMm),
                              formatDecimal(mm * widthMm / 100),
                            )
                          : l.rulerSemantics(
                              formatDecimal(mm),
                              formatDecimal(mm / mmPerInch, digits: 2),
                            ),
                      // The scale only changes with the size or scale, so it
                      // sits on its own cached layer; a drag repaints just
                      // the lines on top.
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          for (final layer in _RulerLayer.values)
                            RepaintBoundary(
                              child: CustomPaint(
                                painter: _RulerPainter(
                                  layer: layer,
                                  palette: Palette.of(context),
                                  scale: scale,
                                  dpr: dpr,
                                  vertical: vertical,
                                  ends: [
                                    viewModel.shown(0, maxMm),
                                    viewModel.shown(1, maxMm),
                                  ],
                                  cross: width
                                      ? [
                                          viewModel.shown(2, maxAcrossMm),
                                          viewModel.shown(3, maxAcrossMm),
                                        ]
                                      : null,
                                  referenceSpan: aligning
                                      ? viewModel.referenceSpan
                                      : null,
                                  card:
                                      viewModel.method ==
                                      CalibrationMethod.card,
                                  cardMm: referenceMm,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
                // In landscape the ruler is short: its reading and unit
                // switch sit in the footer instead, so nothing covers it.
                // The reading lets touches through to the lines; the switch
                // keeps its own taps.
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
                                _measurement(context, unit),
                                const SizedBox(height: 14),
                                _unitSwitch(context, unit),
                              ],
                            ),
                    ),
                  ),
              ],
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

  /// How near a line a finger must land to take it at once.
  static const _grab = 24.0;

  /// The length in [unit], big, with the other system small; with width
  /// on, length × width big and the area small.
  Widget _measurement(
    BuildContext context,
    LengthUnit unit, {
    bool inline = false,
  }) {
    final mm = viewModel.lengthMm;
    if (viewModel.width) {
      return _Reading(
        main: formatLengthByWidth(mm, viewModel.widthMm, unit),
        sub: context.l10n.rulerArea(formatArea(mm * viewModel.widthMm, unit)),
        inline: inline,
      );
    }
    return _Reading(
      main: formatLength(mm, unit),
      sub: formatLength(
        mm,
        unit == LengthUnit.inch ? LengthUnit.mm : LengthUnit.inch,
      ),
      inline: inline,
    );
  }

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
      label: l.calibrate,
      icon: Icons.tune_rounded,
      emphasis: scale.source == ScaleSource.estimated,
      onPressed: viewModel.locked
          ? null
          : () => _chooseMethod(context, scale, dpr, physical),
    );
    final lock = LockButton(
      locked: viewModel.locked,
      onPressed: viewModel.toggleLock,
      tooltip: l.lockHandles,
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
                child: _measurement(context, unit, inline: true),
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

/// The header's width switch: a box in a disc, orange while the lines
/// across the ruler are on.
class _WidthButton extends StatelessWidget {
  const _WidthButton({required this.on, required this.onPressed});

  final bool on;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final p = Palette.of(context);
    return Semantics(
      toggled: on,
      child: IconButton(
        tooltip: context.l10n.rulerWidthOn,
        onPressed: onPressed,
        icon: CustomPaint(
          size: const Size(28, 28),
          painter: _BoxGlyphPainter(
            disc: on ? [p.ballLight, p.ballDark] : [p.tab, p.tab],
          ),
        ),
      ),
    );
  }
}

class _BoxGlyphPainter extends CustomPainter {
  _BoxGlyphPainter({required this.disc});

  final List<Color> disc;

  @override
  void paint(Canvas canvas, Size size) {
    final c = size.center(Offset.zero);
    final rect = Rect.fromCircle(center: c, radius: 12);
    canvas
      ..drawCircle(
        c,
        12,
        Paint()
          ..shader = LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: disc,
          ).createShader(rect),
      )
      ..drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromCenter(center: c, width: 13, height: 10),
          const Radius.circular(1.5),
        ),
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.8
          ..color = Colors.white,
      );
  }

  @override
  bool shouldRepaint(_BoxGlyphPainter old) =>
      old.disc[0] != disc[0] || old.disc[1] != disc[1];
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
  bool _saving = false;

  @override
  void dispose() {
    _text.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    // Save and the keyboard's Done can both fire: pop the sheet once.
    if (_saving) return;
    _saving = true;
    final ok = await widget.viewModel.saveScreenSize(
      _text.text,
      dpr: widget.dpr,
      physical: widget.physical,
    );
    if (!mounted) return;
    if (ok) {
      Navigator.of(context).pop();
    } else {
      setState(() {
        _failed = true;
        _saving = false;
      });
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

/// What a [_RulerPainter] draws: the mm and inch scale, or the lines (or
/// calibration reference) over it.
enum _RulerLayer { scale, overlay }

class _RulerPainter extends CustomPainter {
  _RulerPainter({
    required this.layer,
    required this.palette,
    required this.scale,
    required this.dpr,
    required this.vertical,
    required this.ends,
    this.cross,
    required this.referenceSpan,
    required this.card,
    required this.cardMm,
  });

  final _RulerLayer layer;
  final Palette palette;
  final ScreenScale scale;
  final double dpr;
  final bool vertical;
  final List<double> ends;

  /// The width lines, in mm across the ruler, or null with width off.
  final List<double>? cross;

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
    if (layer == _RulerLayer.overlay) {
      return _overlay(canvas, length, across, at, pos);
    }

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
    if (cross == null) return;
    // With width on, the same scales across the ruler: millimetres along
    // the zero end, inches along the far end.
    for (var mm = 0; pos(mm.toDouble()) <= across; mm++) {
      final y = pos(mm.toDouble());
      final len = mm % 10 == 0
          ? 26.0
          : mm % 5 == 0
          ? 17.0
          : 10.0;
      canvas.drawLine(at(0, y), at(len, y), mm % 5 == 0 ? major : minor);
      if (mm % 10 == 0 && mm > 0) {
        _label(canvas, '${mm ~/ 10}', at(36, y), p.ink);
      }
    }
    for (var i = 0; pos(i * eighth) <= across; i++) {
      final y = pos(i * eighth);
      final len = i % 8 == 0
          ? 26.0
          : i % 4 == 0
          ? 19.0
          : i.isEven
          ? 13.0
          : 8.0;
      canvas.drawLine(
        at(length, y),
        at(length - len, y),
        i % 4 == 0 ? major : minor,
      );
      if (i % 8 == 0 && i > 0) {
        _label(canvas, '${i ~/ 8}', at(length - 36, y), p.ink);
      }
    }
  }

  void _overlay(
    Canvas canvas,
    double length,
    double across,
    Offset Function(double, double) at,
    double Function(double) pos,
  ) {
    final p = palette;
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
    final cross = this.cross;
    if (cross != null) {
      // Across the ruler: the width band (its overlap with the length band
      // frames the object), then its lines with handles near the far end.
      final c = pos(cross[0]), d = pos(cross[1]);
      final band = Path()
        ..addPolygon([at(0, c), at(length, c), at(length, d), at(0, d)], true);
      canvas.drawPath(
        band,
        Paint()..color = p.ballDark.withValues(alpha: 0.06),
      );
      for (final y in [c, d]) {
        _crossLine(canvas, y, length, at);
      }
    }
    for (final x in [a, b]) {
      _line(canvas, x, across, at);
    }
  }

  /// A width line across the ruler at [y], its handle near the far end so
  /// it stays clear of the length lines' handles.
  void _crossLine(
    Canvas canvas,
    double y,
    double length,
    Offset Function(double, double) at,
  ) {
    canvas.drawLine(
      at(0, y),
      at(length, y),
      Paint()
        ..strokeWidth = 2
        ..color = palette.ballDark,
    );
    _handle(canvas, at(length * 0.86, y));
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
    _handle(canvas, at(x, across * 0.78));
  }

  /// The orange ball a line is dragged by.
  void _handle(Canvas canvas, Offset ball) {
    final p = palette;
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
      old.layer != layer ||
      old.palette != palette ||
      old.scale != scale ||
      old.dpr != dpr ||
      old.vertical != vertical ||
      (old.cross == null) != (cross == null) ||
      (layer == _RulerLayer.overlay && _overlayChanged(old));

  bool _overlayChanged(_RulerPainter old) =>
      old.scale != scale ||
      old.dpr != dpr ||
      old.vertical != vertical ||
      old.ends[0] != ends[0] ||
      old.ends[1] != ends[1] ||
      !listEquals(old.cross, cross) ||
      old.referenceSpan != referenceSpan ||
      old.card != card ||
      old.cardMm != cardMm ||
      old.palette != palette;
}
