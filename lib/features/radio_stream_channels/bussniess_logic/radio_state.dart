import 'package:equatable/equatable.dart';

class RadioState extends Equatable {
  final int currentIndex;
  final int radioCatIndex; // التصنيف الحالي
  final String? playingUrl;
  final bool isPlaying;
    // final bool isLoading;

final AudioFetchState audioState;

  const RadioState({
   required this.audioState,
    // required this.isLoading,
     required this.currentIndex,
      required this.radioCatIndex,
       required this.isPlaying,
    // this.isLoading=false,
    // this.currentIndex = 0,
    // this.radioCatIndex = 0,
    
    // this.isPlaying = false,
   this.playingUrl,
  });

  factory RadioState.init()=>RadioState(audioState: AudioFetchInit(),currentIndex: 0,radioCatIndex: 0,isPlaying: false);

  RadioState copyWith({
    int? currentIndex,
    int? radioCatIndex,
    String? playingUrl,
    bool? isPlaying,
     AudioFetchState? audioState,


  }) {
    return RadioState(
      audioState: audioState??this.audioState,
      currentIndex: currentIndex ?? this.currentIndex,
      radioCatIndex: radioCatIndex ?? this.radioCatIndex,
      playingUrl: playingUrl ?? this.playingUrl,
      isPlaying: isPlaying ?? this.isPlaying,
 
    );
  }

  @override
  List<Object?> get props => [
        currentIndex,
        radioCatIndex,
        playingUrl,
        isPlaying,
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