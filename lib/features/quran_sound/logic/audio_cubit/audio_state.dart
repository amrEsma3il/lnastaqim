import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';

import '../../../../core/constants/keys.dart';
import '../../data/models/reciter_entity.dart';


class AudioControlState extends Equatable {
  final ReciterEntity selectedReciter;
  final int currentVerse,pageNum,audioRepeat;
  final bool isPlaying;
  final PlayVerseBarStatus playVerseBarStatus;

  const AudioControlState({ required this.playVerseBarStatus,
  required this.pageNum,
  required this.audioRepeat,
     required this.selectedReciter,
    required this.currentVerse,
    required this.isPlaying,
  });

  factory AudioControlState.initial() {
    Box<ReciterEntity> box=Hive.box<ReciterEntity>(AppKeys.reciterBox);
    log(box.get(box.get(AppKeys.reciterNameKey))?.reciter??"nuuuulllllll");
    return  AudioControlState(
      selectedReciter:box.get(AppKeys.reciterNameKey)?? recitersInfo[0] ,
      currentVerse: 6222,
      audioRepeat: 0,
      isPlaying: false, playVerseBarStatus: PlayVerseBarStatus.init,
      pageNum: 604
    );
  }

  AudioControlState copyWith({
     ReciterEntity? selectedReciter,
    int? currentVerse,
    bool? isPlaying,
     int? audioRepeat,
    PlayVerseBarStatus? playVerseBarStatus,
       int? pageNum

  }) {
    return AudioControlState(
      pageNum: pageNum??this.pageNum,
      audioRepeat: audioRepeat??this.audioRepeat,
      selectedReciter: selectedReciter?? this.selectedReciter,
      currentVerse: currentVerse ?? this.currentVerse,
      isPlaying: isPlaying ?? this.isPlaying, 
      playVerseBarStatus: playVerseBarStatus??this.playVerseBarStatus,
    );
  }

  @override
  List<Object?> get props => [selectedReciter, currentVerse, isPlaying,playVerseBarStatus,audioRepeat,pageNum];
}


enum PlayVerseBarStatus{
  turnOn,
  loading,
  init
}