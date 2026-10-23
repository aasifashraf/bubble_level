import 'dart:math' as math;

import 'package:flutter/foundation.dart';

/// The Bluetooth item trackers the Tracker check knows.
enum TrackerKind {
  /// Apple AirTag.
  airTag,

  /// Another Find My accessory (Chipolo ONE Spot, and AirTag 2, which says
  /// it is one).
  findMy,

  /// AirPods away from their owner: they can be used to track someone too.
  airPods,

  /// An iPhone, iPad or Mac in Find My's offline finding. Lost ones are a
  /// common false alarm, but home-made trackers pretend to be one, so it
  /// takes much longer to count as following ([FollowRules.minTimeFor]).
  appleDevice,

  /// A Google Find Hub tag (Moto Tag, Chipolo POINT, Pebblebee for
  /// Android).
  findHub,

  /// A tracker using the joint Apple and Google standard (DULT).
  dult,

  /// A Samsung SmartTag (or, unconfirmed, another Galaxy device).
  smartTag,
  tile,
  chipolo,

  /// Pebblebee on its own network.
  pebblebee,
}

/// One Bluetooth advertisement as the phone heard it: the sender's address,
/// its signal strength (dBm), its advertising flags, and its service and
/// manufacturer data.
@immutable
class BleSignal {
  const BleSignal({
    required this.address,
    required this.rssi,
    required this.time,
    this.flags,
    this.serviceData = const {},
    this.manufacturerData = const {},
  });

  final String address;
  final int rssi;
  final DateTime time;

  /// The advert's flags byte, when it has one.
  final int? flags;

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
    this.agingCounter,
  });

  final TrackerKind kind;

  /// What stays the same while it is away from its owner: the address.
  final String id;
  final int rssi;
  final DateTime time;

  /// Away from its owner (true), next to it (false), or the tracker doesn't
  /// say (Tile, newer Chipolo, Pebblebee).
  final bool? separated;

  /// Samsung only: a count that goes up by one each time its address
  /// changes (every 15 minutes), so the new address can be linked to the
  /// old one.
  final int? agingCounter;
}

/// The trackers' own Bluetooth identifiers (sources in the research note:
/// the IETF DULT draft, Google's Find Hub spec, the SmartTag paper and
/// AirGuard).
const _dult = 'fcb2', _findHub = 'feaa', _samsung = 'fd5a';
const _tile = 'feed', _chipolo = 'fe33', _pebblebee = 'fa25';
const appleCompanyId = 0x004C;

/// The service UUIDs to filter a scan by (Apple is matched by company ID).
const trackerServiceUuids = [
  _dult,
  _findHub,
  _samsung,
  _tile,
  _chipolo,
  _pebblebee,
];

