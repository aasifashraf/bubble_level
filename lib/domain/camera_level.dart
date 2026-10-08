import 'dart:math' as math;

import 'angles.dart';

/// How an upright phone, camera to a wall, sits against gravity.
typedef CameraPose = ({double rotation, double tilt, double pitch});

/// The pose for gravity on the screen's axes [g]: [rotation] is how far the
/// phone is turned in the screen's plane (0° upright, positive turned
/// counter-clockwise), less the Level's on-edge calibration [offset];
/// [tilt] is how far that is from the nearest level or plumb (so held
/// sideways works too); [pitch] is how far the top is tipped towards (+)
/// or away from the wall. Null when the phone is held too flat to tell.
CameraPose? cameraPose(Vec3 g, {double offset = 0}) {
  final len = g.length;
  if (len == 0) return null;
  final pitch = math.asin((g.z / len).clamp(-1.0, 1.0)) * 180 / math.pi;
  if (pitch.abs() > maxPitch) return null;
  final rotation = wrap180(edgeDeg(g) - offset);
  final tilt = rotation - 90 * (rotation / 90).roundToDouble();
  return (rotation: rotation, tilt: tilt, pitch: pitch);
}

/// Tipped further than this towards the floor or ceiling, the screen's turn
/// can't be told reliably from gravity.
const maxPitch = 60.0;

/// An edge marked on the picture: how far it is from true level (or, for
/// an upright edge, plumb), degrees. Positive means its right end is low.
typedef EdgeReading = ({double offset, bool plumb});

/// The edge from ([ax], [ay]) to ([bx], [by]) on the screen (pixels, y
/// down), for a phone turned [rotation]° as in [CameraPose.rotation]: on
/// screen, true level runs at [rotation]° clockwise. Null for two points on
/// top of each other.
EdgeReading? edgeReading(
  double ax,
  double ay,
  double bx,
  double by,
  double rotation,
) {
  final dx = bx - ax, dy = by - ay;
  if (dx * dx + dy * dy < 1) return null;
  final screen = math.atan2(dy, dx) * 180 / math.pi;
  // Which way round the points are doesn't matter: fold to ±90°.
  var offset = (screen - rotation + 90) % 180 - 90;
  final plumb = offset.abs() > 45;
  if (plumb) offset -= offset > 0 ? 90 : -90;
  return (offset: offset, plumb: plumb);
}
