import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'dial.dart';
import 'theme.dart';

/// Full-screen page as in the design: content edge to edge behind the
/// status bar, the header floating on top, an optional footer at the bottom.
///
/// A tool page (one with [onBack]) in landscape has too little height for
/// the dial above its readings, so the dial takes the left side below the
/// header and the footer becomes a column on the right.
class ToolFrame extends StatelessWidget {
  const ToolFrame({
    super.key,
    required this.title,
    required this.body,
    this.onBack,
    this.leading,
    this.trailing,
    this.footer,
    this.bodyBottomInset = 0,
  });

  final String title;
  final Widget body;

  /// Shows the design's back tab on the left edge when set.
  final VoidCallback? onBack;

  /// Used instead of the back tab when there is nowhere to go back to.
  final Widget? leading;

  /// The header's right corner: the theme toggle on home, help on a tool.
  final Widget? trailing;
  final Widget? footer;

  /// Lifts the body off the bottom so a tall footer doesn't crowd it.
  final double bodyBottomInset;

  @override
  Widget build(BuildContext context) {
    final palette = Palette.of(context);
    final overlay =
        (palette.isDark
                ? SystemUiOverlayStyle.light
                : SystemUiOverlayStyle.dark)
            .copyWith(
              statusBarColor: Colors.transparent,
              systemNavigationBarColor: Colors.transparent,
            );
    final size = MediaQuery.sizeOf(context);
    final landscape = onBack != null && sideBySide(context);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: overlay,
      child: Scaffold(
        backgroundColor: palette.background,
        body: Stack(
          children: [
            if (landscape)
              ..._landscape(context, size)
            else ...[
              Positioned.fill(bottom: bodyBottomInset, child: body),
              if (footer != null)
                Positioned(
                  left: 24,
                  right: 24,
                  bottom: 0,
                  child: SafeArea(
                    top: false,
                    minimum: const EdgeInsets.only(bottom: 20),
                    child: Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 440),
                        child: footer!,
                      ),
                    ),
                  ),
                ),
            ],
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: SafeArea(
                bottom: false,
                child: Padding(
                  padding: const EdgeInsets.only(top: 18),
                  child: SizedBox(
                    height: 70,
                    child: Row(
                      children: [
                        if (onBack != null)
                          BackTab(onTap: onBack!)
                        else
                          SizedBox(width: 56, child: leading),
                        Expanded(
                          child: Center(
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                title,
                                maxLines: 1,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 0.5,
                                  color: palette.inkStrong,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 56, child: trailing),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Whether a tool page lays out side by side (landscape): the body on
  /// the left below the header, the footer in a column on the right.
  static bool sideBySide(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return size.width > size.height;
  }

  /// Height of the header below the status bar.
  static const headerHeight = 18.0 + 70;

  /// Landscape tool page: the body fills the free box left of the footer
  /// and below the header, so the dial only needs a small margin; the
  /// footer is centred in its column and scrolls if it's still too tall.
  List<Widget> _landscape(BuildContext context, Size size) {
    final pad = MediaQuery.paddingOf(context);
    final top = pad.top + headerHeight;
    final panel = (size.width * 0.42).clamp(280.0, 440.0);
    return [
      Positioned(
        left: pad.left,
        top: top,
        right: footer == null ? pad.right : pad.right + 24 + panel,
        bottom: pad.bottom + 12,
        child: DialFit(reserved: 16, child: body),
      ),
      if (footer != null)
        Positioned(
          top: top,
          bottom: pad.bottom + 12,
          right: pad.right + 24,
          width: panel,
          child: Center(child: SingleChildScrollView(child: footer)),
        ),
    ];
  }
}

/// The design's back control: a dark tab attached to the left screen edge
/// with a white chevron.
class BackTab extends StatelessWidget {
  const BackTab({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: 'Back',
      child: Semantics(
        button: true,
        label: 'Back',
        excludeSemantics: true,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: onTap,
          child: CustomPaint(
            size: const Size(56, 70),
            painter: _BackTabPainter(Palette.of(context).tab),
          ),
        ),
      ),
    );
  }
}

class _BackTabPainter extends CustomPainter {
  _BackTabPainter(this.color);

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    // 70pt tall, bulging 34.5pt out from the edge, as measured.
    final h = size.height;
    final tab = Path()
      ..moveTo(0, 0)
      ..cubicTo(0, h * 0.2, 34.5, h * 0.28, 34.5, h * 0.5)
      ..cubicTo(34.5, h * 0.72, 0, h * 0.8, 0, h)
      ..close();
    canvas
      ..drawPath(tab, Paint()..color = color)
      ..drawPath(
        Path()
          ..moveTo(18, h * 0.5 - 7)
          ..lineTo(11, h * 0.5)
          ..lineTo(18, h * 0.5 + 7),
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2.4
          ..strokeCap = StrokeCap.round
          ..strokeJoin = StrokeJoin.round
          ..color = Colors.white,
      );
  }

  @override
  bool shouldRepaint(_BackTabPainter old) => old.color != color;
}
