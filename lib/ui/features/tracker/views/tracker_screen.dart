import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../../data/services/bluetooth_service.dart';
import '../../../../domain/tracker.dart';
import '../../../core/controls.dart';
import '../../../core/help.dart';
import '../../../core/l10n.dart';
import '../../../core/permission_prompt.dart';
import '../../../core/readout.dart';
import '../../../core/theme.dart';
import '../../../core/tool_frame.dart';
import '../view_models/tracker_view_model.dart';

/// Tracker check: Bluetooth trackers near you that are away from their
/// owners, on rings by how close they are (the angle means nothing: a
/// phone can't tell where a signal comes from), and a warning for any that
/// travels with you.
class TrackerScreen extends StatelessWidget {
  const TrackerScreen({
    super.key,
    required this.viewModel,
    required this.onBack,
    required this.onOpenMetal,
  });

  final TrackerViewModel viewModel;
  final VoidCallback onBack;

  /// Closes this tool and opens the Metal detector (the car check).
  final VoidCallback onOpenMetal;

  static ToolHelp _help(AppLocalizations l) => ToolHelp(
    tool: l.toolTracker,
    steps: [l.trackerHelp1, l.trackerHelp2, l.trackerHelp3, l.trackerHelp4],
    tip: l.trackerTip,
  );

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, _) {
        final vm = viewModel;
        final ready = vm.access == BluetoothAccess.granted;
        final finding = vm.mode == TrackerMode.find;
        return ToolFrame(
          title: l.toolTracker,
          onBack: onBack,
          trailing: HelpButton(help: _help(l)),
          bodyBottomInset: ready ? 170 : 0,
          body: switch (vm.access) {
            null => const SizedBox.shrink(),
            BluetoothAccess.needed => PermissionPrompt(
              icon: Icons.bluetooth_searching_rounded,
              title: l.trackerAllowTitle,
              body: l.trackerAllowBody,
              actions: [
                SoftButton(
                  label: l.trackerAllow,
                  icon: Icons.bluetooth_rounded,
                  emphasis: true,
                  onPressed: vm.allow,
                ),
              ],
            ),
            BluetoothAccess.denied => _blocked(
              context,
              l.trackerDeniedTitle,
              l.trackerDeniedBody,
              retry: true,
            ),
            BluetoothAccess.bluetoothOff => _blocked(
              context,
              l.trackerBluetoothOffTitle,
              l.trackerBluetoothOffBody,
            ),
            BluetoothAccess.locationOff => _blocked(
              context,
              l.trackerLocationOffTitle,
              l.trackerLocationOffBody,
            ),
            BluetoothAccess.granted =>
              finding ? _FindView(viewModel: vm) : _Overview(viewModel: vm),
          },
          footer: !ready
              ? null
              : finding
              ? SoftButton(
                  label: l.trackerDone,
                  icon: Icons.check_rounded,
                  emphasis: true,
                  onPressed: vm.doneFinding,
                )
              : _footer(context),
        );
      },
    );
  }

  Widget _blocked(
    BuildContext context,
    String title,
    String body, {
    bool retry = false,
  }) {
    final l = context.l10n;
    return PermissionPrompt(
      icon: Icons.bluetooth_disabled_rounded,
      title: title,
      body: body,
      actions: [
        SoftButton(
          label: l.openSettings,
          icon: Icons.settings_rounded,
          emphasis: true,
          onPressed: viewModel.openSettings,
        ),
        if (retry)
          SoftButton(
            label: l.tryAgain,
            icon: Icons.refresh_rounded,
            onPressed: viewModel.allow,
          ),
      ],
    );
  }

  Widget _footer(BuildContext context) {
    final l = context.l10n;
    final p = Palette.of(context);
    final vm = viewModel;
    final running = vm.mode != TrackerMode.idle;
    final problem = vm.locationProblem;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (problem != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              spacing: 10,
              children: [
                Expanded(
                  child: StatusBanner(
                    icon: Icons.location_off_rounded,
                    text: l.trackerLocationNeeded,
                    tone: StatusTone.warning,
                  ),
                ),
                SoftIconButton(
                  icon: Icons.settings_rounded,
                  tooltip: l.openSettings,
                  onPressed: vm.openLocationSettings,
                ),
              ],
            ),
          ),
        // What it can't hear, said every time, with the car check.
        Semantics(
          button: true,
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () => _carCheck(context),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text.rich(
                TextSpan(
                  style: TextStyle(fontSize: 12.5, color: p.label),
                  children: [
                    TextSpan(text: '${l.trackerSimNote} · '),
                    TextSpan(
                      text: l.trackerCarCheck,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: p.ink,
                        decoration: TextDecoration.underline,
                        decorationColor: p.label,
                      ),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        if (running)
          SoftButton(
            label: l.trackerStop,
            icon: Icons.stop_rounded,
            emphasis: true,
            onPressed: vm.stop,
          )
        else
          Row(
            spacing: 14,
            children: [
              Expanded(
                child: SoftButton(
                  label: l.trackerScanHere,
                  icon: Icons.radar_rounded,
                  onPressed: vm.scanHere,
                ),
              ),
              Expanded(
                child: SoftButton(
                  label: l.trackerCheckMoving,
                  icon: Icons.route_rounded,
                  emphasis: true,
                  onPressed: vm.checkWhileMoving,
                ),
              ),
            ],
          ),
      ],
    );
  }

  Future<void> _carCheck(BuildContext context) async {
    final open = await showAppSheet<bool>(context, (sheet) {
      final l = sheet.l10n;
      final p = Palette.of(sheet);
      final spots = [l.carSpot1, l.carSpot2, l.carSpot3, l.carSpot4];
      return AppSheet(
        title: l.trackerCarCheck,
        action: SoftButton(
          label: l.carOpenMetal,
          icon: Icons.sensors_rounded,
          emphasis: true,
          onPressed: () => Navigator.of(sheet).pop(true),
        ),
        children: [
          Text(
            l.carCheckBody,
            style: TextStyle(fontSize: 15, height: 1.45, color: p.ink),
          ),
          for (final (i, spot) in spots.indexed)
            Row(
              spacing: 12,
              children: [
                Container(
                  width: 26,
                  height: 26,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(colors: [p.ballLight, p.ballDark]),
                  ),
                  child: Text(
                    '${i + 1}',
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    spot,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: p.inkStrong,
                    ),
                  ),
                ),
              ],
            ),
          Text(
            l.carCheckTip,
            style: TextStyle(fontSize: 13.5, height: 1.4, color: p.label),
          ),
        ],
      );
    });
    if (open ?? false) onOpenMetal();
  }
}

