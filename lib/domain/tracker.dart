import 'dart:math' as math;

import 'package:flutter/foundation.dart';

/// The Bluetooth item trackers the Tracker check knows.
enum TrackerKind {
  /// Apple AirTag.
  airTag,

  /// Another Find My accessory (Chipolo ONE Spot, Pebblebee and others).
  findMy,

  /// A Google Find Hub tag (Chipolo POINT, Pebblebee for Android).
  findHub,

  /// A tracker using the joint Apple and Google standard (DULT).
  dult,
  smartTag,
  tile,
  chipolo,
}

/// One Bluetooth advertisement as the phone heard it: the sender's address,
/// its signal strength (dBm), and its service and manufacturer data.
@immutable
class BleSignal {
  const BleSignal({
    required this.address,
    required this.rssi,
    required this.time,
    this.serviceData = const {},
    this.manufacturerData = const {},
  });

  final String address;
  final int rssi;
  final DateTime time;

  /// By 16 bit service UUID, lower case hex ("fcb2").
  final Map<String, Uint8List> serviceData;

  /// By company ID (0x004C is Apple), without the ID bytes.
  final Map<int, Uint8List> manufacturerData;
}

/// A tracker recognised in an advertisement.
@immutable
class TrackerAd {
  const TrackerAd({
    required this.kind,
    required this.id,
    required this.rssi,
    required this.time,
    this.separated,
  });

  final TrackerKind kind;

  /// What stays the same while it is away from its owner: the address.
  final String id;
  final int rssi;
  final DateTime time;

  /// Away from its owner (true), next to it (false), or the tracker doesn't
  /// say (Tile, newer Chipolo).
  final bool? separated;
}

/// The trackers' own Bluetooth identifiers (sources in the research note:
/// the IETF DULT draft, Google's Find Hub spec, and AirGuard).
const _dult = 'fcb2', _findHub = 'feaa', _samsung = 'fd5a';
const _tile = 'feed', _chipolo = 'fe33';
const appleCompanyId = 0x004C;

/// The service UUIDs to filter a scan by (Apple is matched by company ID).
const trackerServiceUuids = [_dult, _findHub, _samsung, _tile, _chipolo];

/// What [s] is, or null when it isn't a tracker (or is an Apple phone,
/// laptop or watch, which lost devices make a common false alarm).
TrackerAd? recognise(BleSignal s) {
  TrackerAd ad(TrackerKind kind, bool? separated) => TrackerAd(
    kind: kind,
    id: s.address,
    rssi: s.rssi,
    time: s.time,
    separated: separated,
  );

  // The joint standard first: newer Apple and Google trackers send it too.
  final dult = s.serviceData[_dult];
  if (dult != null && dult.length >= 2) {
    // Byte 0 is the network, bit 0 of byte 1 is "near owner".
    return ad(TrackerKind.dult, dult[1] & 1 == 0);
  }

  final apple = s.manufacturerData[appleCompanyId];
  if (apple != null && apple.length >= 3 && apple[0] == 0x12) {
    // Find My "offline finding": a full key (length 0x19) means it has been
    // away from its owner for a while.
    final separated = apple[1] == 0x19;
    return switch ((apple[2] & 0x30) >> 4) {
      1 => ad(TrackerKind.airTag, separated),
      2 => ad(TrackerKind.findMy, separated),
      _ => null,
    };
  }

  final hub = s.serviceData[_findHub];
  if (hub != null && hub.isNotEmpty && (hub[0] == 0x40 || hub[0] == 0x41)) {
    // 0x41: unwanted tracking protection mode, i.e. separated.
    return ad(TrackerKind.findHub, hub[0] == 0x41);
  }

  final samsung = s.serviceData[_samsung];
  if (samsung != null && samsung.isNotEmpty) {
    // State in bits 5 to 7: 2 offline, 3 offline over a day, 4 and up
    // connected to its owner's phone.
    final state = samsung[0] >> 5 & 0x7;
    return ad(TrackerKind.smartTag, state == 2 || state == 3);
  }

  final tile = s.serviceData[_tile];
  if (tile != null && tile.length >= 2 && tile[0] == 2 && tile[1] == 0) {
    return ad(TrackerKind.tile, null);
  }

  final chipolo = s.serviceData[_chipolo];
  if (chipolo != null) {
    // Older firmware says whether it lost its owner; newer doesn't.
    final separated = chipolo.length >= 2 && chipolo[1] & 1 == 1;
    return ad(TrackerKind.chipolo, separated ? true : null);
  }
  return null;
}

