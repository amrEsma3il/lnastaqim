import 'package:equatable/equatable.dart';

class SurahPlayerState extends Equatable {
  final bool isPlaying;
  final bool isPaused;
  // final int repeatCount;
  final bool onRepeat;
  final int surahNumber;
  final double currentPosition;
  final double surahDuration;
  final bool isSeeking;
  final List<int> searchResults; // نتائج البحث
final AudioFetchState audioState;

  const SurahPlayerState({
  required this.audioState,
    required this.isSeeking,
    required this.isPlaying,
    required this.isPaused,
    // required this.repeatCount,
    // required this.maxRepeats,
    required this.onRepeat,
    required this.surahNumber,
    required this.currentPosition,
    required this.surahDuration,
    required this.searchResults,
  });

  factory SurahPlayerState.initial() =>  SurahPlayerState(
    audioState: AudioFetchInit(),
        isSeeking: false,
        isPlaying: false,
        isPaused: false,
        // repeatCount: 0,
        // maxRepeats: 0,
        onRepeat: false,
        surahNumber: 1,
        currentPosition: 0.0,
        surahDuration: 0.0,
        searchResults: const [], // قائمة فارغة عند البداية
      );

  SurahPlayerState copyWith({
    bool? isPlaying,
    bool? isSeeking,
    bool? isPaused,
    // int? repeatCount,
    // int? maxRepeats,
      bool? onRepeat,
    int? surahNumber,
    double? currentPosition,
    double? surahDuration,
    List<int>? searchResults,
         AudioFetchState? audioState,
 // إضافة متغير جديد
  }) {
    return SurahPlayerState(
            audioState: audioState??this.audioState,

      isSeeking: isSeeking ?? this.isSeeking,
      isPlaying: isPlaying ?? this.isPlaying,
      isPaused: isPaused ?? this.isPaused,
      // repeatCount: repeatCount ?? this.repeatCount,
      // maxRepeats: maxRepeats ?? this.maxRepeats,
      onRepeat: onRepeat??this.onRepeat,
      surahNumber: surahNumber ?? this.surahNumber,
      currentPosition: currentPosition ?? this.currentPosition,
      surahDuration: surahDuration ?? this.surahDuration,
      searchResults: searchResults ?? this.searchResults, // تحديث
    );
  }

  @override
  List<Object> get props => [
        isSeeking,
        isPlaying,
        isPaused,
        // repeatCount,
        // maxRepeats,
        onRepeat,
        surahNumber,
        currentPosition,
        surahDuration,
        searchResults, 
        audioState
      ];
}







abstract class AudioFetchState{

}


class AudioFetchLoading implements AudioFetchState{

}
class AudioFetchInit implements AudioFetchState{

}




class AudioFetchFailure implements AudioFetchState{
  
}


class AudioFetchSuccess implements AudioFetchState{
  
}