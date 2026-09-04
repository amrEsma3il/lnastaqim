import 'dart:async';
import 'dart:developer' as dev;
import 'dart:io';
import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/images.dart';
import '../../../core/utilits/functions/format_text.dart';
import '../../../core/utilits/functions/toast_message.dart';
import '../../../core/utilits/services/audio_service/ibtihal_playback_service.dart';
import '../../../core/utilits/services/audio_service/players_key.dart';
import '../../../core/utilits/services/audio_service/surah_playback_service.dart';
import '../../../core/utilits/services/audio_service/unified_audio_handler.dart';
import '../../../core/utilits/services/local_notification_service.dart';
import '../../share/views/widgets/share_fun.dart';
import '../data/models/ibtihal_info.dart';
import '../data/models/reciter_ibtihal_model/reciter_ibtihal_model.dart';
import '../data/repo/ibtihal_player_repo.dart';
import 'ibtihal_queue_builder.dart';

typedef IbtihalQueueBuilder =
    Future<List<IbtihalPlaybackItem>> Function({
      required Directory documentsDirectory,
      required ReciterIbtihalModel reciter,
    });

typedef IbtihalErrorPresenter = void Function(String message);

// Cubit
class IbtihalatPlayerCubit extends Cubit<IbtihalatPlayerState> {
  final IbtihalatPlayerRepo ibtihalatPlayerRepo;
  final IbtihalPlaybackService _playbackService;
  final Future<Directory> Function() _documentsDirectoryProvider;
  final IbtihalQueueBuilder _queueBuilder;
  final IbtihalErrorPresenter _errorPresenter;
  StreamSubscription<SurahPlaybackSnapshot>? _snapshotSubscription;
  bool _handlingCompletion = false;

  static IbtihalatPlayerCubit get(BuildContext context) =>
      BlocProvider.of<IbtihalatPlayerCubit>(context);

  IbtihalatPlayerCubit(
    this.ibtihalatPlayerRepo, {
    IbtihalPlaybackService? playbackService,
    Future<Directory> Function()? documentsDirectoryProvider,
    IbtihalQueueBuilder? queueBuilder,
    IbtihalErrorPresenter? errorPresenter,
  }) : _playbackService = playbackService ?? AudioServices.handler,
       _documentsDirectoryProvider =
           documentsDirectoryProvider ?? getApplicationDocumentsDirectory,
       _queueBuilder = queueBuilder ?? buildIbtihalPlaybackQueue,
       _errorPresenter =
           errorPresenter ??
           ((message) => showToast(message, AppColor.blueTint2)),
       super(IbtihalatPlayerState.initial()) {
    _snapshotSubscription = _playbackService.snapshots.listen(_applySnapshot);
  }

  static const Map<String, String> recitersCountries = {
    "كل الدول": AppImages.earthFlag,
    "مصر": AppImages.egyptFlag,
  };

  static List<double> audioSpeedRates = [0.5, 0.75, 1, 1.25, 1.75, 2];

  String get _selectedMediaId =>
      'ibtihal:${state.reciter.name}:${state.ibtihalNumber}';

  void _applySnapshot(SurahPlaybackSnapshot snapshot) {
    final prefix = 'ibtihal:${state.reciter.name}:';
    if (snapshot.itemId != null && !snapshot.itemId!.startsWith(prefix)) return;
    if (snapshot.itemId != null &&
        snapshot.itemId != _selectedMediaId &&
        snapshot.processingState == SurahProcessingState.idle) {
      return;
    }

    final selectedIndex =
        snapshot.itemId == null
            ? null
            : int.tryParse(snapshot.itemId!.split(':').last);
    final duration = snapshot.duration;
    final position = clampSurahPlaybackPosition(snapshot.position, duration);
    final audioState =
        snapshot.processingState == SurahProcessingState.error
            ? AudioFetchFailure(
              _failureMessage(snapshot.error),
              type: _failureType(snapshot.error),
            )
            : switch (snapshot.processingState) {
              SurahProcessingState.loading ||
              SurahProcessingState.buffering => AudioFetchLoading(),
              SurahProcessingState.ready ||
              SurahProcessingState.completed => AudioFetchSuccess(),
              _ => state.audioState,
            };

    emit(
      state.copyWith(
        ibtihalNumber: selectedIndex,
        isPlaying: snapshot.playing,
        isPaused:
            !snapshot.playing &&
            snapshot.processingState == SurahProcessingState.ready,
        currentPosition:
            state.isSeeking
                ? state.currentPosition
                : position.inMilliseconds / 1000,
        ibtihalDuration:
            duration == null
                ? state.ibtihalDuration
                : duration.inMilliseconds / 1000,
        audioState: audioState,
      ),
    );

    if (snapshot.processingState == SurahProcessingState.completed) {
      unawaited(_handleCompletion());
    }
  }

