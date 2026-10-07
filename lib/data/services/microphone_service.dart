import 'dart:async';

import 'package:flutter/services.dart';
import 'package:record/record.dart';

import '../../domain/sound.dart';
import 'motion_sensor_service.dart';

/// The microphone, for the sound meter. Audio stays in memory: each block
/// is reduced to its energy and dropped, never recorded, saved or sent.
class MicrophoneService {
  const MicrophoneService();

  /// The record package's default rate.
  static const _sampleRate = 44100;
  static const _app = MethodChannel('bubble_level/app');

  /// Completes when the last recorder has stopped and been released.
  static Future<void> _released = Future.value();

  /// Whether the app may use the microphone; with [request], asks first.
  Future<bool> hasPermission({bool request = false}) async {
    final recorder = AudioRecorder();
    try {
      return await recorder.hasPermission(request: request);
    } on Object {
      return false;
    } finally {
      await recorder.dispose();
    }
  }

  /// Opens this app's page in the phone's Settings (to allow the
  /// microphone after it was refused).
  Future<void> openAppSettings() async {
    try {
      await _app.invokeMethod<void>('openSettings');
    } on PlatformException {
      // Nothing to open; the message already says where to go.
    } on MissingPluginException {
      // Same.
    }
  }

  /// The mean square (0 to 1) of each 100 ms block of sound while listened
  /// to; an error when the microphone can't be used.
  Stream<ScalarSample> levels() {
    AudioRecorder? recorder;
    final blocks = Pcm16Blocks(_sampleRate ~/ 10);
    StreamSubscription<Uint8List>? pcm;
    late final StreamController<ScalarSample> out;
    out = StreamController<ScalarSample>(
      onListen: () async {
        try {
          await _released;
          if (out.isClosed || !out.hasListener) return;
          final r = recorder = AudioRecorder();
          final stream = await r.startStream(
            const RecordConfig(
              encoder: AudioEncoder.pcm16bits,
              numChannels: 1,
              // Don't take audio focus: music playing on the phone keeps
              // playing (and can be measured).
              audioInterruption: AudioInterruptionMode.none,
              // No automatic gain or noise suppression: they would
              // flatten the very levels being measured.
              androidConfig: AndroidRecordConfig(
                audioSource: AndroidAudioSource.voiceRecognition,
              ),
            ),
          );
          pcm = stream.listen(
            (bytes) {
              for (final meanSquare in blocks.add(bytes)) {
                out.add((value: meanSquare, timestamp: DateTime.now()));
              }
            },
            onError: out.addError,
            onDone: out.close,
          );
        } on Object catch (e) {
          out.addError(e);
        }
      },
      onCancel: () => _released = () async {
        await pcm?.cancel();
        final r = recorder;
        if (r == null) return;
        try {
          await r.stop();
        } on Object {
          // Already stopped.
        }
        await r.dispose();
      }(),
    );
    return out.stream;
  }
}
