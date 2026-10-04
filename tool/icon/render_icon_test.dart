// Renders the app icon PNGs into assets/icon/ in the dial's design.
// Not part of the test suite; run it after changing the design:
//
//   flutter test tool/icon/render_icon_test.dart
//   dart run flutter_launcher_icons
//   git checkout ios/Runner.xcodeproj/project.pbxproj   # the tool mis-edits it
import 'dart:io';
import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

const _bgLight = Color(0xFFF8FBFF), _bgDark = Color(0xFFD7E3F4);
const _dialLight = Color(0xFFFDFEFF), _dialDark = Color(0xFFE7EFFB);
const _dialShadow = Color(0xFFA9C0E2);
const _wellDark = Color(0xFFE2EBF7), _wellLight = Color(0xFFF4F8FE);
const _wellShadow = Color(0x557A93B8);
const _tickMinor = Color(0xFFB4BEC8), _tickMajor = Color(0xFF46515A);
const _tickZero = Color(0xFFFF5C31);
const _ballLight = Color(0xFFFFA54E), _ballDark = Color(0xFFFF6E36);

/// Gradient from top-left to bottom-right over [r].
Paint _diagonal(Rect r, Color a, Color b) => Paint()
  ..shader = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [a, b],
  ).createShader(r);

void _background(Canvas canvas, double s) => canvas.drawRect(
  Offset.zero & Size(s, s),
  _diagonal(Offset.zero & Size(s, s), _bgLight, _bgDark),
);

/// The dial of radius [r] centred in a square of side [s].
void _dial(Canvas canvas, double s, double r) {
  final c = Offset(s / 2, s / 2);
  final disc = Rect.fromCircle(center: c, radius: r);
  canvas
    // Floats: soft shadow down-right, glow up-left.
    ..drawCircle(
      c + Offset(0.08 * r, 0.14 * r),
      r,
      Paint()
        ..color = _dialShadow.withValues(alpha: 0.85)
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, 0.16 * r),
    )
    ..drawCircle(
      c - Offset(0.06 * r, 0.06 * r),
      r,
      Paint()
        ..color = Colors.white
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, 0.1 * r),
    )
    ..drawCircle(c, r, _diagonal(disc, _dialLight, _dialDark));

  // Twelve ticks: dark cardinal ones, the zero mark at the top orange.
  for (var i = 0; i < 12; i++) {
    final a = i * math.pi / 6;
    final cardinal = i % 3 == 0;
    final dir = Offset(math.sin(a), -math.cos(a));
    canvas.drawLine(
      c + dir * (r * (cardinal ? 0.76 : 0.82)),
      c + dir * (r * 0.92),
      Paint()
        ..strokeWidth = r * (cardinal ? 0.055 : 0.03)
        ..strokeCap = StrokeCap.round
        ..color = i == 0
            ? _tickZero
            : cardinal
            ? _tickMajor
            : _tickMinor,
    );
  }

  // Recessed well with its rim's shadow inside.
  final wellR = r * 0.6;
  final well = Rect.fromCircle(center: c, radius: wellR);
  final wellPath = Path()..addOval(well);
  canvas
    ..drawCircle(c, wellR, _diagonal(well, _wellDark, _wellLight))
    ..save()
    ..clipPath(wellPath)
    ..translate(0.03 * r, 0.05 * r)
    ..drawCircle(
      c,
      wellR,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 0.1 * r
        ..color = _wellShadow
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, 0.06 * r),
    )
    ..restore();

  // The orange ball: the app's "level" signal.
  final ballR = r * 0.34;
  final ball = Rect.fromCircle(center: c, radius: ballR);
  canvas
    ..drawCircle(
      c + Offset(0.03 * r, 0.06 * r),
      ballR,
      Paint()
        ..color = _ballDark.withValues(alpha: 0.4)
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, 0.07 * r),
    )
    ..drawCircle(
      c,
      ballR,
      Paint()
        ..shader = const RadialGradient(
          center: Alignment(-0.3, -0.35),
          radius: 0.95,
          colors: [_ballLight, _ballDark],
        ).createShader(ball),
    )
    ..drawOval(
      Rect.fromCenter(
        center: c + Offset(-0.12 * r, -0.15 * r),
        width: ballR * 0.75,
        height: ballR * 0.4,
      ),
      Paint()
        ..color = Colors.white.withValues(alpha: 0.35)
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, 0.03 * r),
    );
}

Future<void> _save(
  String path,
  double s,
  void Function(Canvas canvas, double s) paint,
) async {
  final recorder = ui.PictureRecorder();
  paint(Canvas(recorder), s);
  final image = await recorder.endRecording().toImage(s.round(), s.round());
  final png = await image.toByteData(format: ui.ImageByteFormat.png);
  File(path)
    ..createSync(recursive: true)
    ..writeAsBytesSync(png!.buffer.asUint8List());
}

void main() {
  test('render app icon', () async {
    const dir = 'assets/icon';
    // Full icon: iOS, older Android launchers and the Play listing.
    void full(Canvas c, double s) {
      _background(c, s);
      _dial(c, s, s * 0.36);
    }

    await _save('$dir/app_icon.png', 1024, full);
    await _save('$dir/play_store_icon_512.png', 512, full);
    // Adaptive icon (Android 8+): the dial kept inside the 66/108 safe zone
    // so no launcher mask clips it, over the gradient background layer.
    await _save(
      '$dir/app_icon_foreground.png',
      1024,
      (c, s) => _dial(c, s, s * 0.27),
    );
    await _save('$dir/app_icon_background.png', 1024, _background);
  });
}
