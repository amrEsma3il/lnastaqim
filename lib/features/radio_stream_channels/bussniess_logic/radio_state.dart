import 'package:equatable/equatable.dart';

class RadioState extends Equatable {
  final int currentIndex;
  final int radioCatIndex; // التصنيف الحالي
  final String? playingUrl;
  final bool isPlaying;
    final bool isLoading;
  final String? channelTitle;
  final String? channelDescription;
  final String? channelImage;


  const RadioState({
    this.isLoading=false,
    this.currentIndex = 0,
    this.radioCatIndex = 0,
    this.playingUrl,
    this.isPlaying = false,
    this.channelTitle,
    this.channelDescription,
    this.channelImage,
  });

  RadioState copyWith({
    int? currentIndex,
    int? radioCatIndex,
    String? playingUrl,
    bool? isPlaying,
        bool? isLoading,
    String? channelTitle,
    String? channelDescription,
    String? channelImage,
  }) {
    return RadioState(
      currentIndex: currentIndex ?? this.currentIndex,
      radioCatIndex: radioCatIndex ?? this.radioCatIndex,
      playingUrl: playingUrl ?? this.playingUrl,
      isLoading: isLoading??this.isLoading,
      isPlaying: isPlaying ?? this.isPlaying,
      channelTitle: channelTitle ?? this.channelTitle,
      channelDescription: channelDescription ?? this.channelDescription,
      channelImage: channelImage ?? this.channelImage,
    );
  }

  @override
  List<Object?> get props => [
        currentIndex,
        radioCatIndex,
        playingUrl,
        isPlaying,
        isLoading,
        channelTitle,
        channelDescription,
        channelImage,
      ];
}