  Future<void> _handleCompletion() async {
    if (_handlingCompletion) return;
    _handlingCompletion = true;
    try {
      if (state.onRepeat) {
        await playIbtihal(initialPosition: Duration.zero);
      } else if (state.isRandom) {
        await playRandomIbtihal();
      } else {
        await nextIbtihal();
      }
    } finally {
      _handlingCompletion = false;
    }
  }

  static String formatDuration(int seconds) {
    final hours = seconds ~/ 3600;
    final minutes = ((seconds % 3600) ~/ 60).toString().padLeft(2, '0');
    final secs = (seconds % 60).toString().padLeft(2, '0');
    if (hours > 0) {
      return "${hours.toString().padLeft(2, '0')}:$minutes:$secs";
    }
    return "$minutes:$secs";
  }

  List<ReciterIbtihalModel> getAllReciters() {
    return ibtihalatPlayerRepo.getAllReciters();
  }

  //here
  Future<void> playIbtihal({int? ibtihalNum, Duration? initialPosition}) async {
    emit(state.copyWith(audioState: AudioFetchLoading()));
    try {
      final index = ibtihalNum ?? state.ibtihalNumber;
      if (state.reciter.info.isEmpty ||
          index < 0 ||
          index >= state.reciter.info.length) {
        throw const SurahPlaybackFailure(
          SurahPlaybackFailureType.invalidSelection,
          'اختيار الابتهال أو المبتهل غير صالح.',
        );
      }
      final directory = await _documentsDirectoryProvider();
      final items = await _queueBuilder(
        documentsDirectory: directory,
        reciter: state.reciter,
      );
      await _playbackService.loadIbtihalQueueAndPlay(
        items,
        index,
        initialPosition:
            initialPosition ??
            Duration(milliseconds: (state.currentPosition * 1000).round()),
      );
    } catch (error) {
      await _handlePlaybackFailure(error);
    }
  }

  //here
  Future<void> togglePlayPause() async {
    if (state.isPlaying) {
      await _playbackService.pause();
    } else if (state.isPaused &&
        _playbackService.currentSnapshot.itemId == _selectedMediaId) {
      await _playbackService.play();
    } else {
      await playIbtihal();
    }
  }

  //here
  Future<void> nextIbtihal({bool isFromUserHitAction = false}) async {
    if (state.ibtihalNumber < state.reciter.info.length - 1) {
      await _playbackService.stop();
      emit(
        state.copyWith(
          ibtihalNumber: state.ibtihalNumber + 1,
          currentPosition: 0,
          isPlaying: false,
          isPaused: false,
          audioState: AudioFetchInit(),
        ),
      );
      toggleFavorite();
      if (!isFromUserHitAction) {
        await playIbtihal(initialPosition: Duration.zero);
      }
    }
  }

  //here
  Future<void> previousIbtihal() async {
    await _playbackService.stop();
    if (state.ibtihalNumber > 0) {
      emit(
        state.copyWith(
          ibtihalNumber: state.ibtihalNumber - 1,
          isPlaying: false,
          isPaused: false,
          currentPosition: 0,
          audioState: AudioFetchInit(),
        ),
      );
      toggleFavorite();
    }
  }

  //here
  Future<void> changeIbtihalNum(int ibtihalNumber) async {
    if (state.ibtihalNumber != ibtihalNumber) {
      await _playbackService.stop();
      emit(
        state.copyWith(
          isPlaying: false,
          isPaused: false,
          currentPosition: 0,
          ibtihalNumber: ibtihalNumber,
          audioState: AudioFetchInit(),
        ),
      );
    }
    toggleFavorite();
  }

