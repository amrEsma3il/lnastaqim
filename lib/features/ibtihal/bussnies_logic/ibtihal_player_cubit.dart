
import 'dart:developer' as dev;
import 'dart:io';
import 'dart:isolate';
import 'dart:math';
import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';

import '../../../core/constants/images.dart';
import '../../../core/utilits/functions/format_text.dart';
import '../../../core/utilits/services/audio_service/audio_players.dart';
import '../../../core/utilits/services/audio_service/players_key.dart';
import '../../../core/utilits/services/local_notification_service.dart';
import '../../share/views/widgets/share_fun.dart';
import '../data/models/ibtihal_info.dart';
import '../data/models/reciter_ibtihal_model/reciter_ibtihal_model.dart';
import '../data/repo/ibtihal_player_repo.dart';

class IbtihalatPlayerCubit extends Cubit<IbtihalatPlayerState> {
    final AudioPlayer audioPlayer = AudioPlayers().getPlayer(
    NotificationKeys.ibtihalatPlayer,
  );
  final IbtihalatPlayerRepo ibtihalatPlayerRepo;

  ReceivePort? receivePort;

  static IbtihalatPlayerCubit get(BuildContext context) => BlocProvider.of<IbtihalatPlayerCubit>(context);

  IbtihalatPlayerCubit(this.ibtihalatPlayerRepo)
      : super(IbtihalatPlayerState.initial()) {
    initListeners();
    registerPort();
  }

  static const Map<String, String> recitersCountries = {
    "كل الدول": AppImages.earthFlag,
    "مصر": AppImages.egyptFlag,
  };

  static List<double> audioSpeedRates = [0.5, 0.75, 1, 1.25, 1.75, 2];

  void initListeners() {
    audioPlayer.onPlayerStateChanged.listen((PlayerState state) {
      if (state == PlayerState.playing) {
        emit(this.state.copyWith(isPlaying: true, isPaused: false));
      } else if (state == PlayerState.paused || state == PlayerState.stopped) {
        emit(this.state.copyWith(isPlaying: false, isPaused: true));
      }
    });

    audioPlayer.onPositionChanged.listen((Duration position) {
      if (!state.isSeeking) {
        emit(state.copyWith(currentPosition: position.inSeconds.toDouble()));
      }
    });

    audioPlayer.onDurationChanged.listen((Duration duration) {
      emit(state.copyWith(ibtihalDuration: duration.inSeconds.toDouble()));
    });

    audioPlayer.onPlayerComplete.listen((_) {
      if (state.onRepeat) {
        playIbtihal();
      } else {
        nextIbtihal();
      }
    });
  }

  Future<void> registerPort() async {
    receivePort = ReceivePort();
    IsolateNameServer.registerPortWithName(
      receivePort!.sendPort,
      NotificationKeys.ibtihalatPlayer,
    );

    receivePort!.listen((message) async {
      dev.log('Received ibtihalat message: $message');
      await _handleNotificationAction(message);
    });
  }

  Future<void> _handleNotificationAction(String action) async {
    switch (action) {
      case 'play':
        await togglePlayPause();
        break;
      case 'pause':
        await togglePlayPause();
        break;
      case 'stop':
        await audioPlayer.stop();
        break;
      case 'previous':
        previousIbtihal();
        break;
      case 'next':
        nextIbtihal();
        break;
    }
  }

  static String formatDuration(int seconds) {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final secs = (seconds % 60).toString().padLeft(2, '0');
    return "$minutes:$secs";
  }

  List<ReciterIbtihalModel> getAllReciters() {
    return ibtihalatPlayerRepo.getAllReciters();
  }

  Future<void> playIbtihal() async {
    dev.log("playIbtihal");
    emit(state.copyWith(audioState: AudioFetchLoading()));
    try {
      final directory = await getApplicationDocumentsDirectory();
      final reciterDir = Directory(
        '${directory.path}/Ibtihalat_listening/${state.reciter.nameArabic}',
      );
    final filePath = '${reciterDir.path}/ابتهال ${state.reciter.info[state.ibtihalNumber].name}.mp3';
    await AudioPlayers().pauseAll();
   await   LocalNotificationService.instance.showMediaNotification(
          groupKey: "ibtihal",
          isPlaying: true,
          id: 310,
          keyFeature: NotificationKeys.ibtihalatPlayer,

          body: state.reciter.nameArabic,
          title:state.reciter.info[state.ibtihalNumber].name,
        );

      Source source;
      if (await File(filePath).exists()) {
        source = DeviceFileSource(filePath);
      } else {
        source = UrlSource(state.reciter.info[state.ibtihalNumber].url);
      }

      await audioPlayer.play(source);
      emit(state.copyWith(
        audioState: AudioFetchSuccess(),
        isPlaying: true,
        isPaused: false,
      ));
    } catch (e) {
      dev.log("ibtihal audio failure$e");
      await audioPlayer.stop();
         await   LocalNotificationService.instance.showMediaNotification(
          groupKey: "ibtihal",
          isPlaying: false,
          id: 310,
          keyFeature: NotificationKeys.ibtihalatPlayer,

          body: state.reciter.nameArabic,
          title:state.reciter.info[state.ibtihalNumber].name,
        );
      emit(state.copyWith(isPlaying: false,isPaused: false, audioState: AudioFetchFailure()));
    }
  }

