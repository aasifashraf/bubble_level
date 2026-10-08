import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../../data/services/ar_service.dart';
import '../../../../domain/angles.dart';
import '../../../../domain/tape_measure.dart';
import '../../../core/controls.dart';
import '../../../core/format.dart';
import '../../../core/help.dart';
import '../../../core/l10n.dart';
import '../../../core/permission_prompt.dart';
import '../../../core/readout.dart';
import '../../../core/theme.dart';
import '../../../core/tool_frame.dart';
import '../view_models/tape_view_model.dart';

/// Tape measure: the camera picture with the tapped points drawn on the
/// surfaces like a builder's plan; the panel adds up the pieces, and a
/// closed shape gives its area.
class TapeScreen extends StatelessWidget {
  const TapeScreen({super.key, required this.viewModel, required this.onBack});

  final TapeViewModel viewModel;
  final VoidCallback onBack;

  static ToolHelp _help(AppLocalizations l) => ToolHelp(
    tool: l.toolTape,
    steps: [l.tapeHelp1, l.tapeHelp2, l.tapeHelp3, l.tapeHelp4],
    tip: l.tapeTip,
  );

  /// The panel below the picture, without the phone's bottom inset.
  static const _footer = 196.0;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, _) {
        final l = context.l10n;
        final vm = viewModel;
        final live = vm.access == TapeAccess.granted && vm.texture != null;
        return ToolFrame(
          title: l.toolTape,
          onBack: onBack,
          trailing: HelpButton(help: _help(l)),
          action: live ? _UnitButton(viewModel: vm) : null,
          headerOnDark: live,
          body: switch (vm.access) {
            TapeAccess.needed => PermissionPrompt(
              icon: Icons.photo_camera_rounded,
              title: l.cameraAllowTitle,
              body: l.tapeAllowBody,
              actions: [
                SoftButton(
                  label: l.cameraAllow,
                  icon: Icons.photo_camera_rounded,
                  emphasis: true,
                  onPressed: vm.allow,
                ),
              ],
            ),
            TapeAccess.denied => PermissionPrompt(
              icon: Icons.no_photography_rounded,
              title: l.cameraDeniedTitle,
              body: l.tapeDeniedBody,
              actions: [
                SoftButton(
                  label: l.openSettings,
                  icon: Icons.settings_rounded,
                  emphasis: true,
                  onPressed: vm.openSettings,
                ),
                SoftButton(
                  label: l.tryAgain,
                  icon: Icons.refresh_rounded,
                  onPressed: vm.allow,
                ),
              ],
            ),
            TapeAccess.install => PermissionPrompt(
              icon: Icons.view_in_ar_rounded,
              title: l.tapeInstallTitle,
              body: l.tapeInstallBody,
              actions: [
                SoftButton(
                  label: l.tapeInstall,
                  icon: Icons.download_rounded,
                  emphasis: true,
                  onPressed: vm.install,
                ),
              ],
            ),
            TapeAccess.unsupported => PermissionPrompt(
              icon: Icons.view_in_ar_rounded,
              title: l.toolTape,
              body: l.tapeUnsupported,
              actions: const [],
            ),
            TapeAccess.failed => PermissionPrompt(
              icon: Icons.no_photography_rounded,
              title: l.toolTape,
              body: l.tapeFailed,
              actions: [
                SoftButton(
                  label: l.tryAgain,
                  icon: Icons.refresh_rounded,
                  emphasis: true,
                  onPressed: vm.retry,
                ),
              ],
            ),
            // Laid out while checking too: AR starts at the view's size.
            TapeAccess.checking || TapeAccess.granted => _ArView(viewModel: vm),
          },
          footer: vm.access == TapeAccess.granted ? _panel(l) : null,
        );
      },
    );
  }

  Widget _panel(AppLocalizations l) {
    final vm = viewModel;
    final shape = vm.shape;
    final inches = vm.inches;
    final total = shape.total(live: vm.live);
    final area = shape.area;
    final pieces = shape.pieces().length;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        StatPanel([
          (
            total > 0 ? formatTapeLength(total, inches: inches) : '—',
            shape.closed ? l.tapePerimeter : l.tapeLength,
          ),
          (
            area == null ? '—' : '≈ ${formatTapeArea(area, feet: inches)}',
            l.tapeArea,
          ),
          ('$pieces', l.tapePieces),
        ]),
        const SizedBox(height: 12),
        _status(l),
        const SizedBox(height: 12),
        Row(
          spacing: 14,
          children: [
            SoftIconButton(
              icon: Icons.undo_rounded,
              tooltip: l.tapeUndo,
              onPressed: vm.undo,
            ),
            Expanded(
              child: SoftButton(
                label: vm.snapping ? l.tapeClose : l.tapeAdd,
                icon: vm.snapping
                    ? Icons.check_rounded
                    : Icons.add_location_alt_rounded,
                emphasis: true,
                onPressed: shape.closed ? null : vm.add,
              ),
            ),
            SoftIconButton(
              icon: Icons.close_rounded,
              tooltip: l.clear,
              onPressed: vm.clear,
            ),
          ],
        ),
      ],
    );
  }

  Widget _status(AppLocalizations l) {
    final vm = viewModel;
    final f = vm.frame;
    final shape = vm.shape;
    StatusBanner warn(String text) => StatusBanner(
      icon: Icons.warning_amber_rounded,
      text: text,
      tone: StatusTone.warning,
    );
    if (!f.tracking) {
      return switch (f.trouble) {
        ArTrouble.dark => warn(l.tapeDark),
        ArTrouble.fast => warn(l.tapeFast),
        ArTrouble.plain => warn(l.tapePlain),
        ArTrouble.other => warn(l.tapeLost),
        null =>
          f.viewProj == null || shape.points.isEmpty
              ? StatusBanner(
                  icon: Icons.screen_rotation_alt_rounded,
                  text: l.tapeStarting,
                )
              : warn(l.tapeLost),
      };
    }
    if (vm.missed) return warn(l.tapeMissed);
    if (shape.closed) {
      return StatusBanner(icon: Icons.straighten_rounded, text: l.tapeDone);
    }
    if (f.aim == null) {
      return StatusBanner(
        icon: Icons.pan_tool_alt_rounded,
        text: f.surface ? l.tapeNoSurface : l.tapeFind,
      );
    }
    if (vm.snapping) {
      return StatusBanner(
        icon: Icons.check_circle_rounded,
        text: l.tapeSnap,
        tone: StatusTone.success,
      );
    }
    return StatusBanner(
      icon: Icons.ads_click_rounded,
      text: shape.points.isEmpty ? l.tapeFirst : l.tapeNext,
    );
  }
}

