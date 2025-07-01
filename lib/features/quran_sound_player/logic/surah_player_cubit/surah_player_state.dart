import 'package:equatable/equatable.dart';

import '../../data/models/reciter_model/reciters_model.dart';
import '../../data/repo/surah_player_repo.dart';
import 'surah_player_cubit.dart';

class SurahPlayerState extends Equatable {
  final bool isPlaying;
  final bool isPaused;
  final Set<int> downloadingSurahs;

  // final int repeatCount;
    final bool isSurahFavorite; 
  final String reciterCountry, reciterSearchQuery;
  final bool onRepeat;
  final int surahNumber;
  final Reciter reciter;
  final double currentPosition,audioSpeed;
  
  final double surahDuration;
  final bool isSeeking;
  final List<Reciter> searchReciterResults;
  final List<int> searchSurahResults; // نتائج البحث
  final AudioFetchState audioState;

  const SurahPlayerState({
    required this.downloadingSurahs,
    required this.audioSpeed,
    required this.reciterCountry,
    required this.reciterSearchQuery,
    required this.searchReciterResults,
    required this.reciter,
    required this.audioState,
    required this.isSeeking,
    required this.isPlaying,
    required this.isPaused,
        required this.isSurahFavorite,
    // required this.repeatCount,
    // required this.maxRepeats,
    required this.onRepeat,
    required this.surahNumber,
    required this.currentPosition,
    required this.surahDuration,
    required this.searchSurahResults,
  });

  factory SurahPlayerState.initial() => SurahPlayerState(
      downloadingSurahs: <int>{},
      audioState: AudioFetchInit(),
      isSeeking: false,
      isPlaying: false,
      isPaused: false,
      reciterCountry: "كل الدول",
      reciterSearchQuery: "",
       isSurahFavorite: false,
      // repeatCount: 0,
      // maxRepeats: 0,
      onRepeat: false,
      surahNumber: 1,
      audioSpeed: 1,
      reciter: Reciter(
        id: 94,
          name: "minshawi_mujawwad",
          nameArabic: "محمد صديق المنشاوي مجود",
          nationality: "مصر"),
      currentPosition: 0.0,
      surahDuration: 0.0,
      searchSurahResults:SurahPlayerCubit.quranSurahs.keys.toList(),
       searchReciterResults: SurahPlayerRepo().getAllReciters() // قائمة فارغة عند البداية
      );

  SurahPlayerState copyWith({
    bool? isPlaying,
    Set<int>? downloadingSurahs,
    bool? isSeeking,
    bool? isPaused,
    String? reciterCountry,
    String? reciterSearchQuery,
    // int? repeatCount,
    // int? maxRepeats,
    Reciter? reciter,
    bool? onRepeat,
    bool? isSurahFavorite,
    int? surahNumber,
    double? currentPosition,
    double? audioSpeed,
    double? surahDuration,
    List<int>? searchSurahResults,
    List<Reciter>? searchReciterResults,
    AudioFetchState? audioState,
    // إضافة متغير جديد
  }) {
    return SurahPlayerState(
      downloadingSurahs: downloadingSurahs ?? this.downloadingSurahs,

       isSurahFavorite: isSurahFavorite ?? this.isSurahFavorite,
        reciter: reciter ?? this.reciter,
        audioState: audioState ?? this.audioState,
        reciterCountry: reciterCountry ?? this.reciterCountry,
        reciterSearchQuery: reciterSearchQuery ?? this.reciterSearchQuery,
        isSeeking: isSeeking ?? this.isSeeking,
        isPlaying: isPlaying ?? this.isPlaying,
        isPaused: isPaused ?? this.isPaused,
        // repeatCount: repeatCount ?? this.repeatCount,
        // maxRepeats: maxRepeats ?? this.maxRepeats,
        onRepeat: onRepeat ?? this.onRepeat,
        surahNumber: surahNumber ?? this.surahNumber,
        currentPosition: currentPosition ?? this.currentPosition,
        audioSpeed: audioSpeed??this.audioSpeed,
        surahDuration: surahDuration ?? this.surahDuration,
        searchSurahResults: searchSurahResults ?? this.searchSurahResults,
        searchReciterResults:
            searchReciterResults ?? this.searchReciterResults // تحديث
        );
  }

  @override
  List<Object> get props => [
        reciter,
        reciterSearchQuery,
        reciterCountry,
        isSeeking,
        isPlaying,
        isPaused,
          isSurahFavorite,
        // repeatCount,
        // maxRepeats,
        audioSpeed,
        onRepeat,
        surahNumber,
        currentPosition,
        surahDuration,
        searchSurahResults,
        searchReciterResults,
        audioState,
        downloadingSurahs
      ];
}

abstract class AudioFetchState {}

class AudioFetchLoading implements AudioFetchState {}

class AudioFetchInit implements AudioFetchState {}

class AudioFetchFailure implements AudioFetchState {}

class AudioFetchSuccess implements AudioFetchState {}