/// The rings, the status above them and the trackers below.
class _Overview extends StatelessWidget {
  const _Overview({required this.viewModel});

  final TrackerViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final p = Palette.of(context);
    final vm = viewModel;
    final trackers = vm.trackers;
    final nearby = vm.nearby;
    final following = trackers.where(FollowCheck.follows).toList();
    final first = following.isEmpty ? null : following.first;
    final status = switch (vm.mode) {
      _ when vm.paused => StatusBanner(
        icon: Icons.pause_circle_outline_rounded,
        text: l.trackerPaused,
        tone: StatusTone.warning,
      ),
      _ when first != null => StatusBanner(
        icon: Icons.warning_rounded,
        text: l.trackerFollowingBanner(
          _kindName(l, first.kind),
          first.places.length,
        ),
        tone: StatusTone.danger,
      ),
      _ when vm.scanFailed => StatusBanner(
        icon: Icons.bluetooth_disabled_rounded,
        text: l.trackerScanFailed,
        tone: StatusTone.warning,
      ),
      _ when vm.gpsLost => StatusBanner(
        icon: Icons.location_disabled_rounded,
        text: l.trackerGpsLost,
        tone: StatusTone.warning,
      ),
      TrackerMode.moving => StatusBanner(
        icon: Icons.route_rounded,
        text: l.trackerMoving(vm.listenedFor.inMinutes, vm.placesPassed),
      ),
      TrackerMode.here => StatusBanner(
        icon: Icons.radar_rounded,
        text: l.trackerListening,
      ),
      // Only after a full scan: a cut-short one proves nothing.
      _ when trackers.isEmpty && vm.listenedEnough => StatusBanner(
        icon: Icons.check_circle_outline_rounded,
        text: l.trackerNothingHeard,
        tone: StatusTone.success,
      ),
      _ => StatusBanner(icon: Icons.info_outline_rounded, text: l.trackerIdle),
    };
    final rows = trackers.take(3).toList();
    return Padding(
      padding: EdgeInsets.fromLTRB(20, ToolFrame.contentTop(context), 20, 8),
      child: Column(
        children: [
          status,
          if (first != null)
            TextButton.icon(
              onPressed: () => _safety(context),
              icon: Icon(Icons.shield_outlined, color: p.gaugeDanger),
              label: Text(
                l.trackerWhatToDo,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: p.gaugeDanger,
                ),
              ),
            ),
          Expanded(
            child: Semantics(
              label: l.trackerSemantics(following.length, nearby.length),
              child: RepaintBoundary(
                child: _OrbitDial(trackers: nearby, spinning: vm.scanning),
              ),
            ),
          ),
          for (final t in rows) _TrackerRow(trail: t, viewModel: vm),
          if (trackers.length > rows.length || vm.mineHeard.isNotEmpty)
            TextButton(
              onPressed: () => _showAll(context),
              child: Text(
                l.trackerShowAll(trackers.length),
                style: TextStyle(fontWeight: FontWeight.w700, color: p.ink),
              ),
            ),
        ],
      ),
    );
  }

  /// What to do when a tracker follows you: safety first, then evidence,
  /// as police and support services advise.
  void _safety(BuildContext context) => showAppSheet<void>(context, (sheet) {
    final l = sheet.l10n;
    final p = Palette.of(sheet);
    final points = [
      l.trackerSafety1,
      l.trackerSafety2,
      l.trackerSafety3,
      l.trackerSafety4,
      l.trackerSafety5,
      l.trackerSafety6,
    ];
    return AppSheet(
      title: l.trackerSafetyTitle,
      action: SoftButton(
        label: l.trackerDone,
        icon: Icons.check_rounded,
        onPressed: () => Navigator.of(sheet).pop(),
      ),
      children: [
        for (final (i, point) in points.indexed)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 12,
            children: [
              Container(
                width: 24,
                height: 24,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: p.gaugeDanger,
                ),
                child: Text(
                  '${i + 1}',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  point,
                  style: TextStyle(fontSize: 15, height: 1.4, color: p.ink),
                ),
              ),
            ],
          ),
      ],
    );
  });

  /// Every tracker heard, in the order they had when the sheet opened, so
  /// rows don't move under the finger as signals change.
  void _showAll(BuildContext context) {
    final order = [for (final t in viewModel.trackers) t.id];
    showAppSheet<void>(
      context,
      (sheet) => ListenableBuilder(
        listenable: viewModel,
        builder: (sheet, _) {
          final l = sheet.l10n;
          final byId = {for (final t in viewModel.trackers) t.id: t};
          final listed = [
            for (final id in order) ?byId[id],
            for (final t in viewModel.trackers)
              if (!order.contains(t.id)) t,
          ];
          return AppSheet(
            title: l.trackerAllTitle(listed.length),
            action: SoftButton(
              label: l.trackerDone,
              icon: Icons.check_rounded,
              onPressed: () => Navigator.of(sheet).pop(),
            ),
            children: [
              for (final t in listed)
                _TrackerRow(
                  trail: t,
                  viewModel: viewModel,
                  onFind: () {
                    Navigator.of(sheet).pop();
                    viewModel.find(t.id);
                  },
                  mineButton: true,
                ),
              for (final t in viewModel.mineHeard)
                _TrackerRow(trail: t, viewModel: viewModel, mineButton: true),
            ],
          );
        },
      ),
    );
  }
}

