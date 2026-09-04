import 'dart:collection';
import 'dart:developer';

import 'package:audioplayers/audioplayers.dart';

import 'playback_coordinator.dart';

class AudioPlayers {
  static final AudioPlayers _instance = AudioPlayers._internal();
  factory AudioPlayers() => _instance;

  final Map<String, AudioPlayer> _players = HashMap();

  AudioPlayers._internal();

  AudioPlayer getPlayer(String featureName) {
    if (!_players.containsKey(featureName)) {
      _players[featureName] = AudioPlayer();
      PlaybackCoordinator.instance.register(
        featureName,
        _players[featureName]!.pause,
      );
    }
    return _players[featureName]!;
  }

  Future<void> disposePlayer(String featureName) async {
    PlaybackCoordinator.instance.unregister(featureName);
    final player = _players.remove(featureName);
    if (player != null) {
      await player.dispose();
    }
  }

  Future<void> pauseAll() async {
    log("test from pause all");
    for (var player in _players.values) {
      log(player.playerId.toString());
      await player.pause();
    }
  }
}
