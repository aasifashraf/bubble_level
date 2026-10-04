import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../data/services/sensor_availability_service.dart';
import 'controls.dart';
import 'l10n.dart';
import 'theme.dart';

/// A short "How to use" guide for one tool: numbered steps and one tip.
@immutable
class ToolHelp {
  const ToolHelp({required this.tool, required this.steps, this.tip});

  /// The tool's name, as in its title.
  final String tool;

  /// Three or four short, plain instructions, in order.
  final List<String> steps;

  /// One thing worth knowing for accurate results.
  final String? tip;
}

/// The "?" button in a tool's header that opens its guide.
class HelpButton extends StatelessWidget {
  const HelpButton({super.key, required this.help});

  final ToolHelp help;

  @override
  Widget build(BuildContext context) {
    final p = Palette.of(context);
    return IconButton(
      tooltip: context.l10n.howToUse,
      onPressed: () => showHelpSheet(context, help),
      icon: CustomPaint(
        size: const Size(28, 28),
        painter: _HelpGlyphPainter(
          disc: p.tab,
          mark: Colors.white,
          dot: p.ballDark,
        ),
      ),
    );
  }
}

/// A solid disc in the back tab's colour with a white question mark, its
/// dot in the indicator orange, so both header corners match.
class _HelpGlyphPainter extends CustomPainter {
  _HelpGlyphPainter({
    required this.disc,
    required this.mark,
    required this.dot,
  });

  final Color disc, mark, dot;

  @override
  void paint(Canvas canvas, Size size) {
    final c = size.center(Offset.zero);
    canvas.drawCircle(c, 12, Paint()..color = disc);
    // The hook: a round arc over the top, curving into a short stem.
    final hook = c + const Offset(0, -3);
    const r = 4.0;
    final path = Path()
      ..addArc(
        Rect.fromCircle(center: hook, radius: r),
        math.pi,
        math.pi * 1.25,
      )
      ..quadraticBezierTo(c.dx, c.dy + 0.6, c.dx, c.dy + 2.6);
    canvas
      ..drawPath(
        path,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2.6
          ..strokeCap = StrokeCap.round
          ..strokeJoin = StrokeJoin.round
          ..color = mark,
      )
      ..drawCircle(c + const Offset(0, 6.6), 1.8, Paint()..color = dot);
  }

  @override
  bool shouldRepaint(_HelpGlyphPainter old) =>
      old.disc != disc || old.mark != mark || old.dot != dot;
}

/// Opens [help] as a sheet in the app's design: numbered steps in a soft
/// card, a tip, and a "Got it" button.
Future<void> showHelpSheet(BuildContext context, ToolHelp help) {
  final tip = help.tip;
  final l = context.l10n;
  return _showSheet(
    context,
    title: l.howToUseTool(help.tool),
    button: l.gotIt,
    children: [
      _Card(
        child: Column(
          spacing: 16,
          children: [
            for (final (i, step) in help.steps.indexed)
              _Step(number: i + 1, text: step),
          ],
        ),
      ),
      if (tip != null) _Tip(label: l.goodToKnow, text: tip),
    ],
  );
}

/// Explains, before opening it, that [tool] can't work on this device
/// because it lacks [missing], so the app doesn't seem broken.
Future<void> showUnavailableSheet(
  BuildContext context, {
  required String tool,
  required List<SensorKind> missing,
}) {
  final l = context.l10n;
  final names = missing.map(l.sensorName).join(l.listSeparator);
  return _showSheet(
    context,
    title: l.toolUnavailableTitle(tool),
    button: l.ok,
    children: [
      _Card(
        child: Column(
          spacing: 14,
          children: [
            Icon(
              Icons.sensors_off_rounded,
              size: 40,
              color: Palette.of(context).ballDark,
            ),
            Text(
              l.toolUnavailableBody(tool, missing.length, names),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                height: 1.45,
                fontWeight: FontWeight.w500,
                color: Palette.of(context).inkStrong,
              ),
            ),
          ],
        ),
      ),
      _Tip(label: l.goodToKnow, text: l.hardwareLimitTip),
    ],
  );
}

/// One choice in [showOptionsSheet]; a disabled one shows why in its
/// [subtitle].
typedef SheetOption<T> = ({
  T value,
  IconData icon,
  String title,
  String subtitle,
  bool enabled,
});

/// Asks the user to pick one of [options]; null when they cancel.
Future<T?> showOptionsSheet<T>(
  BuildContext context, {
  required String title,
  required List<SheetOption<T>> options,
}) => _showSheet<T>(
  context,
  title: title,
  button: context.l10n.cancel,
  buttonIcon: Icons.close_rounded,
  emphasis: false,
  children: [for (final o in options) _Option<T>(option: o)],
);