String _kindName(AppLocalizations l, TrackerKind k) => switch (k) {
  TrackerKind.airTag => 'AirTag',
  TrackerKind.findMy => l.trackerKindFindMy,
  TrackerKind.airPods => 'AirPods',
  TrackerKind.appleDevice => l.trackerKindApple,
  TrackerKind.findHub => l.trackerKindFindHub,
  TrackerKind.dult => l.trackerKindDult,
  TrackerKind.smartTag => l.trackerKindSamsung,
  TrackerKind.tile => 'Tile',
  TrackerKind.chipolo => 'Chipolo',
  TrackerKind.pebblebee => 'Pebblebee',
};

String _closeness(AppLocalizations l, Closeness c) => switch (c) {
  Closeness.close => l.trackerClose,
  Closeness.near => l.trackerNear,
  Closeness.far => l.trackerFar,
};

/// One tracker: what it is, how close, and whether it follows you; tap to
/// find it.
class _TrackerRow extends StatelessWidget {
  const _TrackerRow({
    required this.trail,
    required this.viewModel,
    this.onFind,
    this.mineButton = false,
  });

  final TrackerTrail trail;
  final TrackerViewModel viewModel;
  final VoidCallback? onFind;
  final bool mineButton;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final p = Palette.of(context);
    final follows = FollowCheck.follows(trail);
    final mine = viewModel.isMine(trail.id);
    final colour = follows ? p.gaugeDanger : p.inkStrong;
    final detail = follows
        ? l.trackerFollowingYou(trail.places.length)
        : '${viewModel.isStale(trail) ? l.trackerHeardEarlier : _closeness(l, trail.closeness)} · '
              '${l.trackerPlaces(math.max(1, trail.places.length))}';
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: mine ? null : onFind ?? () => viewModel.find(trail.id),
          child: Container(
            padding: const EdgeInsets.fromLTRB(16, 10, 8, 10),
            decoration: softSurface(p, radius: BorderRadius.circular(18)),
            child: Row(
              spacing: 12,
              children: [
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: follows ? p.gaugeDanger : p.label,
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 2,
                    children: [
                      Text(
                        _kindName(l, trail.kind),
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: colour,
                        ),
                      ),
                      Text(
                        mine ? l.trackerMine : detail,
                        style: TextStyle(
                          fontSize: 12.5,
                          color: follows ? p.gaugeDanger : p.label,
                        ),
                      ),
                    ],
                  ),
                ),
                if (mineButton)
                  TextButton(
                    onPressed: () => viewModel.toggleMine(trail.id),
                    child: Text(
                      mine ? l.trackerNotMine : l.trackerMine,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: p.ink,
                      ),
                    ),
                  )
                else
                  Icon(Icons.chevron_right_rounded, color: p.label),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// The rings: close inside, far outside. Each tracker drifts slowly round
