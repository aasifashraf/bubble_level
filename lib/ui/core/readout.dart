import 'dart:async';

import 'package:flutter/material.dart';

import '../../domain/orientation_reading.dart';
import 'l10n.dart';
import 'theme.dart';

/// What a status line means, beyond its words.
enum StatusTone {
  /// Plain guidance ("Left end low").
  neutral,

  /// The target is reached ("Level", "Metal detected").
  success,

  /// The reading can't be trusted ("Magnetic interference"), or a meter
  /// is in its take-care zone.
  warning,

  /// A meter is in its harmful zone ("Very loud").
  danger,
}

/// One short line stating the status in words with an icon, so it reads at
/// a glance and never relies on colour alone. [tone] colours it: orange for
/// a reached target, an amber pill for a caution, a red pill for harm.
/// The icon is an [icon], or a drawn [glyph] given the colour to draw in.
class StatusBanner extends StatelessWidget {
  const StatusBanner({
    super.key,
    this.icon,
    this.glyph,
    required this.text,
    this.tone = StatusTone.neutral,
  }) : assert(icon != null || glyph != null, 'an icon or a glyph');

  final IconData? icon;
  final Widget Function(Color color)? glyph;
  final String text;
  final StatusTone tone;

  @override
  Widget build(BuildContext context) {
    final palette = Palette.of(context);
    final (iconColor, textColor) = switch (tone) {
      StatusTone.neutral => (palette.ink, palette.ink),
      StatusTone.success => (palette.success, palette.success),
      StatusTone.warning => (palette.warning, palette.inkStrong),
      StatusTone.danger => (palette.gaugeDanger, palette.inkStrong),
    };
    // Always one line (shrinks to fit) so a longer message can't grow and
    // push the instrument around.
    Widget line = FittedBox(
      fit: BoxFit.scaleDown,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (glyph case final draw?)
            SizedBox.square(dimension: 20, child: draw(iconColor))
          else
            Icon(icon, size: 18, color: iconColor),
          const SizedBox(width: 6),
          Text(
            text,
            maxLines: 1,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              letterSpacing: -0.2,
              color: textColor,
            ),
          ),
        ],
      ),
    );
    if (tone == StatusTone.warning || tone == StatusTone.danger) {
      line = DecoratedBox(
        decoration: BoxDecoration(
          color: tone == StatusTone.danger
              ? palette.dangerTint
              : palette.warningTint,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          child: line,
        ),
      );
    }
    return Semantics(
      liveRegion: true,
      label: text,
      excludeSemantics: true,
      child: line,
    );
  }
}

/// Shows a waiting or "not available" message until the sensors a screen
/// needs are delivering data.
class SensorGate extends StatelessWidget {
  const SensorGate({
    super.key,
    required this.reading,
    required this.child,
    this.needsMagnetometer = false,
  });

  final OrientationReading reading;
  final bool needsMagnetometer;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (reading.accel == SensorState.missing) {
      return SensorStateGate(
        state: SensorState.missing,
        ready: false,
        missingText: context.l10n.noAccelerometer,
        child: const SizedBox.shrink(),
      );
    }
    return SensorStateGate(
      state: needsMagnetometer ? reading.magnet : SensorState.ok,
      ready:
          reading.gravity != null &&
          (!needsMagnetometer || reading.magnetic != null),
      missingText: context.l10n.noMagnetometer,
      child: child,
    );
  }
}

/// Waiting / not-available message for any one sensor, else [child].
class SensorStateGate extends StatelessWidget {
  const SensorStateGate({
    super.key,
    required this.state,
    required this.ready,
    required this.missingText,
    required this.child,
  });

  final SensorState state;
  final bool ready;
  final String missingText;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (state == SensorState.missing) {
      return _Message(
        icon: Icons.sensors_off_outlined,
        text: missingText,
        warning: true,
      );
    }
    if (!ready) return const _Waiting();
    return child;
  }
}

/// "Waiting for sensors…", and if nothing arrives within [patience] (a
/// sensor that exists but never reports, e.g. on some iPhones and
/// emulators) a message that says so and what to try, instead of waiting
/// forever.
class _Waiting extends StatefulWidget {
  const _Waiting();

  static const patience = Duration(seconds: 4);

  @override
  State<_Waiting> createState() => _WaitingState();
}

class _WaitingState extends State<_Waiting> {
  late final Timer _timer;
  var _late = false;

  @override
  void initState() {
    super.initState();
    _timer = Timer(_Waiting.patience, () => setState(() => _late = true));
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => _late
      ? _Message(
          icon: Icons.sensors_off_outlined,
          warning: true,
          text: context.l10n.noReadings,
        )
      : _Message(
          icon: Icons.sensors_outlined,
          text: context.l10n.waitingForSensors,
        );
}

class _Message extends StatelessWidget {
  const _Message({
    required this.icon,
    required this.text,
    this.warning = false,
  });

  final IconData icon;
  final String text;

  /// The tool can't work (missing or silent sensor): the icon in the
  /// caution colour.
  final bool warning;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 48,
              color: warning
                  ? Palette.of(context).warning
                  : theme.colorScheme.onSurfaceVariant,
            ),
            const SizedBox(height: 16),
            Text(
              text,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}