  //here
  Future<void> changeReciter(ReciterIbtihalModel reciter) async {
    if (state.reciter.name != reciter.name) {
      await _playbackService.stop();
      emit(
        state.copyWith(
          isPlaying: false,
          isPaused: false,
          currentPosition: 0,
          reciter: reciter,
          ibtihalNumber: 0,
          searchIbtihalResults: List.generate(
            reciter.info.length,
            (index) => index,
          ),
          audioState: AudioFetchInit(),
        ),
      );
    }
    toggleFavorite();
  }

  //here
  void toggleRepeat() {
    emit(state.copyWith(onRepeat: !state.onRepeat));
  }

  //here
  Future<void> seek(double position) async {
    dev.log("Seeking to position: ${position.toInt()}");
    emit(
      state.copyWith(
        isSeeking: true,
        currentPosition: position,
        audioState: state.isPlaying ? AudioFetchLoading() : state.audioState,
      ),
    );
    try {
      if (state.audioState is AudioFetchSuccess ||
          state.isPlaying ||
          state.isPaused) {
        await _playbackService.seek(
          Duration(milliseconds: (position * 1000).round()),
        );
        dev.log("Seek completed to position: ${position.toInt()}");
      } else {
        dev.log("Storing seek position for later, audio not initialized");
        // Audio not initialized, just update position for when play starts
      }
      emit(
        state.copyWith(
          isSeeking: false,
          audioState: state.isPlaying ? AudioFetchSuccess() : state.audioState,
        ),
      );
    } catch (error) {
      await _handlePlaybackFailure(error);
      emit(state.copyWith(isSeeking: false));
    }
  }

  //here
  void changeAudioPosition(double value) {
    emit(state.copyWith(currentPosition: value));
  }

  //here
  void sliderSeekToggle({required bool isSeeking}) {
    emit(state.copyWith(isSeeking: isSeeking));
  }

  //here
  Future<void> playRandomIbtihal() async {
    final random = Random();
    int randomIbtihal = random.nextInt(state.reciter.info.length);
    emit(state.copyWith(ibtihalNumber: randomIbtihal, currentPosition: 0));
    await playIbtihal();
  }

  //here
  void changeRandomStatus() async {
    emit(state.copyWith(isRandom: !state.isRandom));
  }

  Future<void> setPlaybackRate(double rate) async {
    emit(state.copyWith(audioSpeed: rate));
    try {
      await _playbackService.setSpeed(rate);
    } catch (error) {
      await _handlePlaybackFailure(error);
    }
  }

  Future<void> _handlePlaybackFailure(Object error) async {
    final failure =
        error is SurahPlaybackFailure
            ? error
            : normalizeSurahPlaybackFailure(error);
    try {
      await _playbackService.stop();
    } catch (_) {
      // Preserve the original playback failure.
    }
    final message = _failureMessage(failure);
    _errorPresenter(message);
    if (!isClosed) {
      emit(
        state.copyWith(
          isPlaying: false,
          isPaused: false,
          audioState: AudioFetchFailure(message, type: failure.type),
        ),
      );
    }
  }

  SurahPlaybackFailureType _failureType(Object? error) =>
      error is SurahPlaybackFailure
          ? error.type
          : SurahPlaybackFailureType.player;

  String _failureMessage(Object? error) {
    final type = _failureType(error);
    return switch (type) {
      SurahPlaybackFailureType.invalidSelection =>
        'اختيار الابتهال أو المبتهل غير صالح.',
      SurahPlaybackFailureType.queueFilesystem =>
        'تعذر فحص ملفات الابتهالات المحفوظة.',
      SurahPlaybackFailureType.coordinatorActivation =>
        'تعذر إيقاف المشغل الآخر وبدء الابتهال.',
      SurahPlaybackFailureType.network =>
        'تعذر تحميل الابتهال من الإنترنت. تحقق من الاتصال وحاول مجددًا.',
      SurahPlaybackFailureType.localFile =>
        'تعذر تشغيل الابتهال المحفوظ. قد يكون الملف مفقودًا أو تالفًا.',
      SurahPlaybackFailureType.player =>
        'حدث خطأ في مشغل الصوت. حاول تشغيل الابتهال مرة أخرى.',
    };
  }