  Future<void> togglePlayPause() async {
    dev.log("toggle test playing ${state.isPlaying} ");
    if (state.isPlaying) {
      await audioPlayer.pause();
      emit(state.copyWith(isPlaying: false, isPaused: true));
         await   LocalNotificationService.instance.showMediaNotification(
          groupKey: "ibtihal",
          isPlaying: false,
          id: 310,
          keyFeature: NotificationKeys.ibtihalatPlayer,

          body: state.reciter.nameArabic,
          title:state.reciter.info[state.ibtihalNumber].name,
        );
    } else {
      if (state.isPaused) {
         await AudioPlayers().pauseAll();
        await audioPlayer.resume();
        emit(state.copyWith(isPlaying: true, isPaused: false));
           await   LocalNotificationService.instance.showMediaNotification(
          groupKey: "ibtihal",
          isPlaying: true,
          id: 310,
          keyFeature: NotificationKeys.ibtihalatPlayer,

          body: state.reciter.nameArabic,
          title:state.reciter.info[state.ibtihalNumber].name,
        );
      } else {
        dev.log("play audio from stop ");
        await playIbtihal();
      }
    }
  }

  Future<void> nextIbtihal() async {
    if (state.ibtihalNumber < state.reciter.info.length - 1) {
      emit(state.copyWith(
          ibtihalNumber: state.ibtihalNumber + 1, currentPosition: 0));
      toggleFavorite();
      await playIbtihal();
    }
  }

  Future<void> previousIbtihal() async {
    if (state.ibtihalNumber > 0) {
      emit(state.copyWith(
          ibtihalNumber: state.ibtihalNumber - 1, currentPosition: 0));
      toggleFavorite();
      await playIbtihal();
    }
  }

  void changeIbtihalNum(int ibtihalNumber) async {
    if (state.ibtihalNumber != ibtihalNumber) {
      emit(state.copyWith(ibtihalNumber: ibtihalNumber, currentPosition: 0));
      toggleFavorite();
      await playIbtihal();
    } else {
      if (state.isPaused) {
        await audioPlayer.resume();
           await   LocalNotificationService.instance.showMediaNotification(
          groupKey: "ibtihal",
          isPlaying: true,
          id: 310,
          keyFeature: NotificationKeys.ibtihalatPlayer,

          body: state.reciter.nameArabic,
          title:state.reciter.info[state.ibtihalNumber].name,
        );
      } else if (!state.isPlaying) {
        await playIbtihal();
      } else {
        emit(state.copyWith(isPlaying: true, isPaused: false));
           await   LocalNotificationService.instance.showMediaNotification(
          groupKey: "ibtihal",
          isPlaying: true,
          id: 310,
          keyFeature: NotificationKeys.ibtihalatPlayer,

          body: state.reciter.nameArabic,
          title:state.reciter.info[state.ibtihalNumber].name,
        );
      }
    }
  }

  void changeReciter(ReciterIbtihalModel reciter) async {
    if (state.reciter.id != reciter.id) {
      emit(state.copyWith(
          reciter: reciter,
          ibtihalNumber: 0,
          currentPosition: 0,
          searchIbtihalResults: List.generate(reciter.info.length, (index) => index)));
      toggleFavorite();
      await playIbtihal();
    } else {
      if (state.isPaused) {
        await audioPlayer.resume();
           await   LocalNotificationService.instance.showMediaNotification(
          groupKey: "ibtihal",
          isPlaying: true,
          id: 310,
          keyFeature: NotificationKeys.ibtihalatPlayer,

          body: state.reciter.nameArabic,
          title:state.reciter.info[state.ibtihalNumber].name,
        );
      } else if (!state.isPlaying) {
        await playIbtihal();
      } else {
        emit(state.copyWith(isPlaying: true, isPaused: false));



            await   LocalNotificationService.instance.showMediaNotification(
          groupKey: "ibtihal",
          isPlaying: true,
          id: 310,
          keyFeature: NotificationKeys.ibtihalatPlayer,

          body: state.reciter.nameArabic,
          title:state.reciter.info[state.ibtihalNumber].name,
        );
      }
    }
  }

