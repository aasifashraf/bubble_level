import 'package:flutter/material.dart';

import '../../domain/orientation_reading.dart';
import 'theme.dart';

/// One short line stating the status in words with an icon, so it reads at
/// a glance and never relies on colour.
class StatusBanner extends StatelessWidget {
  const StatusBanner({super.key, required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    final palette = Palette.of(context);
    return Semantics(
      liveRegion: true,
      label: text,
      excludeSemantics: true,
      // Always one line (shrinks to fit) so a longer message can't grow
      // and push the instrument around.
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 18, color: palette.ink),
            const SizedBox(width: 6),
            Text(
              text,
              maxLines: 1,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                letterSpacing: -0.2,
                color: palette.ink,
              ),
            ),
          ],
        ),
      ),
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
      return const SensorStateGate(
        state: SensorState.missing,
        ready: false,
        missingText:
            'This device has no accelerometer, so tilt can’t be measured.',
        child: SizedBox.shrink(),
      );
    }
    return SensorStateGate(
      state: needsMagnetometer ? reading.magnet : SensorState.ok,
      ready:
          reading.gravity != null &&
          (!needsMagnetometer || reading.magnetic != null),
      missingText:
          'This device has no magnetometer, so this tool isn’t available.',
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
      return _Message(icon: Icons.sensors_off_outlined, text: missingText);
    }
    if (!ready) {
      return const _Message(
        icon: Icons.sensors_outlined,
        text: 'Waiting for sensors…',
      );
    }
    return child;
  }
}

class _Message extends StatelessWidget {
  const _Message({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 48, color: theme.colorScheme.onSurfaceVariant),
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