/// An [AppSheet] whose one button closes it (emphasised unless
/// [emphasis] is false).
Future<T?> _showSheet<T>(
  BuildContext context, {
  required String title,
  required String button,
  required List<Widget> children,
  IconData buttonIcon = Icons.check_rounded,
  bool emphasis = true,
}) => showAppSheet<T>(
  context,
  (context) => AppSheet(
    title: title,
    action: SoftButton(
      label: button,
      icon: buttonIcon,
      emphasis: emphasis,
      onPressed: () => Navigator.of(context).pop(),
    ),
    children: children,
  ),
);

/// Opens [builder]'s [AppSheet] as a modal bottom sheet.
Future<T?> showAppSheet<T>(BuildContext context, WidgetBuilder builder) =>
    showModalBottomSheet<T>(
      context: context,
      isScrollControlled: true,
      // Never taller than the space below the status bar (landscape).
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: builder,
    );

/// The app's bottom sheet: themed background with rounded top, a grab
/// handle, a title, [children] and the [action] buttons. Stays above the
/// keyboard, and scrolls when large text makes it taller than the screen.
class AppSheet extends StatelessWidget {
  const AppSheet({
    super.key,
    required this.title,
    required this.children,
    required this.action,
  });

  final String title;
  final List<Widget> children;
  final Widget action;

  @override
  Widget build(BuildContext context) {
    final p = Palette.of(context);
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: Container(
        decoration: BoxDecoration(
          color: p.background,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Container(
                    width: 44,
                    height: 5,
                    decoration: insetSurface(
                      p,
                      radius: BorderRadius.circular(3),
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.3,
                    color: p.inkStrong,
                  ),
                ),
                const SizedBox(height: 22),
                for (final (i, child) in children.indexed) ...[
                  if (i > 0) const SizedBox(height: 16),
                  child,
                ],
                const SizedBox(height: 20),
                action,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// A tappable choice on a soft raised card: icon, title and subtitle.
class _Option<T> extends StatelessWidget {
  const _Option({required this.option});

  final SheetOption<T> option;

  @override
  Widget build(BuildContext context) {
    final p = Palette.of(context);
    final o = option;
    final radius = BorderRadius.circular(24);
    return Opacity(
      opacity: o.enabled ? 1 : 0.45,
      child: Container(
        decoration: softSurface(p, radius: radius),
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            borderRadius: radius,
            onTap: o.enabled ? () => Navigator.of(context).pop(o.value) : null,
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Row(
                spacing: 14,
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: insetSurface(
                      p,
                      radius: BorderRadius.circular(22),
                    ),
                    child: Icon(o.icon, size: 22, color: p.ballDark),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 2,
                      children: [
                        Text(
                          o.title,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: p.inkStrong,
                          ),
                        ),
                        Text(
                          o.subtitle,
                          style: TextStyle(
                            fontSize: 13.5,
                            height: 1.35,
                            color: p.label,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// The sheet's main content on a soft raised card.
class _Card extends StatelessWidget {
  const _Card({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.fromLTRB(16, 18, 18, 18),
    decoration: softSurface(
      Palette.of(context),
      radius: BorderRadius.circular(26),
    ),
    child: child,
  );
}

/// A recessed note with a bulb: a bold [label], then [text].
class _Tip extends StatelessWidget {
  const _Tip({required this.label, required this.text});

  final String label, text;

  @override
  Widget build(BuildContext context) {
    final p = Palette.of(context);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: insetSurface(p, radius: BorderRadius.circular(22)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 12,
        children: [
          Icon(Icons.lightbulb_outline_rounded, size: 22, color: p.ballDark),
          Expanded(
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: label,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: p.inkStrong,
                    ),
                  ),
                  TextSpan(text: text),
                ],
              ),
              style: TextStyle(fontSize: 14, height: 1.45, color: p.ink),
            ),
          ),
        ],
      ),
    );
  }
}

/// One numbered step: an orange number in a soft round badge, then text.
class _Step extends StatelessWidget {
  const _Step({required this.number, required this.text});

  final int number;
  final String text;

  @override
  Widget build(BuildContext context) {
    final p = Palette.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 14,
      children: [
        Container(
          width: 30,
          height: 30,
          alignment: Alignment.center,
          decoration: insetSurface(p, radius: BorderRadius.circular(15)),
          child: Text(
            '$number',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: p.ballDark,
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              text,
              style: TextStyle(fontSize: 15, height: 1.45, color: p.ink),
            ),
          ),
        ),
      ],
    );
  }
}
