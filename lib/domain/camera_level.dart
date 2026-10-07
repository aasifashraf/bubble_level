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
