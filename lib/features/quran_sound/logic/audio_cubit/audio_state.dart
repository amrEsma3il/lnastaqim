import 'package:equatable/equatable.dart';

import '../../data/models/reciter_entity.dart';


class AudioControlState extends Equatable {
  final ReciterEntity selectedReciter;
  final int currentVerse;
  final bool isPlaying;
  final int audioRepeat;
  final PlayVerseBarStatus playVerseBarStatus;

  const AudioControlState({ required this.playVerseBarStatus,
  required this.audioRepeat,
     required this.selectedReciter,
    required this.currentVerse,
    required this.isPlaying,
  });

  factory AudioControlState.initial() {
    return  AudioControlState(
      selectedReciter:recitersInfo[0] ,
      currentVerse: 1,
      audioRepeat: 0,
      isPlaying: false, playVerseBarStatus: PlayVerseBarStatus.init,
    );
  }

  AudioControlState copyWith({
     ReciterEntity? selectedReciter,
    int? currentVerse,
    bool? isPlaying,
     int? audioRepeat,
    PlayVerseBarStatus? playVerseBarStatus
  }) {
    return AudioControlState(
      audioRepeat: audioRepeat??this.audioRepeat,
      selectedReciter: selectedReciter?? this.selectedReciter,
      currentVerse: currentVerse ?? this.currentVerse,
      isPlaying: isPlaying ?? this.isPlaying, 
      playVerseBarStatus: playVerseBarStatus??this.playVerseBarStatus,
    );
  }

  @override
  List<Object?> get props => [selectedReciter, currentVerse, isPlaying,playVerseBarStatus,audioRepeat];
}


enum PlayVerseBarStatus{
  turnOn,
  loading,
  init
}