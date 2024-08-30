import 'package:equatable/equatable.dart';

class SurahPlayerState extends Equatable {
  final bool isPlaying;
  final bool isPaused;
  final int repeatCount;
  final int maxRepeats;
  final int surahNumber;
  final double currentPosition;
  final double surahDuration;

  const SurahPlayerState({
    required this.isPlaying,
    required this.isPaused,
    required this.repeatCount,
    required this.maxRepeats,
    required this.surahNumber,
    required this.currentPosition,
    required this.surahDuration,
  });


factory SurahPlayerState.initial()=>const SurahPlayerState(
          isPlaying: false,
          isPaused: false,
          repeatCount: 0,
          maxRepeats: 1,
          surahNumber: 1,
          currentPosition: 0.0,
          surahDuration: 0.0,
        );
  SurahPlayerState copyWith({
    bool? isPlaying,
    bool? isPaused,
    int? repeatCount,
    int? maxRepeats,
    int? surahNumber,
    double? currentPosition,
    double? surahDuration,
  }) {
    return SurahPlayerState(
      isPlaying: isPlaying ?? this.isPlaying,
      isPaused: isPaused ?? this.isPaused,
      repeatCount: repeatCount ?? this.repeatCount,
      maxRepeats: maxRepeats ?? this.maxRepeats,
      surahNumber: surahNumber ?? this.surahNumber,
      currentPosition: currentPosition ?? this.currentPosition,
      surahDuration: surahDuration ?? this.surahDuration,
    );
  }

  @override
  List<Object> get props => [
        isPlaying,
        isPaused,
        repeatCount,
        maxRepeats,
        surahNumber,
        currentPosition,
        surahDuration,
      ];
}
