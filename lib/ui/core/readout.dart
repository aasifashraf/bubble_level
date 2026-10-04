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
      return const _Message(
        icon: Icons.sensors_off_outlined,
        text: 'This device has no accelerometer, so tilt can’t be measured.',
      );
    }
    if (needsMagnetometer && reading.magnet == SensorState.missing) {
      return const _Message(
        icon: Icons.explore_off_outlined,
        text:
            'This device has no magnetometer, so the compass isn’t available.',
      );
    }
    final ready =
        reading.gravity != null &&
        (!needsMagnetometer || reading.magnetic != null);
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