/// its ring while scanning, so its angle clearly means nothing; a follower
/// glows red with a bead for each place it was heard. A ring has a fixed
/// number of seats; the rest share a "+n" bubble.
class _OrbitDial extends StatefulWidget {
  const _OrbitDial({required this.trackers, required this.spinning});

  final List<TrackerTrail> trackers;
  final bool spinning;

  @override
  State<_OrbitDial> createState() => _OrbitDialState();
}

class _OrbitDialState extends State<_OrbitDial>
    with SingleTickerProviderStateMixin {
  // One slow turn a minute; it runs only while scanning.
  late final _turn = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 60),
  );

  @override
  void initState() {
    super.initState();
    if (widget.spinning) _turn.repeat();
  }

  @override
  void didUpdateWidget(_OrbitDial old) {
    super.didUpdateWidget(old);
    if (widget.spinning && !_turn.isAnimating) {
      _turn.repeat();
    } else if (!widget.spinning && _turn.isAnimating) {
      _turn.stop();
    }
  }

  @override
  void dispose() {
    _turn.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final following = widget.trackers.where(FollowCheck.follows).length;
    return AnimatedBuilder(
      animation: _turn,
      builder: (context, _) => CustomPaint(
        painter: _OrbitPainter(
          palette: Palette.of(context),
          trackers: widget.trackers,
          // Ten steps a second is smooth at this slow speed and spares
          // the battery on a long check.
          turn: (_turn.value * 600).floor() / 600 * 2 * math.pi,
          scanning: widget.spinning,
          labels: [l.trackerClose, l.trackerNear, l.trackerFar],
          centre: '$following',
          centreLabel: l.trackerFollowingLabel,
          nearby: l.trackerNearby(widget.trackers.length),
        ),
        child: const SizedBox.expand(),
      ),
    );
  }
}

class _OrbitPainter extends CustomPainter {
  _OrbitPainter({
    required this.palette,
    required this.trackers,
    required this.turn,
    required this.scanning,
    required this.labels,
    required this.centre,
    required this.centreLabel,
    required this.nearby,
  });

  final Palette palette;
  final List<TrackerTrail> trackers;
  final double turn;
  final bool scanning;
  final List<String> labels;
  final String centre, centreLabel, nearby;

  /// Seats on the close, near and far rings.
  static const _seats = [3, 5, 7];

