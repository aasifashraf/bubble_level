import 'dart:async';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

import '../../domain/tone.dart';

/// The app's two sounds: a chime when the level is reached and the metal
/// detector's tick.
abstract interface class SoundService {
  void chime();
  void tick();
}

/// Plays the sounds through the device audio. Tones are generated, not
/// bundled files.
///
/// Sounds respect the phone's silent mode (the iPhone mute switch; ringer
/// silent or vibrate on Android) and mix with other audio rather than
/// pausing music. Any audio failure is ignored: a sound is never worth
/// breaking a tool over.
class AudioSoundService implements SoundService {
  AudioSoundService();

  static final _chime = wavTone(const [
    (hz: 880, seconds: 0.11),
    (hz: 1320, seconds: 0.16),
  ], volume: 0.45);
  static final _tick = wavTone(const [(hz: 1400, seconds: 0.04)]);

  AudioPlayer? _chimePlayer, _tickPlayer;
  Future<void>? _ready;

  /// Set after the first failure: the app goes quiet rather than retrying
  /// (and logging) on every beep.
  bool _failed = false;

  Future<void> _prepare() => _ready ??= () async {
    await AudioPlayer.global.setAudioContext(
      AudioContextConfig(
        focus: AudioContextConfigFocus.mixWithOthers,
        respectSilence: true,
      ).build(),
    );
    final dir = (await getTemporaryDirectory()).path;
    _chimePlayer = await _player(File('$dir/level_chime.wav'), _chime);
    _tickPlayer = await _player(File('$dir/metal_tick.wav'), _tick);
  }();

  /// A low-latency player for [wav], written to [file] once: the fast
  /// player plays files, not in-memory bytes.
  static Future<AudioPlayer> _player(File file, Uint8List wav) async {
    await file.writeAsBytes(wav, flush: true);
    final p = AudioPlayer();
    await p.setPlayerMode(PlayerMode.lowLatency);
    await p.setReleaseMode(ReleaseMode.stop);
    await p.setSourceDeviceFile(file.path, mimeType: 'audio/wav');
    return p;
  }

  @override
  void chime() => _play(() => _chimePlayer);

  @override
  void tick() => _play(() => _tickPlayer);

  void _play(AudioPlayer? Function() player) => unawaited(() async {
    if (_failed) return;
    try {
      await _prepare();
      final p = player();
      if (p == null) return;
      await p.stop();
      await p.resume();
    } catch (e) {
      _failed = true;
      debugPrint('Sounds off: audio unavailable ($e)');
    }
  }());
}

/// Plays nothing; for tests and platforms without audio.
class SilentSoundService implements SoundService {
  const SilentSoundService();

  @override
  void chime() {}

  @override
  void tick() {}
}