  void searchIbtihalat(String query) {
    if (query.isEmpty) {
      emit(
        state.copyWith(
          searchIbtihalResults: List.generate(
            state.reciter.info.length,
            (index) => index,
          ),
        ),
      );
      return;
    }

    final filteredIbtihalat =
        state.reciter.info
            .asMap()
            .entries
            .where((entry) => entry.value.name.contains(query))
            .map((entry) => entry.key)
            .toList();

    emit(state.copyWith(searchIbtihalResults: filteredIbtihalat));
  }

  void searchReciters({String? query, String? country}) {
    String reciterCountry = country ?? state.reciterCountry;
    String reciterSearchQuery = query ?? state.reciterSearchQuery;

    final filteredReciters = ibtihalatPlayerRepo.filterReciters(
      reciterCountry,
      reciterSearchQuery,
    );

    emit(
      state.copyWith(
        searchReciterResults: filteredReciters,
        reciterCountry: reciterCountry,
        reciterSearchQuery: reciterSearchQuery,
      ),
    );
  }

  static String getCountryFlag(String countryName) {
    return recitersCountries[countryName] ?? AppImages.unknownFlag;
  }

  void clearIbtihalSearch() {
    emit(
      state.copyWith(
        searchIbtihalResults: List.generate(
          state.reciter.info.length,
          (index) => index,
        ),
      ),
    );
  }

  void clearReciterSearch() {
    emit(
      state.copyWith(
        searchReciterResults: ibtihalatPlayerRepo.getAllReciters(),
        reciterCountry: "كل الدول",
        reciterSearchQuery: "",
      ),
    );
  }

  //here
  Future<void> downloadIbtihal() async {
    final ibtihalIndex = state.ibtihalNumber;

    if (state.downloadingIbtihalat.contains(ibtihalIndex)) {
      await LocalNotificationService.instance.showBasicNotification(
        "جاري تحميل الابتهال بالفعل...",
        "",
      );
      return;
    }

    emit(
      state.copyWith(
        downloadingIbtihalat: {...state.downloadingIbtihalat, ibtihalIndex},
      ),
    );

    dev.log("start download");

    final directory = await getApplicationDocumentsDirectory();
    final reciterDir = Directory(
      '${directory.path}/Ibtihalat_listening/${state.reciter.nameArabic}',
    );
    await reciterDir.create(recursive: true);

    final filePath =
        '${reciterDir.path}/ابتهال ${state.reciter.info[ibtihalIndex].name}.mp3';
    final tempFilePath = '$filePath.part';

    final finalFile = File(filePath);
    final tempFile = File(tempFilePath);

    if (await finalFile.exists()) {
      await LocalNotificationService.instance.showBasicNotification(
        "الابتهال موجود بالفعل",
        "",
      );

      emit(
        state.copyWith(
          downloadingIbtihalat: {...state.downloadingIbtihalat}
            ..remove(ibtihalIndex),
        ),
      );
      return;
    }

    if (await tempFile.exists()) {
      await LocalNotificationService.instance.showBasicNotification(
        "جاري تحميل الابتهال بالفعل...",
        "",
      );

      emit(
        state.copyWith(
          downloadingIbtihalat: {...state.downloadingIbtihalat}
            ..remove(ibtihalIndex),
        ),
      );
      return;
    }

    final dio = Dio();

    try {
      await dio.download(
        state.reciter.info[ibtihalIndex].url,
        tempFilePath,
        onReceiveProgress: ((count, total) async {
          final progress = ((count / total) * 100).toInt();
          final String progressText = '$progress%';

          if (progress < 100) {
            await LocalNotificationService.instance.downloadNotification(
              groupKey: "ibtihalatDownload",
              keyFeature: NotificationKeys.ibtihalatDownload,
              title: "تحميل ${state.reciter.info[ibtihalIndex].name}",
              hasAction: false,
              isPlaying: false,
              progress: progress,
              maxProgress: 100,
              id: int.parse("2${ibtihalIndex}2"),
              progressText: progressText,
            );
          } else {
            await LocalNotificationService.instance.cancelNotification(
              int.parse("2${ibtihalIndex}2"),
            );
            await LocalNotificationService.instance.showCompletionNotification(
              2002,
              "تم تحميل ${state.reciter.info[ibtihalIndex].name} بنجاح",
            );
          }
        }),
      );

      await tempFile.rename(filePath);
    } on DioException catch (e) {
      dev.log("error downloading file $e");
      await LocalNotificationService.instance.showBasicNotification(
        "فشل تحميل الابتهال",
        "",
      );
      showToast("فشل تحميل الابتهال", AppColor.blueTint2);
      if (await tempFile.exists()) {
        await tempFile.delete();
      }
    } finally {
      emit(
        state.copyWith(
          downloadingIbtihalat: {...state.downloadingIbtihalat}
            ..remove(ibtihalIndex),
        ),
      );
    }
  }

