import 'dart:async';

typedef PausePlayback = FutureOr<void> Function();

/// Temporary bridge that guarantees only one playback surface is active while
/// features are migrated to [UnifiedAudioHandler].
class PlaybackCoordinator {
  PlaybackCoordinator._();

  static final PlaybackCoordinator instance = PlaybackCoordinator._();

  final Map<String, PausePlayback> _participants = {};
  Future<void> _pendingActivation = Future.value();
  String? _activeParticipant;

  String? get activeParticipant => _activeParticipant;

  void register(String key, PausePlayback pause) {
    _participants[key] = pause;
  }

  void unregister(String key) {
    _participants.remove(key);
    if (_activeParticipant == key) _activeParticipant = null;
  }

  Future<void> activate(String key) {
    final activation = _pendingActivation.then((_) async {
      for (final entry in _participants.entries) {
        if (entry.key != key) await entry.value();
      }
      _activeParticipant = key;
    });
    _pendingActivation = activation.catchError((_) {});
    return activation;
  }

  void markInactive(String key) {
    if (_activeParticipant == key) _activeParticipant = null;
  }

  void resetForTest() {
    _participants.clear();
    _activeParticipant = null;
    _pendingActivation = Future.value();
  }
}
