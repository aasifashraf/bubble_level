import 'package:flutter/widgets.dart';

import '../../../../data/repositories/sound_repository.dart';
import '../../../../data/services/microphone_service.dart';
import '../../../../domain/sound.dart';
import '../../../core/sensor_view_model.dart';

/// Where microphone access stands for the sound meter.
enum MicAccess {
  /// Finding out.
  checking,

  /// Not asked yet: explain, then ask.
  needed,

  /// Refused: point to Settings.
  denied,
  granted,
}

/// Sound meter: the level now (Slow), the average and maximum since
/// opened or reset, and what the level means for hearing. The microphone is
/// used only while the tool is open and in front.
class SoundViewModel extends ActiveViewModel {
  SoundViewModel({
    required this._repository,
    this._microphone = const MicrophoneService(),
  }) : super(_repository);

  final SoundRepository _repository;
  final MicrophoneService _microphone;

  MicAccess _access = MicAccess.checking;
  bool _refused = false;
  SoundReading? _held;
  AppLifecycleListener? _lifecycle;

  MicAccess get access => _access;

  /// The live reading, or the one held by the lock.
  SoundReading get reading => _held ?? _repository.value;

  bool get locked => _held != null;

  /// Shows the system prompt (the explanation has been read).
  Future<void> allow() async {
    final granted = await _microphone.hasPermission(request: true);
    if (!granted) _refused = true;
    _setAccess(granted ? MicAccess.granted : MicAccess.denied);
  }

  Future<void> openSettings() => _microphone.openAppSettings();

  /// Starts Average and Max again.
  void reset() => _repository.resetStats();

  /// Only a real reading can be held.
  void toggleLock() {
    final live = _repository.value;
    _held = _held == null && live.level != null ? live : null;
    notifyListeners();
  }

  /// Checks again without asking, e.g. back from Settings.
  Future<void> _check() async {
    final granted = await _microphone.hasPermission();
    if (!active) return;
    _setAccess(
      granted
          ? MicAccess.granted
          : _refused
          ? MicAccess.denied
          : MicAccess.needed,
    );
  }

  void _setAccess(MicAccess access) {
    if (!active) return;
    _access = access;
    if (access == MicAccess.granted) _repository.start();
    notifyListeners();
  }

  @override
  void onActivate() {
    _held = null;
    _access = MicAccess.checking;
    _repository.clear();
    _lifecycle = AppLifecycleListener(onResume: _check);
    _check();
  }

  @override
  void onDeactivate() {
    _lifecycle?.dispose();
    _lifecycle = null;
    _repository.stop();
  }

  @override
  void update() => notifyListeners();
}
