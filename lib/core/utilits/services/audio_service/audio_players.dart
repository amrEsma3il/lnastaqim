import 'dart:collection';
import 'dart:developer';

import 'package:audioplayers/audioplayers.dart';

class AudioPlayers {
  static final AudioPlayers _instance = AudioPlayers._internal();
  factory AudioPlayers() => _instance;

  final Map<String, AudioPlayer> _players = HashMap();

  AudioPlayers._internal();

  AudioPlayer getPlayer(String featureName) {
    if (!_players.containsKey(featureName)) {
      _players[featureName] = AudioPlayer();
    }
    return _players[featureName]!;
  }

  Future<void> pauseAll() async {
    log("test from pause all");
    for (var player in _players.values) {
      log(player.playerId.toString());
      await player.pause();
    }
  }
}