  @override
  void paint(Canvas canvas, Size size) {
    final p = palette;
    final c = size.center(Offset.zero);
    final r = math.min(size.width, size.height) / 2 - 12;
    if (r < 40) return;
    // The dial face.
    final face = Rect.fromCircle(center: c, radius: r);
    canvas
      ..drawCircle(
        c + const Offset(5, 10),
        r,
        Paint()
          ..color = p.dialShadow.withValues(alpha: p.isDark ? 0.85 : 0.5)
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 16),
      )
      ..drawCircle(
        c,
        r,
        Paint()
          ..shader = LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [p.dialLight, p.dialDark],
          ).createShader(face),
      );
    final rings = [r * 0.42, r * 0.68, r * 0.92];
    for (final (i, ring) in rings.indexed) {
      _dashed(canvas, c, ring, p.tickMinor);
      _text(canvas, labels[i], c + Offset(0, ring - 9), 10, p.label);
    }
    // A soft ripple while listening (activity, not a reading).
    if (scanning) {
      final ph = (turn * 9.5 / (2 * math.pi)) % 1;
      canvas.drawCircle(
        c,
        r * (0.3 + 0.62 * ph),
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2.5
          ..color = p.ballDark.withValues(alpha: 0.3 * (1 - ph)),
      );
    }
    for (final band in Closeness.values) {
      _ring(canvas, c, rings[band.index], band);
    }
    // The middle: how many follow, and how many are near.
    canvas.drawCircle(c, r * 0.3, Paint()..color = p.background);
    final followers = int.tryParse(centre) ?? 0;
    _text(
      canvas,
      centre,
      c + Offset(0, -r * 0.08),
      r * 0.2,
      followers > 0 ? p.gaugeDanger : p.inkStrong,
      weight: FontWeight.w800,
    );
    _text(canvas, centreLabel, c + Offset(0, r * 0.09), 11, p.label);
    _text(canvas, nearby, c + Offset(0, r * 0.19), 10, p.label);
  }

  void _ring(Canvas canvas, Offset c, double radius, Closeness band) {
    final p = palette;
    final on = trackers.where((t) => t.closeness == band).toList();
    final follow = on.where(FollowCheck.follows).toList();
    final rest = on.where((t) => !FollowCheck.follows(t)).toList();
    final free = math.max(0, _seats[band.index] - follow.length);
    final shown = rest.length > free
        ? rest.take(math.max(0, free - 1)).toList()
        : rest;
    final more = rest.length - shown.length;
    final count = follow.length + shown.length + (more > 0 ? 1 : 0);
    if (count == 0) return;
    // Each ring drifts at its own speed and way round.
    final spin = turn * const [1.0, -0.7, 0.5][band.index] + band.index * 0.6;
    var i = 0;
    Offset at(double a) => c + Offset(math.cos(a), math.sin(a)) * radius;
    for (final t in follow) {
      final a = spin + i++ * 2 * math.pi / count;
      for (var k = t.places.length; k >= 1; k--) {
        canvas.drawCircle(
          at(a - k * 0.22),
          math.max(1.5, 4.5 - k * 0.4),
          Paint()..color = p.gaugeDanger,
        );
      }
      final o = at(a);
      canvas
        ..drawCircle(
          o,
          13,
          Paint()
            ..color = p.gaugeDanger.withValues(alpha: 0.35)
            ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6),
        )
        ..drawCircle(o, 11, Paint()..color = p.gaugeDanger);
    }
    for (final _ in shown) {
      canvas.drawCircle(
        at(spin + i++ * 2 * math.pi / count),
        6.5,
        Paint()..color = p.label,
      );
    }
    if (more > 0) {
      final o = at(spin + i * 2 * math.pi / count);
      canvas
        ..drawCircle(o, 14, Paint()..color = p.dialLight)
        ..drawCircle(
          o,
          14,
          Paint()
            ..style = PaintingStyle.stroke
            ..strokeWidth = 1.5
            ..color = p.label,
        );
      _text(canvas, '+$more', o, 11.5, p.ink, weight: FontWeight.w800);
    }
  }

  void _dashed(Canvas canvas, Offset c, double radius, Color colour) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2
      ..color = colour;
    const dash = 0.03;
    for (var a = 0.0; a < 2 * math.pi; a += dash * 3) {
      canvas.drawArc(
        Rect.fromCircle(center: c, radius: radius),
        a,
        dash,
        false,
        paint,
      );
    }
  }

  void _text(
    Canvas canvas,
    String text,
    Offset centre,
    double size,
    Color colour, {
    FontWeight weight = FontWeight.w600,
  }) {
    final tp = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          fontSize: size,
          fontWeight: weight,
          fontFeatures: readoutFeatures,
          color: colour,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(canvas, centre - Offset(tp.width / 2, tp.height / 2));
  }

  @override
  bool shouldRepaint(_OrbitPainter old) =>
      old.turn != turn ||
      old.scanning != scanning ||
      old.palette != palette ||
      old.centre != centre ||
      old.nearby != nearby ||
      !_sameTrackers(old.trackers, trackers);

  /// Same trackers, rings and places: nothing to redraw.
  static bool _sameTrackers(List<TrackerTrail> a, List<TrackerTrail> b) {
    if (a.length != b.length) return false;
    for (var i = 0; i < a.length; i++) {
      if (a[i].id != b[i].id ||
          a[i].closeness != b[i].closeness ||
          a[i].places.length != b[i].places.length) {
        return false;
      }
    }
    return true;
  }
}