/// Switches the lengths between centimetres and inches.
class _UnitButton extends StatelessWidget {
  const _UnitButton({required this.viewModel});

  final TapeViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    final p = Palette.of(context);
    return IconButton(
      tooltip: context.l10n.tapeUnit,
      onPressed: viewModel.toggleUnit,
      icon: Container(
        width: 30,
        height: 24,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: p.tab,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          viewModel.inches ? 'in' : 'cm',
          style: const TextStyle(
            fontSize: 11.5,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

/// The camera picture and the measurement over it, ending in a rounded
/// edge above the panel.
class _ArView extends StatelessWidget {
  const _ArView({required this.viewModel});

  final TapeViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final p = Palette.of(context);
    final vm = viewModel;
    final bottom = TapeScreen._footer + MediaQuery.paddingOf(context).bottom;
    final ratio = MediaQuery.devicePixelRatioOf(context);
    final texture = vm.texture;
    final total = vm.shape.total(live: vm.live);
    return Stack(
      children: [
        Positioned.fill(
          bottom: bottom - 26,
          child: ClipRRect(
            borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(28),
            ),
            child: LayoutBuilder(
              builder: (context, box) {
                final size = box.biggest;
                // AR draws into a picture this size; starting it notifies,
                // so not during the build.
                WidgetsBinding.instance.addPostFrameCallback(
                  (_) => vm.layout(size, ratio),
                );
                return Stack(
                  fit: StackFit.expand,
                  children: [
                    const ColoredBox(color: Color(0xFF1E1E1E)),
                    if (texture != null)
                      ExcludeSemantics(child: Texture(textureId: texture)),
                    // Shade behind the header, so its white title reads,
                    // and a veil while tracking is lost.
                    const DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment(0, -0.4),
                          colors: [Color(0x8C000000), Color(0x00000000)],
                        ),
                      ),
                    ),
                    if (!vm.frame.tracking && vm.frame.viewProj != null)
                      const ColoredBox(color: Color(0x59000000)),
                    Semantics(
                      label: l.tapeSemantics(
                        total > 0
                            ? formatTapeLength(total, inches: vm.inches)
                            : '0',
                      ),
                      child: CustomPaint(
                        painter: _TapePainter(
                          frame: vm.frame,
                          shape: vm.shape,
                          live: vm.live,
                          snapping: vm.snapping,
                          inches: vm.inches,
                          palette: p,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

/// The measurement drawn like a builder's plan: the found surface's dots,
/// a line along each piece with a dimension line beside it carrying its
/// length, the orange balls at the corners, a closed shape's fill and
/// area, and the aim.
class _TapePainter extends CustomPainter {
  _TapePainter({
    required this.frame,
    required this.shape,
    required this.live,
    required this.snapping,
    required this.inches,
    required this.palette,
  });

  final ArFrame frame;
  final TapeShape shape;
  final Vec3? live;
  final bool snapping, inches;
  final Palette palette;

  static const _white = Color(0xFFFFFFFF);
  static const _shadow = Color(0x8C000000);

  @override
  void paint(Canvas canvas, Size size) {
    final m = frame.viewProj;
    final aim = Offset(
      size.width * TapeViewModel.aimAt.dx,
      size.height * TapeViewModel.aimAt.dy,
    );
    if (m == null) {
      _aim(canvas, aim, found: false);
      return;
    }
    Offset? at(Vec3 v) {
      final s = project(m, v, size.width, size.height);
      return s == null ? null : Offset(s.x, s.y);
    }

    // ARCore's feature points, while it looks for a surface.
    if (frame.tracking && (!frame.surface || frame.aim == null)) {
      final dot = Paint()..color = const Color(0xB3FFFFFF);
      for (final v in frame.cloud) {
        final s = at(v);
        if (s != null) canvas.drawCircle(s, 1.6, dot);
      }
    }

    final points = [for (final v in shape.points) at(v)];
    final chain = [...points, if (live != null) at(live!)];
    final closed = shape.closed;
    if (closed && points.every((s) => s != null)) {
      final fill = Path()..addPolygon(points.cast<Offset>(), true);
      canvas.drawPath(fill, Paint()..color = palette.ballDark.withAlpha(64));
    }

    // Pieces: from each point to the next, the live one last.
    final lengths = shape.pieces(live: live);
    final centre = _centre(points);
    final ends = [
      for (var i = 1; i < chain.length; i++) (chain[i - 1], chain[i]),
      if (closed) (points.last, points.first),
    ];
    for (final (i, (a, b)) in ends.indexed) {
      if (a == null || b == null || i >= lengths.length) continue;
      final isLive = live != null && !closed && i == ends.length - 1;
      _piece(canvas, a, b, lengths[i], centre, isLive);
    }

    for (final s in points) {
      if (s != null) _ball(canvas, s, 7.5);
    }
    if (snapping && points.first != null) {
      canvas.drawCircle(
        points.first!,
        15,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2.5
          ..color = palette.ballLight,
      );
    }
    if (closed && centre != null && shape.area != null) {
      _areaChip(
        canvas,
        centre,
        '≈ ${formatTapeArea(shape.area!, feet: inches)}',
      );
    }
    if (!closed) _aim(canvas, aim, found: frame.aim != null, snap: snapping);
  }

  /// The middle of the corners on screen, to put dimension lines outside.
  Offset? _centre(List<Offset?> points) {
    final seen = points.whereType<Offset>().toList();
    if (seen.length < 3) return null;
    return seen.reduce((a, b) => a + b) / seen.length.toDouble();
  }

  void _piece(
    Canvas canvas,
    Offset a,
    Offset b,
    double metres,
    Offset? centre,
    bool isLive,
  ) {
    final d = b - a;
    final len = d.distance;
    // The piece itself, along the surface.
    canvas.drawLine(
      a,
      b,
      Paint()
        ..color = const Color(0xD9FFFFFF)
        ..strokeWidth = 1.8
        ..strokeCap = StrokeCap.round,
    );
    if (len < 24) return;
    final u = d / len;
    // Beside it, on the side away from the shape (or above it).
    var n = Offset(-u.dy, u.dx);
    final mid = (a + b) / 2;
    if (centre != null) {
      if ((mid - centre).dx * n.dx + (mid - centre).dy * n.dy < 0) n = -n;
    } else if (n.dy > 0) {
      n = -n;
    }
    const off = 18.0;
    final a1 = a + n * off, b1 = b + n * off;
    final line = Paint()
      ..color = _white
      ..strokeWidth = 1.4
      ..strokeCap = StrokeCap.round;
    final shade = Paint()
      ..color = _shadow
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;
    // Extension lines from the corners out to the dimension line.
    for (final (from, to) in [
      (a + n * 4, a1 + n * 5),
      (b + n * 4, b1 + n * 5),
    ]) {
      canvas.drawLine(from, to, shade);
      canvas.drawLine(from, to, line);
    }

    final label = _text(
      formatTapeLength(metres, inches: inches),
      isLive ? palette.ballLight : _white,
    );
    final gap = math.min(label.width / 2 + 6, len / 2 - 4);
    final m1 = mid + n * off;
    final parts = [(a1, m1 - u * gap), (m1 + u * gap, b1)];
    for (final (p, q) in parts) {
      if ((q - p).dx * u.dx + (q - p).dy * u.dy <= 0) continue;
      if (isLive) {
        _dashed(canvas, p, q, shade);
        _dashed(canvas, p, q, line);
      } else {
        canvas.drawLine(p, q, shade);
        canvas.drawLine(p, q, line);
      }
    }
    // The architect's slashes at each end.
    final slash = (u + n) * (5 / math.sqrt2);
    for (final e in [a1, b1]) {
      canvas.drawLine(e - slash, e + slash, shade..strokeWidth = 3.5);
      canvas.drawLine(e - slash, e + slash, line..strokeWidth = 2);
    }

    // The length, upright, set into the gap.
    var angle = math.atan2(u.dy, u.dx);
    if (angle > math.pi / 2) angle -= math.pi;
    if (angle < -math.pi / 2) angle += math.pi;
    canvas
      ..save()
      ..translate(m1.dx, m1.dy)
      ..rotate(angle);
    label
      ..paint(canvas, Offset(-label.width / 2, -label.height / 2))
      ..dispose();
    canvas.restore();
  }

  void _dashed(Canvas canvas, Offset a, Offset b, Paint paint) {
    final d = b - a, len = d.distance;
    if (len == 0) return;
    final u = d / len;
    for (var t = 0.0; t < len; t += 10) {
      canvas.drawLine(a + u * t, a + u * math.min(t + 5, len), paint);
    }
  }

  TextPainter _text(String s, Color color) => TextPainter(
    text: TextSpan(
      text: s,
      style: TextStyle(
        color: color,
        fontSize: 13,
        fontWeight: FontWeight.w700,
        fontFeatures: readoutFeatures,
        shadows: const [Shadow(color: Color(0xCC000000), blurRadius: 4)],
      ),
    ),
    textDirection: TextDirection.ltr,
  )..layout();

  void _ball(Canvas canvas, Offset c, double r) {
    canvas.drawCircle(
      c + const Offset(0, 1.5),
      r,
      Paint()
        ..color = const Color(0x66000000)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3),
    );
    canvas.drawCircle(
      c,
      r,
      Paint()
        ..shader = RadialGradient(
          center: const Alignment(-0.4, -0.45),
          colors: [palette.ballLight, palette.ballDark],
        ).createShader(Rect.fromCircle(center: c, radius: r)),
    );
  }

  void _areaChip(Canvas canvas, Offset c, String s) {
    final t = _text(s, _white);
    final rect = Rect.fromCenter(
      center: c,
      width: t.width + 24,
      height: t.height + 12,
    );
    final r = RRect.fromRectAndRadius(rect, Radius.circular(rect.height / 2));
    canvas.drawRRect(
      r.shift(const Offset(0, 2)),
      Paint()
        ..color = const Color(0x59000000)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 5),
    );
    canvas.drawRRect(
      r,
      Paint()
        ..shader = LinearGradient(colors: [palette.ballLight, palette.ballDark])
            .createShader(rect),
    );
    t
      ..paint(canvas, c - Offset(t.width / 2, t.height / 2))
      ..dispose();
  }

  /// The crosshair: white on a surface, dashed grey while there's none,
  /// wider when it has snapped onto the first point.
  void _aim(Canvas canvas, Offset c, {required bool found, bool snap = false}) {
    final r = snap ? 22.0 : 17.0;
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round
      ..color = found ? _white : const Color(0x99FFFFFF);
    final shade = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..color = const Color(0x40000000);
    if (found) {
      canvas.drawCircle(c, r, shade);
      canvas.drawCircle(c, r, paint);
    } else {
      for (var a = 0.0; a < math.pi * 2; a += math.pi / 6) {
        canvas.drawArc(
          Rect.fromCircle(center: c, radius: r),
          a,
          math.pi / 12,
          false,
          paint,
        );
      }
    }
    for (final d in const [
      Offset(1, 0),
      Offset(-1, 0),
      Offset(0, 1),
      Offset(0, -1),
    ]) {
      canvas.drawLine(c + d * (r - 6), c + d * (r + 7), shade);
      canvas.drawLine(c + d * (r - 6), c + d * (r + 7), paint);
    }
    if (found) _ball(canvas, c, 3.5);
  }

  @override
  bool shouldRepaint(_TapePainter old) =>
      old.frame != frame ||
      old.snapping != snapping ||
      old.inches != inches ||
      old.shape.closed != shape.closed ||
      old.palette != palette;
}
