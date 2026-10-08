import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../data/services/location_service.dart';
import '../../../../domain/orientation_reading.dart';
import '../../../../domain/scene_weather.dart';
import '../../../../domain/speed.dart';
import '../../../core/controls.dart';
import '../../../core/format.dart';
import '../../../core/help.dart';
import '../../../core/l10n.dart';
import '../../../core/permission_prompt.dart';
import '../../../core/readout.dart';
import '../../../core/theme.dart';
import '../../../core/tool_frame.dart';
import '../../../core/weather_button.dart';
import '../view_models/speed_view_model.dart';
import 'speed_scene.dart';

/// Speedometer: the view from the driver's seat, filling the screen, with
/// the speed on the dashboard and the trip on the panel below.
class SpeedScreen extends StatelessWidget {
  const SpeedScreen({super.key, required this.viewModel, required this.onBack});

  final SpeedViewModel viewModel;
  final VoidCallback onBack;

  static ToolHelp _help(AppLocalizations l) => ToolHelp(
    tool: l.toolSpeed,
    steps: [
      l.speedHelp1,
      l.speedHelp2,
      l.speedHelp3,
      l.speedSceneHelp,
      l.speedHelp4,
    ],
    tip: l.speedTip,
  );

  /// The panel below the dashboard, without the phone's bottom inset.
  static const _footer = 196.0;