/// Roughly how far a tracker is, from its signal strength: close, near or
/// far. Walls, pockets and bodies change the signal a lot, so never more.
enum Closeness { close, near, far }

Closeness closenessOf(double rssi) => rssi >= -62
    ? Closeness.close
    : rssi >= -78
    ? Closeness.near
    : Closeness.far;

/// The signal as a 0 to 100 "warmer, colder" figure for finding a tracker:
/// −100 dBm or weaker reads 0, −40 dBm or stronger 100.
int warmth(double rssi) => ((rssi + 100) / 60 * 100).round().clamp(0, 100);

/// A position the phone was at, from GPS.
typedef Place = ({double latitude, double longitude});

/// Metres between two places (haversine; plenty for a few hundred metres).
double metresBetween(Place a, Place b) {
  const r = 6371000.0;
  double rad(double d) => d * math.pi / 180;
  final dLat = rad(b.latitude - a.latitude);
  final dLon = rad(b.longitude - a.longitude);
  final h =
      math.pow(math.sin(dLat / 2), 2) +
      math.cos(rad(a.latitude)) *
          math.cos(rad(b.latitude)) *
          math.pow(math.sin(dLon / 2), 2);
  return 2 * r * math.asin(math.sqrt(h.toDouble()));
}

/// One tracker heard during a check: where and when, and how strong.
class TrackerTrail {
  TrackerTrail(this.kind, this.id, this.firstSeen, this.rssi)
    : lastSeen = firstSeen;

  final TrackerKind kind;
  final String id;
  final DateTime firstSeen;
  DateTime lastSeen;

  /// The signal, smoothed (dBm): one advertisement can jump by 10 dB.
  double rssi;

  /// Away from its owner, as it last said (null: it doesn't say).
  bool? separated;

  /// Separate places it was heard at, each [FollowRules.placeApartM] or
  /// more from the others.
  final places = <Place>[];

  Closeness get closeness => closenessOf(rssi);
}

/// When a tracker counts as following: as AirGuard (TU Darmstadt) does it,
/// at the setting it calls medium, but in a check the user runs.
abstract final class FollowRules {
  /// A new place must be this far from every place the tracker was heard.
  static const placeApartM = 150.0;

  /// Heard at this many places...
  static const places = 3;

  /// ...over at least this long, so a stranger's tag on the same bus for a
  /// few stops doesn't count.
  static const minTime = Duration(minutes: 30);

  /// GPS fixes worse than this (indoors) would make a still tag look like
  /// it moved; they don't count as places.
  static const worstAccuracyM = 100.0;
}

/// Every tracker heard during one check, and which follow the user.
class FollowCheck {
  final _trails = <String, TrackerTrail>{};

  Iterable<TrackerTrail> get trails => _trails.values;

  /// Adds [ad], heard while the phone was at [place] (null when there's no
  /// GPS fix, or it's too rough: [accuracyM] over the limit).
  void add(TrackerAd ad, {Place? place, double? accuracyM}) {
    final known = _trails[ad.id];
    final t = known ?? TrackerTrail(ad.kind, ad.id, ad.time, ad.rssi * 1.0);
    _trails[ad.id] = t;
    if (known != null) t.rssi = t.rssi * 0.7 + ad.rssi * 0.3;
    if (ad.time.isAfter(t.lastSeen)) t.lastSeen = ad.time;
    if (ad.separated != null) t.separated = ad.separated;
    if (place == null ||
        (accuracyM != null && accuracyM > FollowRules.worstAccuracyM)) {
      return;
    }
    if (t.places.every(
      (p) => metresBetween(p, place) >= FollowRules.placeApartM,
    )) {
      t.places.add(place);
    }
  }

  /// Whether [t] is travelling with the user: not with its owner, heard at
  /// enough places, over long enough.
  static bool follows(TrackerTrail t) =>
      t.separated != false &&
      t.places.length >= FollowRules.places &&
      t.lastSeen.difference(t.firstSeen) >= FollowRules.minTime;

  /// Followers first, then by signal (closest first), leaving out [mine]
  /// and trackers next to their owners.
  List<TrackerTrail> sorted({Set<String> mine = const {}}) {
    final list = [
      for (final t in _trails.values)
        if (!mine.contains(t.id) && t.separated != false) t,
    ];
    list.sort((a, b) {
      final f = (follows(b) ? 1 : 0) - (follows(a) ? 1 : 0);
      return f != 0 ? f : b.rssi.compareTo(a.rssi);
    });
    return list;
  }

  void clear() => _trails.clear();
}
