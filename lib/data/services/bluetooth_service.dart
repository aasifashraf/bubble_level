import 'package:flutter/services.dart';

import '../../domain/tracker.dart';

/// Where Bluetooth stands for the Tracker check.
enum BluetoothAccess {
  /// Not asked yet: explain, then ask.
  needed,

  /// Refused: point to Settings.
  denied,

  /// Allowed, but Bluetooth is switched off.
  bluetoothOff,

  /// Allowed, but Android 11 or older only scans with location on.
  locationOff,
  granted,
}

/// Listens for item trackers over Bluetooth (`Ble.kt`), only while the
/// Tracker check is open. It never connects to them, and what it hears
/// stays on the phone.
class BluetoothService {
  const BluetoothService();

  static const _channel = MethodChannel('bubble_level/bluetooth');
  static const _scan = EventChannel('bubble_level/ble_scan');
  static const _app = MethodChannel('bubble_level/app');

  Future<BluetoothAccess> check() => _ask('check');

  /// Shows the system prompt (the explanation has been read).
  Future<BluetoothAccess> request() => _ask('request');

  static Future<BluetoothAccess> _ask(String method) async {
    try {
      final name = await _channel.invokeMethod<String>(method);
      return BluetoothAccess.values.asNameMap()[name] ?? BluetoothAccess.denied;
    } on Object {
      return BluetoothAccess.denied;
    }
  }

  Future<void> openAppSettings() => _call(_app, 'openSettings');

  Future<void> openBluetoothSettings() =>
      _call(_channel, 'openBluetoothSettings');

  static Future<void> _call(MethodChannel channel, String method) async {
    try {
      await channel.invokeMethod<void>(method);
    } on Object {
      // Nothing to open; the message says where to go.
    }
  }

  /// Keeps the screen on while a check runs over a walk or drive: Android
  /// stops listening when the screen goes off.
  Future<void> keepScreenOn(bool on) async {
    try {
      await _app.invokeMethod<void>('keepScreenOn', {'on': on});
    } on Object {
      // The screen may sleep; the check pauses and says so.
    }
  }

  /// Tracker adverts as they are heard. Errors when Bluetooth can't scan.
  Stream<BleSignal> signals() => _scan.receiveBroadcastStream().map(
    (e) => signalFrom((e as Map).cast<String, Object?>()),
  );

  /// An advert as `Ble.kt` sends it.
  static BleSignal signalFrom(Map<String, Object?> m) => BleSignal(
    address: m['address']! as String,
    rssi: (m['rssi']! as num).toInt(),
    time: DateTime.fromMillisecondsSinceEpoch((m['time']! as num).toInt()),
    serviceData: {
      for (final e in ((m['service'] as Map?) ?? const {}).entries)
        e.key as String: e.value as Uint8List,
    },
    manufacturerData: {
      for (final e in ((m['manufacturer'] as Map?) ?? const {}).entries)
        e.key as int: e.value as Uint8List,
    },
  );
}