  Future<void> shareIbtihal() async {
    final directory = await getApplicationDocumentsDirectory();
    final reciterDir = Directory(
      '${directory.path}/Ibtihalat_listening/${state.reciter.nameArabic}',
    );
    final filePath =
        '${reciterDir.path}/ابتهال ${state.reciter.info[state.ibtihalNumber].name}.mp3';

    final url = state.reciter.info[state.ibtihalNumber].url;

    try {
      if (await File(filePath).exists()) {
        await shareSound(
          filePath,
          des: state.reciter.info[state.ibtihalNumber].name,
          subject: "ابتهال ديني",
        );
      } else {
        await shareText(
          FormatText.ibtihalShareText(
            ibtihalName: state.reciter.info[state.ibtihalNumber].name,
            reciterName: state.reciter.nameArabic,
            url: url,
          ),
          subject: "ابتهال ديني",
        );
      }
    } catch (e) {
      showToast("حدث خطا أثناء مشاركة الابتهال", AppColor.blueTint2);
      dev.log(e.toString());
    }
  }

  void toggleFavorite() {
    final isCurrentlyFavorite = ibtihalatPlayerRepo.isFavorite(
      ibtihalNumber: state.ibtihalNumber,
      reciterId: state.reciter.id,
    );
    emit(state.copyWith(isIbtihalFavorite: isCurrentlyFavorite));
  }

  Future<void> updateFavoriteList() async {
    final isCurrentlyFavorite = ibtihalatPlayerRepo.isFavorite(
      ibtihalNumber: state.ibtihalNumber,
      reciterId: state.reciter.id,
    );

    if (isCurrentlyFavorite) {
      await ibtihalatPlayerRepo.removeFavorite(
        ibtihalNumber: state.ibtihalNumber,
        reciterId: state.reciter.id,
      );
    } else {
      await ibtihalatPlayerRepo.addFavorite(
        ibtihalNumber: state.ibtihalNumber,
        ibtihalName: state.reciter.info[state.ibtihalNumber].name,
        reciter: state.reciter,
      );
    }

    emit(state.copyWith(isIbtihalFavorite: !isCurrentlyFavorite));
  }

  @override
  Future<void> close() async {
    await _snapshotSubscription?.cancel();
    return super.close();
  }
}

class IbtihalatPlayerState extends Equatable {
  final bool isRandom;
  final bool isPlaying;
  final bool isPaused;
  final bool isIbtihalFavorite;
  final String reciterCountry, reciterSearchQuery;
  final bool onRepeat;
  final int ibtihalNumber;
  final ReciterIbtihalModel reciter;
  final double currentPosition, audioSpeed;
  final double ibtihalDuration;
  final bool isSeeking;
  final List<ReciterIbtihalModel> searchReciterResults;
  final List<int> searchIbtihalResults;
  final AudioFetchState audioState;
  final Set<int> downloadingIbtihalat;

