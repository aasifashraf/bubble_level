import 'dart:typed_data';

import 'package:bubble_level/domain/tracker.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final t0 = DateTime(2026, 10, 22, 9);

  BleSignal signal({
    String address = 'AA:BB:CC:DD:EE:01',
    int rssi = -60,
    DateTime? time,
    Map<String, List<int>> service = const {},
    Map<int, List<int>> manufacturer = const {},
  }) => BleSignal(
    address: address,
    rssi: rssi,
    time: time ?? t0,
    serviceData: {
      for (final e in service.entries) e.key: Uint8List.fromList(e.value),
    },
    manufacturerData: {
      for (final e in manufacturer.entries) e.key: Uint8List.fromList(e.value),
    },
  );

  group('recognise', () {
    test('Apple: AirTag and Find My accessory, separated by the full key', () {
      final away = recognise(
        signal(
          manufacturer: {
            appleCompanyId: [0x12, 0x19, 0x10, 1, 2],
          },
        ),
      )!;
      expect(away.kind, TrackerKind.airTag);
      expect(away.separated, isTrue);
      final near = recognise(
        signal(
          manufacturer: {
            appleCompanyId: [0x12, 0x02, 0x20],
          },
        ),
      )!;
      expect(near.kind, TrackerKind.findMy);
      expect(near.separated, isFalse);
    });

    test('Apple: AirPods and Apple devices too; other Apple adverts are '
        'not trackers', () {
      final pods = recognise(
        signal(
          manufacturer: {
            appleCompanyId: [0x12, 0x19, 0x30],
          },
        ),
      )!;
      expect(pods.kind, TrackerKind.airPods);
      expect(pods.separated, isTrue);
      expect(
        recognise(
          signal(
            manufacturer: {
              appleCompanyId: [0x12, 0x19, 0x00],
            },
          ),
        )!.kind,
        TrackerKind.appleDevice,
      );
      // Nearby, Handoff and other Apple adverts.
      expect(
        recognise(
          signal(
            manufacturer: {
              appleCompanyId: [0x10, 0x05, 0x01],
            },
          ),
        ),
        isNull,
      );
      // Cut short.
      expect(
        recognise(
          signal(
            manufacturer: {
              appleCompanyId: [0x12],
            },
          ),
        ),
        isNull,
      );
    });

    test('the joint standard: bit 0 of the second byte is "near owner"', () {
      expect(
        recognise(
          signal(
            service: {
              'fcb2': [0x01, 0x00],
            },
          ),
        )!.separated,
        isTrue,
      );
      expect(
        recognise(
          signal(
            service: {
              'fcb2': [0x01, 0x01],
            },
          ),
        )!.separated,
        isFalse,
      );
      expect(
        recognise(
          signal(
            service: {
              'fcb2': [0x01, 0x00],
            },
          ),
        )!.kind,
        TrackerKind.dult,
      );
    });

    test('Google Find Hub: 0x41 is the separated (protection) frame', () {
      expect(
        recognise(
          signal(
            service: {
              'feaa': [0x41, 9],
            },
          ),
        )!.separated,
        isTrue,
      );
      expect(
        recognise(
          signal(
            service: {
              'feaa': [0x40, 9],
            },
          ),
        )!.separated,
        isFalse,
      );
      // Other Eddystone frames (beacons) are not trackers.
      expect(
        recognise(
          signal(
            service: {
              'feaa': [0x10, 9],
            },
          ),
        ),
        isNull,
      );
      // Phones send these frames too; their advert flags say so.
      expect(
        recognise(
          BleSignal(
            address: 'x',
            rssi: -60,
            time: t0,
            flags: 0x02,
            serviceData: {
              'feaa': Uint8List.fromList([0x41, 9]),
            },
          ),
        ),
        isNull,
      );
    });

    test('Samsung: state in the low 3 bits; lost is separated, just lost '
        'or connected is not; other Samsung adverts are ignored', () {
      bool? state(int s) => recognise(
        signal(
          service: {
            'fd5a': [0x10 | s, 0, 0, 1],
          },
        ),
      )!.separated;
      expect(state(2), isTrue);
      expect(state(3), isTrue);
      expect(state(1), isFalse);
      expect(state(5), isFalse);
      // The paper's example byte, 0x15: connected.
      expect(
        recognise(
          signal(
            service: {
              'fd5a': [0x15],
            },
          ),
        )!.separated,
        isFalse,
      );
      expect(
        recognise(
          signal(
            service: {
              'fd5a': [0x45, 0, 0, 1],
            },
          ),
        ),
        isNull,
      );
      expect(recognise(signal(service: {'fd5a': <int>[]})), isNull);
      expect(
        recognise(
          signal(
            service: {
              'fd5a': [0x12, 0x00, 0x01, 0x02],
            },
          ),
        )!.agingCounter,
        0x000102,
      );
    });

    test('Tile and Chipolo: Tile never says; old Chipolo does', () {
      final tile = recognise(
        signal(
          service: {
            'feed': [2, 0, 7],
          },
        ),
      )!;
      expect(tile.kind, TrackerKind.tile);
      expect(tile.separated, isNull);
      expect(
        recognise(
          signal(
            service: {
              'feed': [1, 0],
            },
          ),
        ),
        isNull,
      );
      expect(
        recognise(
          signal(
            service: {
              'fe33': [0, 1],
            },
          ),
        )!.separated,
        isTrue,
      );
      expect(
        recognise(
          signal(
            service: {
              'fe33': [0, 0],
            },
          ),
        )!.separated,
        isNull,
      );
    });

    test('Pebblebee on its own network', () {
      expect(
        recognise(
          signal(
            service: {
              'fa25': [1, 2],
            },
          ),
        )!.kind,
        TrackerKind.pebblebee,
      );
    });

    test('anything else is ignored', () {
      expect(recognise(signal()), isNull);
      expect(
        recognise(
          signal(
            manufacturer: {
              0x0075: [1, 2, 3],
            },
          ),
        ),
        isNull,
      );
    });
  });

  test('closeness and warmth come from the signal only', () {
    expect(closenessOf(-50), Closeness.close);
    expect(closenessOf(-70), Closeness.near);
    expect(closenessOf(-90), Closeness.far);
    expect(warmth(-100), 0);
    expect(warmth(-40), 100);
    expect(warmth(-70), 50);
    expect(warmth(-20), 100);
  });

  test('metres between places', () {
    const a = (latitude: 34.0, longitude: 74.8);
    const b = (latitude: 34.001, longitude: 74.8);
    expect(metresBetween(a, b), closeTo(111, 1));
  });

  group('FollowCheck', () {
    // A tag in the user's bag, heard as they move 330 m every 10 minutes.
    TrackerAd tag(Duration at, {int rssi = -60, bool? separated = true}) =>
        TrackerAd(
          kind: TrackerKind.airTag,
          id: 'tag',
          rssi: rssi,
          time: t0.add(at),
          separated: separated,
        );
    Place at(int step) => (latitude: 34.0 + step * 0.003, longitude: 74.8);

    test('a tag heard at 3 places over 30 minutes follows', () {
      final check = FollowCheck();
      for (var i = 0; i <= 3; i++) {
        check.add(tag(Duration(minutes: 10 * i)), place: at(i));
      }
      final t = check.trails.single;
      expect(t.places, hasLength(4));
      expect(FollowCheck.follows(t), isTrue);
    });

    test('3 places in under 30 minutes is not enough (the same bus)', () {
      final check = FollowCheck();
      for (var i = 0; i <= 3; i++) {
        check.add(tag(Duration(minutes: 5 * i)), place: at(i));
      }
      expect(FollowCheck.follows(check.trails.single), isFalse);
    });

    test('staying put for an hour is one place, so it never follows', () {
      final check = FollowCheck();
      for (var i = 0; i <= 6; i++) {
        check.add(tag(Duration(minutes: 10 * i)), place: at(0));
      }
      expect(check.trails.single.places, hasLength(1));
      expect(FollowCheck.follows(check.trails.single), isFalse);
    });

    test('places closer than 250 m count once; rough fixes not at all', () {
      final check = FollowCheck();
      check
        ..add(tag(Duration.zero), place: (latitude: 34.0, longitude: 74.8))
        ..add(
          tag(const Duration(minutes: 10)),
          place: (latitude: 34.001, longitude: 74.8), // 111 m
        )
        ..add(
          tag(const Duration(minutes: 20)),
          place: at(5),
          accuracyM: 400, // indoors
        );
      expect(check.trails.single.places, hasLength(1));
    });

    test(
      'a tag next to its owner never follows; one that does not say can',
      () {
        final near = FollowCheck();
        final unknown = FollowCheck();
        for (var i = 0; i <= 3; i++) {
          near.add(
            tag(Duration(minutes: 10 * i), separated: false),
            place: at(i),
          );
          unknown.add(
            tag(Duration(minutes: 10 * i), separated: null),
            place: at(i),
          );
        }
        expect(FollowCheck.follows(near.trails.single), isFalse);
        expect(FollowCheck.follows(unknown.trails.single), isTrue);
      },
    );

    test('sorted: followers first, then closest; mine and near owner left '
        'out', () {
      final check = FollowCheck();
      TrackerAd ad(String id, int rssi, {bool? separated = true}) => TrackerAd(
        kind: TrackerKind.tile,
        id: id,
        rssi: rssi,
        time: t0,
        separated: separated,
      );
      check
        ..add(ad('far', -90))
        ..add(ad('close', -50))
        ..add(ad('owner', -40, separated: false))
        ..add(ad('mine', -45));
      for (var i = 0; i <= 3; i++) {
        check.add(tag(Duration(minutes: 10 * i), rssi: -95), place: at(i));
      }
      expect(check.sorted(mine: {'mine'}).map((t) => t.id), [
        'tag',
        'close',
        'far',
      ]);
    });

    test('two fixes must be further apart than both their errors', () {
      const a = (latitude: 34.0, longitude: 74.8);
      const b = (latitude: 34.0027, longitude: 74.8); // 300 m
      expect(FollowCheck.isNewPlace([(place: a, accuracy: 10)], b, 10), isTrue);
      expect(FollowCheck.isNewPlace([(place: a, accuracy: 90)], b, 90), isTrue);
      // 160 m apart, each 90 m out: could be the same spot.
      const c = (latitude: 34.00144, longitude: 74.8);
      expect(
        FollowCheck.isNewPlace([(place: a, accuracy: 90)], c, 90),
        isFalse,
      );
    });

    test('a Samsung tag taking a new address every 15 minutes stays one '
        'trail, linked by its counter (either byte order)', () {
      for (final (first, second) in [
        ([0x12, 0x00, 0x00, 0x07], [0x12, 0x00, 0x00, 0x08]),
        ([0x12, 0x07, 0x00, 0x00], [0x12, 0x08, 0x00, 0x00]),
      ]) {
        final check = FollowCheck();
        for (var i = 0; i <= 3; i++) {
          check.add(
            recognise(
              signal(
                address: i < 2 ? 'S1' : 'S2',
                time: t0.add(Duration(minutes: 11 * i)),
                service: {'fd5a': i < 2 ? first : second},
              ),
            )!,
            place: at(i),
          );
        }
        expect(check.trails, hasLength(1));
        expect(FollowCheck.follows(check.trails.single), isTrue);
      }
    });

    test('a tracker that never says it is away needs a 4th place; an Apple '
        'phone or Mac needs 150 minutes', () {
      TrackerAd ad(TrackerKind kind, int minutes, {bool? separated = true}) =>
          TrackerAd(
            kind: kind,
            id: kind.name,
            rssi: -60,
            time: t0.add(Duration(minutes: minutes)),
            separated: separated,
          );
      final tile = FollowCheck();
      final mac = FollowCheck();
      for (var i = 0; i <= 2; i++) {
        tile.add(ad(TrackerKind.tile, 15 * i, separated: null), place: at(i));
        mac.add(ad(TrackerKind.appleDevice, 30 * i), place: at(i));
      }
      expect(FollowCheck.follows(tile.trails.single), isFalse);
      expect(FollowCheck.follows(mac.trails.single), isFalse);
      tile.add(ad(TrackerKind.tile, 45, separated: null), place: at(3));
      mac.add(ad(TrackerKind.appleDevice, 150), place: at(3));
      expect(FollowCheck.follows(tile.trails.single), isTrue);
      expect(FollowCheck.follows(mac.trails.single), isTrue);
    });

    test('the signal is smoothed, so one odd reading barely moves it', () {
      final check = FollowCheck()
        ..add(tag(Duration.zero))
        ..add(tag(const Duration(seconds: 1), rssi: -90));
      expect(check.trails.single.rssi, closeTo(-69, 0.01));
    });
  });
}