  void toggleRepeat() {
    emit(state.copyWith(onRepeat: !state.onRepeat));
  }

  void seek(double position) async {
    emit(state.copyWith(isSeeking: true, audioState: AudioFetchLoading()));
    try {
      await audioPlayer.seek(Duration(seconds: position.toInt()));
      await playIbtihal();
    } catch (e) {
      dev.log(e.toString());
      await audioPlayer.stop();
      emit(state.copyWith(isPlaying: false, audioState: AudioFetchFailure()));
    }
    emit(state.copyWith(isSeeking: false));
  }

  void changeAudioPosition(double value) {
    emit(state.copyWith(currentPosition: value));
  }

  void sliderSeekToggle({required bool isSeeking}) {
    emit(state.copyWith(isSeeking: isSeeking));
  }

  void playRandomIbtihal() async {
    final random = Random();
    int randomIbtihal = random.nextInt(state.reciter.info.length);
    emit(state.copyWith(ibtihalNumber: randomIbtihal));
    await playIbtihal();
  }

  void setPlaybackRate(double rate) async {
    emit(state.copyWith(audioSpeed: rate));
    await audioPlayer.setPlaybackRate(rate);
  }

  void searchIbtihalat(String query) {
    if (query.isEmpty) {
      emit(state.copyWith(
          searchIbtihalResults: List.generate(state.reciter.info.length, (index) => index)));
      return;
    }

    final filteredIbtihalat = state.reciter.info
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
    emit(state.copyWith(
        searchIbtihalResults: List.generate(state.reciter.info.length, (index) => index)));
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

  Future<void> downloadIbtihal() async {
    dev.log("start download");
    final directory = await getApplicationDocumentsDirectory();
    final reciterDir = Directory(
      '${directory.path}/Ibtihalat_listening/${state.reciter.nameArabic}',
    );
    await reciterDir.create(recursive: true);
    final filePath = '${reciterDir.path}/ابتهال ${state.reciter.info[state.ibtihalNumber].name}.mp3';

    if (!await File(filePath).exists()) {
      final dio = Dio();
      try {
        await dio.download(
          state.reciter.info[state.ibtihalNumber].url,
          filePath,
          onReceiveProgress: ((count, total) async {
            if (((count / total) * 100).toInt() < 100) {
              final String progressText = '${((count / total) * 100).toInt()}%';
              await LocalNotificationService.instance.downloadNotification(
                groupKey: "ibtihalatDownload",
                keyFeature: NotificationKeys.ibtihalatDownload,
                title: "تحميل ${state.reciter.info[state.ibtihalNumber].name}",
                hasAction: false,
                isPlaying: false,
                progress: ((count / total) * 100).toInt(),
                maxProgress: 100,
                id: int.parse("2${state.ibtihalNumber}2"),
                progressText: progressText,
              );
            } else {
              await LocalNotificationService.instance.cancelNotification(
                int.parse("2${state.ibtihalNumber}2"),
              );
              await LocalNotificationService.instance.showCompletionNotification(
                2002,
                "تم تحميل ${state.reciter.info[state.ibtihalNumber].name} بنجاح",
              );
            }
          }),
        );
      } on DioException catch (e) {
        dev.log("error downloading file $e");
      }
    } else {
      await LocalNotificationService.instance.showBasicNotification(
        "الابتهال موجود بالفعل",
        "",
      );
    }
  }

  Future<void> shareIbtihal() async {
    final directory = await getApplicationDocumentsDirectory();
    final reciterDir = Directory(
      '${directory.path}/Ibtihalat_listening/${state.reciter.nameArabic}',
    );
    final filePath = '${reciterDir.path}/ابتهال ${state.reciter.info[state.ibtihalNumber].name}.mp3';

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
  Future<void> close() {
    IsolateNameServer.removePortNameMapping(NotificationKeys.ibtihalatPlayer);
    receivePort?.close();
    audioPlayer.dispose();
    return super.close();
  }
}

class IbtihalatPlayerState extends Equatable {
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

  const IbtihalatPlayerState({
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
      ibtihalDuration: 0.0,
      searchIbtihalResults: List.generate(defaultReciter.info.length, (index) => index),
      searchReciterResults: IbtihalatPlayerRepo().getAllReciters(),
    );
  }

  IbtihalatPlayerState copyWith({
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
      ];
}

class AudioFetchState {}

class AudioFetchLoading implements AudioFetchState {}

class AudioFetchInit implements AudioFetchState {}

class AudioFetchFailure implements AudioFetchState {}

class AudioFetchSuccess implements AudioFetchState {}