  const IbtihalatPlayerState({
    required this.isRandom,
    required this.downloadingIbtihalat,
    required this.audioSpeed,
    required this.reciterCountry,
    required this.reciterSearchQuery,
    required this.searchReciterResults,
    required this.reciter,
    required this.audioState,
    required this.isSeeking,
    required this.isPlaying,
    required this.isPaused,
    required this.isIbtihalFavorite,
    required this.onRepeat,
    required this.ibtihalNumber,
    required this.currentPosition,
    required this.ibtihalDuration,
    required this.searchIbtihalResults,
  });

  factory IbtihalatPlayerState.initial() {
    final defaultReciter = ReciterIbtihalModel(
      id: 1,
      name: "mohammed_omran",
      nameArabic: "محمد عمران",
      nationality: "مصر",
      info: IbtihalatPlayerRepo.ibtahalInfoInitList,
    );
    return IbtihalatPlayerState(
      isRandom: false,
      downloadingIbtihalat: <int>{},
      audioState: AudioFetchInit(),
      isSeeking: false,
      isPlaying: false,
      isPaused: false,
      reciterCountry: "كل الدول",
      reciterSearchQuery: "",
      isIbtihalFavorite: false,
      onRepeat: false,
      ibtihalNumber: 0,
      audioSpeed: 1,
      reciter: defaultReciter,
      currentPosition: 0.0,
      ibtihalDuration: 233.0,
      searchIbtihalResults: List.generate(
        defaultReciter.info.length,
        (index) => index,
      ),
      searchReciterResults: IbtihalatPlayerRepo().getAllReciters(),
    );
  }

  IbtihalatPlayerState copyWith({
    Set<int>? downloadingIbtihalat,
    bool? isRandom,
    bool? isPlaying,
    bool? isSeeking,
    bool? isPaused,
    String? reciterCountry,
    String? reciterSearchQuery,
    ReciterIbtihalModel? reciter,
    bool? onRepeat,
    bool? isIbtihalFavorite,
    int? ibtihalNumber,
    double? currentPosition,
    double? audioSpeed,
    double? ibtihalDuration,
    List<int>? searchIbtihalResults,
    List<ReciterIbtihalModel>? searchReciterResults,
    AudioFetchState? audioState,
  }) {
    return IbtihalatPlayerState(
      isRandom: isRandom ?? this.isRandom,
      downloadingIbtihalat: downloadingIbtihalat ?? this.downloadingIbtihalat,
      isIbtihalFavorite: isIbtihalFavorite ?? this.isIbtihalFavorite,
      reciter: reciter ?? this.reciter,
      audioState: audioState ?? this.audioState,
      reciterCountry: reciterCountry ?? this.reciterCountry,
      reciterSearchQuery: reciterSearchQuery ?? this.reciterSearchQuery,
      isSeeking: isSeeking ?? this.isSeeking,
      isPlaying: isPlaying ?? this.isPlaying,
      isPaused: isPaused ?? this.isPaused,
      onRepeat: onRepeat ?? this.onRepeat,
      ibtihalNumber: ibtihalNumber ?? this.ibtihalNumber,
      currentPosition: currentPosition ?? this.currentPosition,
      audioSpeed: audioSpeed ?? this.audioSpeed,
      ibtihalDuration: ibtihalDuration ?? this.ibtihalDuration,
      searchIbtihalResults: searchIbtihalResults ?? this.searchIbtihalResults,
      searchReciterResults: searchReciterResults ?? this.searchReciterResults,
    );
  }

  @override
  List<Object> get props => [
    reciter,
    isRandom,
    reciterSearchQuery,
    reciterCountry,
    isSeeking,
    isPlaying,
    isPaused,
    isIbtihalFavorite,
    audioSpeed,
    onRepeat,
    ibtihalNumber,
    currentPosition,
    ibtihalDuration,
    searchIbtihalResults,
    searchReciterResults,
    audioState,
    downloadingIbtihalat,
  ];
}

class AudioFetchState {}

class AudioFetchLoading implements AudioFetchState {}

class AudioFetchInit implements AudioFetchState {}

class AudioFetchFailure implements AudioFetchState {
  final String errorMessage;
  final SurahPlaybackFailureType type;

  AudioFetchFailure(
    this.errorMessage, {
    this.type = SurahPlaybackFailureType.player,
  });
}

class AudioFetchSuccess implements AudioFetchState {}