/// Finding one tracker: a warmer and colder gauge from its signal.
class _FindView extends StatelessWidget {
  const _FindView({required this.viewModel});

  final TrackerViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final p = Palette.of(context);
    final t = viewModel.finding;
    final heard = viewModel.findingHeard;
    final w = heard ? warmth(t!.rssi) : 0;
    final (word, colour) = !heard
        ? (l.trackerFindLost, p.label)
        : w >= 85
        ? (l.findHere, p.gaugeDanger)
        : w >= 65
        ? (l.findNear, p.gaugeCaution)
        : w >= 40
        ? (l.findCloser, p.gaugeModerate)
        : (l.findFar, p.gaugeSafe);
    final apple =
        t != null &&
        const {
          TrackerKind.airTag,
          TrackerKind.findMy,
          TrackerKind.dult,
        }.contains(t.kind);
    return Padding(
      padding: EdgeInsets.fromLTRB(24, ToolFrame.contentTop(context), 24, 8),
      child: Column(
        children: [
          Text(
            t == null ? '' : l.trackerFindTitle(_kindName(l, t.kind)),
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: p.inkStrong,
            ),
          ),
          Expanded(
            child: Semantics(
              label: '$w%, $word',
              child: CustomPaint(
                painter: _WarmthPainter(
                  palette: p,
                  warmth: w / 100,
                  colour: colour,
                ),
                child: Center(
                  child: ExcludeSemantics(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          heard ? '$w%' : '…',
                          style: TextStyle(
                            fontSize: 46,
                            fontWeight: FontWeight.w800,
                            fontFeatures: readoutFeatures,
                            color: p.inkStrong,
                          ),
                        ),
                        Text(
                          word,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: colour,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Text(
            l.trackerFindHint,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 13, height: 1.4, color: p.label),
          ),
          if (apple) ...[
            const SizedBox(height: 10),
            Text(
              l.trackerAppleSound,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 13, height: 1.4, color: p.ink),
            ),
          ],
        ],
      ),
    );
  }
}

class _WarmthPainter extends CustomPainter {
  _WarmthPainter({
    required this.palette,
    required this.warmth,
    required this.colour,
  });

  final Palette palette;
  final double warmth;
  final Color colour;

  @override
  void paint(Canvas canvas, Size size) {
    final p = palette;
    final c = size.center(Offset.zero);
    final r = math.min(size.width, size.height) / 2 - 20;
    if (r < 40) return;
    const a0 = math.pi * 0.75, sweep = math.pi * 1.5;
    final rect = Rect.fromCircle(center: c, radius: r);
    canvas.drawCircle(
      c,
      r + 16,
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [p.dialLight, p.dialDark],
        ).createShader(rect.inflate(16)),
    );
    // Bands: far green to right here red.
    final bands = [
      (0.0, 0.4, p.gaugeSafe),
      (0.4, 0.65, p.gaugeModerate),
      (0.65, 0.85, p.gaugeCaution),
      (0.85, 1.0, p.gaugeDanger),
    ];
    for (final (from, to, col) in bands) {
      canvas.drawArc(
        rect,
        a0 + sweep * from,
        sweep * (to - from),
        false,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 14
          ..color = col.withValues(alpha: 0.22),
      );
    }
    if (warmth <= 0) return;
    canvas.drawArc(
      rect,
      a0,
      sweep * warmth,
      false,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round
        ..strokeWidth = 14
        ..color = colour,
    );
    final end =
        c +
        Offset(math.cos(a0 + sweep * warmth), math.sin(a0 + sweep * warmth)) *
            r;
    canvas.drawCircle(
      end,
      11,
      Paint()
        ..shader = RadialGradient(colors: [p.ballLight, p.ballDark])
            .createShader(Rect.fromCircle(center: end, radius: 11)),
    );
  }

  @override
  bool shouldRepaint(_WarmthPainter old) =>
      old.warmth != warmth || old.colour != colour || old.palette != palette;
}
