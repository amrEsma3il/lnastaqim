import 'dart:io';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'surah_player_state.dart';

class SurahPlayerCubit extends Cubit<SurahPlayerState> {
  final AudioPlayer audioPlayer = AudioPlayer();

  SurahPlayerCubit()
      : super(SurahPlayerState.initial()) {
    audioPlayer.onPlayerStateChanged.listen((PlayerState state) {
      emit(state == PlayerState.playing
          ? this.state.copyWith(isPlaying: true)
          : this.state.copyWith(isPlaying: false));
    });

    audioPlayer.onPositionChanged.listen((Duration p) {
      emit(state.copyWith(currentPosition: p.inSeconds.toDouble()));
    });

    audioPlayer.onDurationChanged.listen((Duration d) {
      emit(state.copyWith(surahDuration: d.inSeconds.toDouble()));
    });

    audioPlayer.onPlayerComplete.listen((event) {
      if (state.repeatCount < state.maxRepeats) {
        emit(state.copyWith(repeatCount: state.repeatCount + 1));
        playSurah();
      } else {
        emit(state.copyWith(repeatCount: 0)); // Reset repeat counter
        nextSurah();
      }
    });
  }

  Future<void> playSurah() async {
    String url =
        'https://cdn.islamic.network/quran/audio-surah/128/ar.alafasy/${state.surahNumber}.mp3';

    String fileName = '${state.surahNumber}.mp3';
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String filePath = '${appDocDir.path}/$fileName';

    if (File(filePath).existsSync()) {
      await audioPlayer.play(AssetSource(filePath));
    } else {
      await Dio().download(url, filePath);
      await audioPlayer.play(AssetSource(filePath));
    }
  }

  void togglePlayPause() {
    if (state.isPlaying) {
      audioPlayer.pause();
      emit(state.copyWith(isPlaying: false, isPaused: true));
    } else {
      if (state.isPaused) {
        audioPlayer.resume();
      } else {
        playSurah();
      }
      emit(state.copyWith(isPlaying: true, isPaused: false));
    }
  }

  void nextSurah() {
    if (state.surahNumber < 114) {
      emit(state.copyWith(surahNumber: state.surahNumber + 1));
      playSurah();
    }
  }

  void previousSurah() {
    if (state.surahNumber > 1) {
      emit(state.copyWith(surahNumber: state.surahNumber - 1));
      playSurah();
    }
  }

  void toggleRepeat() {
    int newMaxRepeats = state.maxRepeats == 1 ? 2 : 1;
    emit(state.copyWith(maxRepeats: newMaxRepeats, repeatCount: 0));
  }

  void seek(double position) {
    audioPlayer.seek(Duration(seconds: position.toInt()));
    emit(state.copyWith(currentPosition: position));
  }

  void playRandomSurah() {
    final random = Random();
    int randomSurah = random.nextInt(114) + 1;
    emit(state.copyWith(surahNumber: randomSurah));
    playSurah();
  }

  @override
  Future<void> close() {
    audioPlayer.dispose();
    return super.close();
  }
}
