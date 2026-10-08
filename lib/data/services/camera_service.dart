import 'package:camera/camera.dart';
import 'package:flutter/widgets.dart';

import 'app_settings.dart' as app_settings;

/// The camera wasn't allowed.
class CameraDenied implements Exception {
  const CameraDenied();
}

/// There's no camera to use (none fitted, or it failed to start).
class CameraMissing implements Exception {
  const CameraMissing();
}

/// A start is already asking for the camera; this one gives way to it.
class CameraBusy implements Exception {
  const CameraBusy();
}

/// A running back camera: its live picture and light.
abstract class CameraFeed {
  /// The live picture, upright as the user sees it.
  Widget get preview;

  /// The picture's width over its height, upright in portrait.
  double get aspectRatio;

  /// Holds or releases the picture.
  Future<void> setFrozen(bool frozen);

  /// Turns the light on or off; false when it can't.
  Future<bool> setTorch(bool on);

  Future<void> dispose();
}

/// The back camera, for the camera level. The picture is only shown: never
/// recorded, saved or sent, and there's no sound.
class CameraService {
  const CameraService();

  /// Starts the back camera (asking for permission the first time). Throws
  /// [CameraDenied] when not allowed and [CameraMissing] when there's none.
  Future<CameraFeed> open() async {
    final List<CameraDescription> cameras;
    try {
      cameras = await availableCameras();
    } on Object {
      throw const CameraMissing();
    }
    if (cameras.isEmpty) throw const CameraMissing();
    final back = cameras.firstWhere(
      (c) => c.lensDirection == CameraLensDirection.back,
      orElse: () => cameras.first,
    );
    final controller = CameraController(
      back,
      ResolutionPreset.high,
      enableAudio: false,
    );
    try {
      await controller.initialize();
    } on CameraException catch (e) {
      await controller.dispose();
      if (e.code.startsWith('CameraAccess')) throw const CameraDenied();
      // Another start is already asking: not a missing camera.
      if (e.code == 'CameraPermissionsRequestOngoing') {
        throw const CameraBusy();
      }
      throw const CameraMissing();
    } on Object {
      await controller.dispose();
      throw const CameraMissing();
    }
    return _ControllerFeed(controller);
  }

  Future<void> openAppSettings() => app_settings.openAppSettings();
}

class _ControllerFeed implements CameraFeed {
  _ControllerFeed(this._controller);

  final CameraController _controller;

  @override
  Widget get preview => CameraPreview(_controller);

  /// The controller reports it sideways (the sensor's landscape shape).
  @override
  double get aspectRatio => 1 / _controller.value.aspectRatio;

  @override
  Future<void> setFrozen(bool frozen) async {
    try {
      frozen
          ? await _controller.pausePreview()
          : await _controller.resumePreview();
    } on Object {
      // Not every camera can pause; the reading is held anyway.
    }
  }

  @override
  Future<bool> setTorch(bool on) async {
    try {
      await _controller.setFlashMode(on ? FlashMode.torch : FlashMode.off);
      return true;
    } on Object {
      return false;
    }
  }

  @override
  Future<void> dispose() => _controller.dispose();
}
