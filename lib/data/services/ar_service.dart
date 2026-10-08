import 'dart:typed_data';

import 'package:flutter/services.dart';

import '../../domain/angles.dart';
import 'app_settings.dart' as app_settings;

/// Whether this phone can run ARCore.
enum ArSupport {
  supported,

  /// Supported, once Google Play Services for AR is installed or updated.
  install,
  unsupported,

  /// Couldn't tell (no Play Store or no network): try anyway.
  unknown,
}

/// Why tracking is struggling.
enum ArTrouble { dark, fast, plain, other }

/// AR couldn't start.
class ArStartFailed implements Exception {
  const ArStartFailed(this.reason);

  /// "install", "denied", "unsupported", "camera" or "failed".
  final String reason;
}

/// One AR camera frame: what ARCore sees and where the points are.
class ArFrame {
  const ArFrame({
    this.tracking = false,
    this.trouble,
    this.aim,
    this.points = const [],
    this.viewProj,
    this.cloud = const [],
    this.surface = false,
    this.error,
  });

  static const none = ArFrame();

  /// The phone's position is known.
  final bool tracking;
  final ArTrouble? trouble;

  /// Where the aim meets a surface; null when it meets none.
  final Vec3? aim;

  /// The tapped points, where ARCore now places them.
  final List<Vec3> points;

  /// The camera's view-projection matrix (column-major), to draw with.
  final Float32List? viewProj;

  /// Feature points ARCore is tracking, shown while it looks for surfaces.
  final List<Vec3> cloud;

  /// A flat surface has been found.
  final bool surface;

  /// The camera was lost ("camera") or AR stopped ("failed").
  final String? error;

  static List<Vec3> _vecs(Object? v) {
    if (v is! Float32List) return const [];
    return [
      for (var i = 0; i + 2 < v.length; i += 3) Vec3(v[i], v[i + 1], v[i + 2]),
    ];
  }

  factory ArFrame.fromMap(Map<Object?, Object?> m) {
    final aim = _vecs(m['aim']);
    return ArFrame(
      tracking: m['tracking'] == 'tracking',
      trouble: switch (m['reason']) {
        'dark' => ArTrouble.dark,
        'fast' => ArTrouble.fast,
        'plain' => ArTrouble.plain,
        null => null,
        _ => ArTrouble.other,
      },
      aim: aim.isEmpty ? null : aim.first,
      points: _vecs(m['points']),
      viewProj: m['viewProj'] as Float32List?,
      cloud: _vecs(m['cloud']),
      surface: m['surface'] == true,
      error: m['error'] as String?,
    );
  }
}

/// ARCore for the tape measure (Android; see ArMeasure.kt). The camera
/// picture is only shown: never recorded, saved or sent.
class ArService {
  const ArService();

  static const _channel = MethodChannel('bubble_level/ar');
  static const _frames = EventChannel('bubble_level/ar/frames');

  Future<ArSupport> support() async {
    try {
      return switch (await _channel.invokeMethod<String>('support')) {
        'supported' => ArSupport.supported,
        'install' => ArSupport.install,
        'unsupported' => ArSupport.unsupported,
        _ => ArSupport.unknown,
      };
    } on MissingPluginException {
      return ArSupport.unsupported;
    } on PlatformException {
      return ArSupport.unknown;
    }
  }

  /// Asks to install Google Play Services for AR: "installed", "requested"
  /// (the Play Store opened), "declined" or "unsupported".
  Future<String> install() async {
    try {
      return await _channel.invokeMethod<String>('install') ?? 'unsupported';
    } on PlatformException {
      return 'unsupported';
    }
  }

  Future<bool> hasCamera() async {
    try {
      return await _channel.invokeMethod<bool>('permission') ?? false;
    } on PlatformException {
      return false;
    }
  }

  /// Shows the system camera prompt; true when allowed.
  Future<bool> requestCamera() async {
    try {
      return await _channel.invokeMethod<bool>('requestPermission') ?? false;
    } on PlatformException {
      return false;
    }
  }

  /// Starts AR in a view of [width] by [height] physical pixels, aiming at
  /// ([aimX], [aimY]) as fractions of it; returns the picture's texture id.
  Future<int> start({
    required int width,
    required int height,
    required double aimX,
    required double aimY,
  }) async {
    try {
      final id = await _channel.invokeMethod<int>('start', {
        'width': width,
        'height': height,
        'aimX': aimX,
        'aimY': aimY,
      });
      if (id == null) throw const ArStartFailed('failed');
      return id;
    } on PlatformException catch (e) {
      throw ArStartFailed(e.code);
    }
  }

  Stream<ArFrame> frames() => _frames.receiveBroadcastStream().map(
    (e) => ArFrame.fromMap(e as Map<Object?, Object?>),
  );

  /// Adds a point where the aim meets a surface; false when it meets none.
  Future<bool> add() async => await _channel.invokeMethod<bool>('add') ?? false;

  Future<void> undo() => _channel.invokeMethod<void>('undo');

  Future<void> clear() => _channel.invokeMethod<void>('clear');

  Future<void> stop() async {
    try {
      await _channel.invokeMethod<void>('stop');
    } on MissingPluginException {
      // Nothing was started.
    }
  }

  Future<void> openAppSettings() => app_settings.openAppSettings();
}