/// What [s] is, or null when it isn't a tracker (Google Find Hub phones,
/// beacons and everything else).
///
/// [now] is when it arrived by the phone's clock (the default is the
/// advert's own time).
TrackerAd? recognise(BleSignal s, {DateTime? now}) {
  TrackerAd ad(TrackerKind kind, bool? separated, {int? counter}) => TrackerAd(
    kind: kind,
    id: s.address,
    rssi: s.rssi,
    time: now ?? s.time,
    separated: separated,
    agingCounter: counter,
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
    // away from its owner for a while. Bits 4 and 5 of the status byte say
    // what it is.
    final separated = apple[1] == 0x19;
    return switch ((apple[2] & 0x30) >> 4) {
      0 => ad(TrackerKind.appleDevice, separated),
      1 => ad(TrackerKind.airTag, separated),
      2 => ad(TrackerKind.findMy, separated),
      _ => ad(TrackerKind.airPods, separated),
    };
  }

  final hub = s.serviceData[_findHub];
  if (hub != null && hub.isNotEmpty && (hub[0] == 0x40 || hub[0] == 0x41)) {
    // Phones send these frames too (advert flags 0x02; tags send 0x06).
    if (s.flags == 0x02) return null;
    // 0x41: unwanted tracking protection mode, i.e. separated.
    return ad(TrackerKind.findHub, hub[0] == 0x41);
  }

  final samsung = s.serviceData[_samsung];
  if (samsung != null && samsung.isNotEmpty && samsung[0] & 0xF8 == 0x10) {
    // State in the low 3 bits of byte 0: 1 just lost, 2 lost (over 15
    // minutes), 3 lost over a day, 4 and up connected to its owner.
    final state = samsung[0] & 0x07;
    return ad(
      TrackerKind.smartTag,
      state == 2 || state == 3,
      counter: samsung.length >= 4
          ? samsung[1] << 16 | samsung[2] << 8 | samsung[3]
          : null,
    );
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

  if (s.serviceData.containsKey(_pebblebee)) {
    return ad(TrackerKind.pebblebee, null);
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

  /// Samsung's count of address changes, to link the next address.
  int? agingCounter;

  /// Separate places it was heard at (see [FollowCheck.isNewPlace]), with
  /// how accurate each GPS fix was, metres.
  final places = <({Place place, double accuracy})>[];

  Closeness get closeness => closenessOf(rssi);
}

/// When a tracker counts as following, after AirGuard (TU Darmstadt) at
/// its "high" setting, Apple and Google: in a check the user runs.
abstract final class FollowRules {
  /// A new place must be this far from every place the tracker was heard,
  /// and further than the two GPS fixes' errors together, so GPS drift at
  /// one table can't make places. Three places mean 500 m or more moved
  /// (AirGuard asks 400 m, iPhones 840 m in 15 minutes).
  static const placeApartM = 250.0;

  /// Heard at this many places (one more for trackers that never say
  /// whether they are away from their owner, as AirGuard does for Tile)...
  static int placesFor(bool? separated) => separated == null ? 4 : 3;

  /// ...over at least this long, so a stranger's tag on the same bus for a
  /// few stops doesn't count. Apple phones and Macs take 150 minutes, as in
  /// AirGuard: lost ones caused most of its false alarms.
  static Duration minTimeFor(TrackerKind kind) =>
      kind == TrackerKind.appleDevice
      ? const Duration(minutes: 150)
      : const Duration(minutes: 30);

  /// GPS fixes worse than this (indoors) would make a still tag look like
  /// it moved; they don't count as places.
  static const worstAccuracyM = 100.0;
}

/// Every tracker heard during one check, and which follow the user.
class FollowCheck {
  final _trails = <String, TrackerTrail>{};

  /// New addresses of Samsung tags, linked to the trail they continue.
  final _aliases = <String, String>{};

  /// A lost Samsung tag takes a new address every 15 minutes and counts
  /// up by one: an unknown address whose counter is one more than a lost
  /// Samsung trail's continues that trail (as AirGuard links them). The
  /// byte order isn't documented, so either reading counts.
  String? _linkSamsung(TrackerAd ad) {
    final c = ad.agingCounter;
    if (c == null || ad.separated != true || _trails.containsKey(ad.id)) {
      return null;
    }
    int swap(int v) => (v & 0xFF) << 16 | (v & 0xFF00) | (v >> 16 & 0xFF);
    for (final t in _trails.values) {
      final prev = t.agingCounter;
      if (t.kind != TrackerKind.smartTag || prev == null) continue;
      if (c == prev + 1 || swap(c) == swap(prev) + 1) {
        _aliases[ad.id] = t.id;
        return t.id;
      }
    }
    return null;
  }

  Iterable<TrackerTrail> get trails => _trails.values;

  /// Adds [ad], heard while the phone was at [place] (null when there's no
  /// GPS fix, or it's too rough: [accuracyM] over the limit).
  void add(TrackerAd ad, {Place? place, double? accuracyM}) {
    final id = _aliases[ad.id] ?? _linkSamsung(ad) ?? ad.id;
    final known = _trails[id];
    final t = known ?? TrackerTrail(ad.kind, id, ad.time, ad.rssi * 1.0);
    _trails[id] = t;
    if (ad.agingCounter != null) t.agingCounter = ad.agingCounter;
    if (known != null) t.rssi = t.rssi * 0.7 + ad.rssi * 0.3;
    if (ad.time.isAfter(t.lastSeen)) t.lastSeen = ad.time;
    if (ad.separated != null) t.separated = ad.separated;
    if (place == null ||
        (accuracyM != null && accuracyM > FollowRules.worstAccuracyM)) {
      return;
    }
    final accuracy = accuracyM ?? FollowRules.worstAccuracyM;
    if (isNewPlace(t.places, place, accuracy)) {
      t.places.add((place: place, accuracy: accuracy));
    }
  }

  /// Whether [place], from a fix good to [accuracy] metres, is far enough
  /// from every place in [known] to be a new one.
  static bool isNewPlace(
    Iterable<({Place place, double accuracy})> known,
    Place place,
    double accuracy,
  ) => known.every(
    (k) =>
        metresBetween(k.place, place) >=
        math.max(FollowRules.placeApartM, k.accuracy + accuracy),
  );

  /// Whether [t] is travelling with the user: not with its owner, heard at
  /// enough places, over long enough.
  static bool follows(TrackerTrail t) =>
      t.separated != false &&
      t.places.length >= FollowRules.placesFor(t.separated) &&
      t.lastSeen.difference(t.firstSeen) >= FollowRules.minTimeFor(t.kind);

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

  void clear() {
    _trails.clear();
    _aliases.clear();
  }
}