  /// The gauge's top speed, m/s (200 km/h, about 124 mph).
  static const _max = 200 / kmhPerMs;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, _) {
        final l = context.l10n;
        final vm = viewModel;
        final granted = vm.access == LocationAccess.granted;
        final r = vm.reading;
        final driving = granted && r.state != SensorState.missing;
        return ToolFrame(
          title: l.toolSpeed,
          onBack: onBack,
          trailing: HelpButton(help: _help(l)),
          action: driving
              ? WeatherButton(
                  picked: vm.pickedWeather,
                  shown: vm.weather,
                  night: vm.dayPart == DayPart.night,
                  onPick: vm.pickWeather,
                )
              : null,
          // The sky behind the header: a white title reads on it.
          headerOnDark: driving,
          body: switch (vm.access) {
            null => const SizedBox.shrink(),
            LocationAccess.needed => PermissionPrompt(
              icon: Icons.location_on_rounded,
              title: l.speedAllowTitle,
              body: l.speedAllowBody,
              actions: [
                SoftButton(
                  label: l.speedAllow,
                  icon: Icons.location_on_rounded,
                  emphasis: true,
                  onPressed: vm.allow,
                ),
              ],
            ),
            LocationAccess.denied => PermissionPrompt(
              icon: Icons.location_off_rounded,
              title: l.speedDeniedTitle,
              body: l.speedDeniedBody,
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
            LocationAccess.serviceOff => PermissionPrompt(
              icon: Icons.location_disabled_rounded,
              title: l.speedServiceOffTitle,
              body: l.speedServiceOffBody,
              actions: [
                SoftButton(
                  label: l.openSettings,
                  icon: Icons.settings_rounded,
                  emphasis: true,
                  onPressed: vm.openSettings,
                ),
              ],
            ),
            LocationAccess.granted =>
              r.state == SensorState.missing
                  ? SensorStateGate(
                      state: r.state,
                      ready: false,
                      missingText: l.noGps,
                      child: const SizedBox.shrink(),
                    )
                  : _Drive(viewModel: vm),
          },
          footer: driving ? _panel(l) : null,
        );
      },
    );
  }

  Widget _panel(AppLocalizations l) {
    final vm = viewModel;
    final r = vm.reading;
    final unit = vm.mph ? l.speedMph : l.speedKmh;
    String speed(double ms) => '${vm.perHour(ms).round()} $unit';
    final km = vm.mph ? r.distance / 1609.344 : r.distance / 1000;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        StatPanel([
          ('${formatDecimal(km)} ${vm.mph ? 'mi' : 'km'}', l.speedDistance),
          (speed(r.top), l.speedTop),
          (speed(r.average), l.speedAverage),
        ]),
        const SizedBox(height: 12),
        _status(l),
        const SizedBox(height: 12),
        Row(
          spacing: 14,
          children: [
            Expanded(
              child: SoftButton(
                label: l.speedResetTrip,
                icon: Icons.restart_alt_rounded,
                emphasis: true,
                onPressed: vm.resetTrip,
              ),
            ),
            SizedBox(
              width: 104,
              child: Tooltip(
                message: l.speedUnitTooltip,
                child: SoftButton(
                  label: unit,
                  icon: Icons.swap_horiz_rounded,
                  onPressed: vm.toggleUnit,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _status(AppLocalizations l) {
    final r = viewModel.reading;
    if (!r.hasFix) {
      return StatusBanner(
        icon: Icons.satellite_alt_rounded,
        text: l.speedFinding,
      );
    }
    if (viewModel.approximate) {
      return StatusBanner(
        icon: Icons.location_searching_rounded,
        text: l.speedApproximate,
        tone: StatusTone.warning,
      );
    }
    if (r.weak) {
      return StatusBanner(
        icon: Icons.warning_amber_rounded,
        text: l.speedWeak,
        tone: StatusTone.warning,
      );
    }
    return StatusBanner(
      icon: Icons.gps_fixed_rounded,
      text: l.speedGps(r.accuracy!.round().toString()),
    );
  }
}

/// The scene, sized to leave the panel below the dashboard, and the
/// coordinates under the header.
class _Drive extends StatelessWidget {
  const _Drive({required this.viewModel});

  final SpeedViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final vm = viewModel;
    final r = vm.reading;
    final unit = vm.mph ? l.speedMph : l.speedKmh;
    final distance = vm.mph ? r.distance / 1609.344 : r.distance / 1000;
    final readout = r.speed == null ? '—' : vm.perHour(r.speed!).round();
    return LayoutBuilder(
      builder: (context, box) {
        final bottom =
            SpeedScreen._footer + MediaQuery.paddingOf(context).bottom;
        final dashTop = (box.maxHeight - bottom - 150).clamp(
          ToolFrame.contentTop(context) + 120,
          box.maxHeight,
        );
        return Stack(
          children: [
            Positioned.fill(
              child: Semantics(
                label: l.speedSemantics('$readout $unit'),
                excludeSemantics: true,
                child: SpeedScene(
                  speed: r.speed,
                  maxSpeed: SpeedScreen._max,
                  readout: '$readout',
                  unit: unit,
                  left: (
                    '${formatDecimal(distance)} ${vm.mph ? 'mi' : 'km'}',
                    l.speedTrip,
                  ),
                  right: (
                    r.altitude == null ? '—' : formatMeters(r.altitude!),
                    l.speedAltitude,
                  ),
                  dashTop: dashTop,
                  weather: vm.weather,
                  dayPart: vm.dayPart,
                ),
              ),
            ),
            if (r.latitude != null && r.longitude != null)
              Positioned(
                top: ToolFrame.contentTop(context) + 4,
                left: 0,
                right: 0,
                child: Center(
                  child: _Coordinates(
                    latitude: r.latitude!,
                    longitude: r.longitude!,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}

/// The position as a quiet chip; a tap copies it.
class _Coordinates extends StatefulWidget {
  const _Coordinates({required this.latitude, required this.longitude});

  final double latitude, longitude;

  @override
  State<_Coordinates> createState() => _CoordinatesState();
}

class _CoordinatesState extends State<_Coordinates> {
  bool _copied = false;
  Timer? _timer;

  String get _text =>
      '${formatCoordinate(widget.latitude, latitude: true)}, '
      '${formatCoordinate(widget.longitude, latitude: false)}';

  Future<void> _copy() async {
    await Clipboard.setData(ClipboardData(text: _text));
    if (!mounted) return;
    setState(() => _copied = true);
    _timer?.cancel();
    _timer = Timer(const Duration(seconds: 2), () {
      if (mounted) setState(() => _copied = false);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final p = Palette.of(context);
    return Semantics(
      button: true,
      label: '${l.speedCoordinates}: $_text',
      excludeSemantics: true,
      child: GestureDetector(
        onTap: _copy,
        child: Container(
          constraints: const BoxConstraints(minHeight: 36),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          // Dark glass over the sky, day or night.
          decoration: BoxDecoration(
            color: const Color(0x61000000),
            borderRadius: BorderRadius.circular(18),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            spacing: 6,
            children: [
              Icon(
                _copied ? Icons.check_rounded : Icons.place_rounded,
                size: 16,
                color: p.ballDark,
              ),
              Text(
                _copied ? l.speedCopied : _text,
                textDirection: TextDirection.ltr,
                style: TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w600,
                  fontFeatures: readoutFeatures,
                  color: const Color(0xFFFFFFFF),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
