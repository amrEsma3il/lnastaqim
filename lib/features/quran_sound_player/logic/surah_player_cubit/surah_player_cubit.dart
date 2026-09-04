import 'dart:developer' as dev;
import 'dart:io';
import 'dart:math';
import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/images.dart';
import '../../../../core/utilits/functions/format_text.dart';
import '../../../../core/utilits/functions/toast_message.dart';
import '../../../../core/utilits/services/audio_service/surah_playback_service.dart';
import '../../../../core/utilits/services/audio_service/unified_audio_handler.dart';
import '../../../../core/utilits/services/audio_service/players_key.dart';
import '../../../../core/utilits/services/local_notification_service.dart';
import '../../../share/views/widgets/share_fun.dart';
import '../../data/models/reciter_model/reciters_model.dart';
import '../../data/repo/surah_player_repo.dart';
import 'surah_queue_builder.dart';
import 'surah_player_state.dart';

class SurahPlayerCubit extends Cubit<SurahPlayerState> {
  final SurahPlaybackService playbackService;
  final Future<Directory> Function() _documentsDirectoryProvider;
  final Future<List<SurahPlaybackItem>> Function({
    required Directory documentsDirectory,
    required Reciter reciter,
    required Map<int, String> surahNames,
  })
  _queueBuilder;
  final void Function(String) _errorPresenter;
  final List<StreamSubscription<dynamic>> _playbackSubscriptions = [];
  bool _handlingCompletion = false;
  double? pendingSeek;

  final SurahPlayerRepo surahPlayerRepo;
  static SurahPlayerCubit get(BuildContext context) => BlocProvider.of(context);

  SurahPlayerCubit(
    this.surahPlayerRepo, {
    SurahPlaybackService? playbackService,
    Future<Directory> Function()? documentsDirectoryProvider,
    Future<List<SurahPlaybackItem>> Function({
      required Directory documentsDirectory,
      required Reciter reciter,
      required Map<int, String> surahNames,
    })?
    queueBuilder,
    void Function(String)? errorPresenter,
  }) : playbackService = playbackService ?? AudioServices.handler,
       _documentsDirectoryProvider =
           documentsDirectoryProvider ?? getApplicationDocumentsDirectory,
       _queueBuilder = queueBuilder ?? buildSurahPlaybackQueue,
       _errorPresenter =
           errorPresenter ??
           ((message) => showToast(message, AppColor.blueTint2)),
       super(SurahPlayerState.initial()) {
    initListeners();
  }

  static const Map<String, String> recitersCountries = {
    "كل الدول": AppImages.earthFlag,
    "مصر": AppImages.egyptFlag,
    "السعودية": AppImages.suadiaFlag,
    "الكويت": AppImages.kuwaitFlag,
    "البوسنة": AppImages.bosniaFlag,
    // "سوريا":AppImages.syriaFlag,
    // "العراق":AppImages.iraqFlag,
    // "باكستان":AppImages.pakistanFlag,
    // "الإمارات":AppImages.emiratesFlag,
    "اليمن": AppImages.yemenFlag,
    "غير معروف": AppImages.unknownFlag,
  };

  static const Map<int, String> quranSurahs = {
    1: "سورة الفاتحة",
    2: "سورة البقرة",
    3: "سورة آل عمران",
    4: "سورة النساء",
    5: "سورة المائدة",
    6: "سورة الأنعام",
    7: "سورة الأعراف",
    8: "سورة الأنفال",
    9: "سورة التوبة",
    10: "سورة يونس",
    11: "سورة هود",
    12: "سورة يوسف",
    13: "سورة الرعد",
    14: "سورة إبراهيم",
    15: "سورة الحجر",
    16: "سورة النحل",
    17: "سورة الإسراء",
    18: "سورة الكهف",
    19: "سورة مريم",
    20: "سورة طه",
    21: "سورة الأنبياء",
    22: "سورة الحج",
    23: "سورة المؤمنون",
    24: "سورة النور",
    25: "سورة الفرقان",
    26: "سورة الشعراء",
    27: "سورة النمل",
    28: "سورة القصص",
    29: "سورة العنكبوت",
    30: "سورة الروم",
    31: "سورة لقمان",
    32: "سورة السجدة",
    33: "سورة الأحزاب",
    34: "سورة سبأ",
    35: "سورة فاطر",
    36: "سورة يس",
    37: "سورة الصافات",
    38: "سورة ص",
    39: "سورة الزمر",
    40: "سورة غافر",
    41: "سورة فصلت",
    42: "سورة الشورى",
    43: "سورة الزخرف",
    44: "سورة الدخان",
    45: "سورة الجاثية",
    46: "سورة الأحقاف",
    47: "سورة محمد",
    48: "سورة الفتح",
    49: "سورة الحجرات",
    50: "سورة ق",
    51: "سورة الذاريات",
    52: "سورة الطور",
    53: "سورة النجم",
    54: "سورة القمر",
    55: "سورة الرحمن",
    56: "سورة الواقعة",
    57: "سورة الحديد",
    58: "سورة المجادلة",
    59: "سورة الحشر",
    60: "سورة الممتحنة",
    61: "سورة الصف",
    62: "سورة الجمعة",
    63: "سورة المنافقون",
    64: "سورة التغابن",
    65: "سورة الطلاق",
    66: "سورة التحريم",
    67: "سورة الملك",
    68: "سورة القلم",
    69: "سورة الحاقة",
    70: "سورة المعارج",
    71: "سورة نوح",
    72: "سورة الجن",
    73: "سورة المزمل",
    74: "سورة المدثر",
    75: "سورة القيامة",
    76: "سورة الإنسان",
    77: "سورة المرسلات",
    78: "سورة النبأ",
    79: "سورة النازعات",
    80: "سورة عبس",
    81: "سورة التكوير",
    82: "سورة الانفطار",
    83: "سورة المطففين",
    84: "سورة الانشقاق",
    85: "سورة البروج",
    86: "سورة الطارق",
    87: "سورة الأعلى",
    88: "سورة الغاشية",
    89: "سورة الفجر",
    90: "سورة البلد",
    91: "سورة الشمس",
    92: "سورة الليل",
    93: "سورة الضحى",
    94: "سورة الشرح",
    95: "سورة التين",
    96: "سورة العلق",
    97: "سورة القدر",
    98: "سورة البينة",
    99: "سورة الزلزلة",
    100: "سورة العاديات",
    101: "سورة القارعة",
    102: "سورة التكاثر",
    103: "سورة العصر",
    104: "سورة الهمزة",
    105: "سورة الفيل",
    106: "سورة قريش",
    107: "سورة الماعون",
    108: "سورة الكوثر",
    109: "سورة الكافرون",
    110: "سورة النصر",
    111: "سورة المسد",
    112: "سورة الإخلاص",
    113: "سورة الفلق",
    114: "سورة الناس",
  };

  static List<double> audioSpeedRates = [0.5, 0.75, 1, 1.25, 1.75, 2];

  void initListeners() {
    _playbackSubscriptions.add(
      playbackService.snapshots.listen(_onPlaybackSnapshot),
    );
  }

  Future<void> _onPlaybackSnapshot(SurahPlaybackSnapshot snapshot) async {
    if (isClosed) return;
    final itemPrefix = 'surah:${state.reciter.name}:';
    if (snapshot.itemId != null && !snapshot.itemId!.startsWith(itemPrefix)) {
      return;
    }
    final handlerSurahNumber =
        snapshot.itemId == null
            ? state.surahNumber
            : int.tryParse(snapshot.itemId!.split(':').last) ??
                state.surahNumber;

    final failed = snapshot.processingState == SurahProcessingState.error;
    emit(
      state.copyWith(
        isPlaying: snapshot.playing,
        surahNumber: handlerSurahNumber,
        isPaused:
            !snapshot.playing &&
            snapshot.processingState != SurahProcessingState.idle,
        currentPosition:
            state.isSeeking
                ? state.currentPosition
                : snapshot.position.inMilliseconds / 1000,
        surahDuration:
            snapshot.duration == null
                ? state.surahDuration
                : snapshot.duration!.inMilliseconds / 1000,
        audioState:
            failed
                ? _audioFailure(snapshot.error)
                : switch (snapshot.processingState) {
                  SurahProcessingState.loading ||
                  SurahProcessingState.buffering => AudioFetchLoading(),
                  SurahProcessingState.ready ||
                  SurahProcessingState.completed => AudioFetchSuccess(),
                  _ => state.audioState,
                },
      ),
    );

    if (snapshot.processingState == SurahProcessingState.completed &&
        !_handlingCompletion) {
      _handlingCompletion = true;
      try {
        if (state.onRepeat) {
          await playSurah();
        } else if (state.isRandom) {
          await playRandomSurah();
        } else {
          await nextSurah();
        }
      } finally {
        _handlingCompletion = false;
      }
    }
  }

  String get _currentMediaId =>
      'surah:${state.reciter.name}:${state.surahNumber}';

  static String formatDuration(int seconds) {
    final hours = seconds ~/ 3600;
    final minutes = ((seconds % 3600) ~/ 60).toString().padLeft(2, '0');
    final secs = (seconds % 60).toString().padLeft(2, '0');
    if (hours > 0) {
      return "${hours.toString().padLeft(2, '0')}:$minutes:$secs";
    }
    return "$minutes:$secs";
  }

  List<Reciter> getAllReciters() {
    return surahPlayerRepo.getAllReciters();
  }

  Future<void> playSurah({int? surahNumber}) async {
    dev.log("from play method");
    emit(state.copyWith(audioState: AudioFetchLoading()));

    // تعيين مصدر الصوت وتشغيله مباشرة
    try {
      _validateSelection();
      final directory = await _documentsDirectoryProvider();
      Reciter reciter = state.reciter;
      // Reset position if surah number changes
      final position =
          surahNumber != null && surahNumber != state.surahNumber
              ? 0
              : state.currentPosition.toInt();
      final items = await _queueBuilder(
        documentsDirectory: directory,
        reciter: reciter,
        surahNames: quranSurahs,
      );
      await playbackService.loadQueueAndPlay(
        items,
        state.surahNumber - 1,
        initialPosition: Duration(seconds: position),
      );
    } catch (e) {
      dev.log(e.toString());
      await playbackService.stop();
      final failure =
          e is SurahPlaybackFailure
              ? e
              : SurahPlaybackFailure(
                SurahPlaybackFailureType.queueFilesystem,
                'تعذر إعداد قائمة التلاوة. حاول مرة أخرى.',
                cause: e,
              );
      _errorPresenter(failure.message);
      emit(
        state.copyWith(
          isPlaying: false,
          isPaused: false,
          audioState: AudioFetchFailure(failure.message, failure.type),
        ),
      );
      return;
    }
  }

  void _validateSelection() {
    if (state.surahNumber < 1 ||
        state.surahNumber > 114 ||
        !quranSurahs.containsKey(state.surahNumber) ||
        state.reciter.name.trim().isEmpty ||
        state.reciter.nameArabic.trim().isEmpty) {
      throw const SurahPlaybackFailure(
        SurahPlaybackFailureType.invalidSelection,
        'اختيار السورة أو القارئ غير صالح.',
      );
    }
  }

  AudioFetchFailure _audioFailure(Object? error) {
    final failure = normalizeSurahPlaybackFailure(
      error ?? StateError('Unknown playback error'),
    );
    return AudioFetchFailure(failure.message, failure.type);
  }

  Future<void> togglePlayPause() async {
    //TODO: should change state from any place trigger audio => state.isPlaying
    dev.log("from toggle play pause");
    dev.log(state.isPlaying.toString());
    final loadedSelectionMatches =
        playbackService.currentSnapshot.itemId == _currentMediaId;
    if (state.isPlaying && loadedSelectionMatches) {
      await playbackService.pause();
    } else {
      if (state.isPaused && loadedSelectionMatches) {
        await playbackService.play();
      } else {
        dev.log("صباحو");
        await playSurah();
      }
    }
  }

  Future<void> nextSurah({bool isFromUserHitAction = false}) async {
    final wasPlaying = state.isPlaying || !isFromUserHitAction;
    await playbackService.stop();
    if (state.surahNumber < 114) {
      emit(
        state.copyWith(surahNumber: state.surahNumber + 1, currentPosition: 0),
      );
      toggleFavorite();
      if (wasPlaying) await playSurah();
    }
  }

  Future<void> previousSurah({bool playAfterSelection = false}) async {
    final wasPlaying = state.isPlaying || playAfterSelection;
    await playbackService.stop();
    emit(state.copyWith(isPlaying: false, isPaused: true, currentPosition: 0));
    if (state.surahNumber > 1) {
      emit(state.copyWith(surahNumber: state.surahNumber - 1));
      toggleFavorite();
    }
    if (wasPlaying) await playSurah();
  }

  //TODO:SCROLL TO CURENT SURAH WHEN OPEN BOTTOM SHEET

  Future<void> changeSurahNum(int surahNumber) async {
    if (state.surahNumber != surahNumber) {
      await playbackService.stop();
      emit(
        state.copyWith(
          isPlaying: false,
          isPaused: false,
          currentPosition: 0,
          surahNumber: surahNumber,
          audioState: AudioFetchInit(),
        ),
      );
    }
  }

  //TODO:SCROLL TO CURENT RECITER WHEN OPEN BOTTOM SHEET
  Future<void> changeReciter(Reciter reciter) async {
    if (state.reciter.name != reciter.name) {
      await playbackService.stop();
      emit(
        state.copyWith(
          isPlaying: false,
          isPaused: false,
          currentPosition: 0,
          reciter: reciter,
          surahNumber: 1,

          audioState: AudioFetchInit(),
        ),
      );
    }
  }

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
        await playbackService.seek(Duration(seconds: position.toInt()));
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
    } catch (e) {
      dev.log("Seek error: $e");
      showToast("توجد مشكلة اثناء تشغيل السورة", AppColor.blueTint2);
      emit(
        state.copyWith(
          isSeeking: false,
          audioState: AudioFetchFailure(
            'تعذر تغيير موضع التشغيل.',
            SurahPlaybackFailureType.player,
          ),
        ),
      );
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

  Future<void> playRandomSurah() async {
    final random = Random();
    int randomSurah = random.nextInt(114) + 1;
    emit(state.copyWith(surahNumber: randomSurah, currentPosition: 0));
    await playSurah();
  }

  //here
  void changeRandomStatus() async {
    emit(state.copyWith(isRandom: !state.isRandom));
  }

  Future<void> setPlaybackRate(double rate) async {
    emit(state.copyWith(audioSpeed: rate));
    await playbackService.setSpeed(rate);
    // await    playSurah();
  }

  //البحث والفلترة

  /// البحث عن السور بناءً على الاسم
  void searchSurahs(String query) {
    if (query.isEmpty) {
      emit(
        state.copyWith(searchSurahResults: []),
      ); // إفراغ النتائج عند البحث الفارغ
      return;
    }

    final filteredSurahs =
        quranSurahs.entries
            .where((entry) => entry.value.contains(query))
            .map((entry) => entry.key)
            .toList();

    emit(state.copyWith(searchSurahResults: filteredSurahs));
  }

  void searchReciters({String? query, String? country}) {
    String reciterCountry = country ?? state.reciterCountry;
    String reciterSearchQuery = query ?? state.reciterSearchQuery;

    // if (query.isEmpty) {
    //   emit(state.copyWith(searchReciterResults: [])); // إفراغ النتائج عند البحث الفارغ
    //   return;
    // }

    final filteredReciters = surahPlayerRepo.filterReciters(
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
    // defaultFlag صورة افتراضية إذا لم يكن العلم موجودًا
  }

  /// تصفية السور حسب نطاق معين
  // void filterSurahs(int start, int end) {
  //   final filteredSurahs = quranSurahs.entries
  //       .where((entry) => entry.key >= start && entry.key <= end)
  //       .map((entry) => entry.key)
  //       .toList();

  //   emit(state.copyWith(searchSurahResults: filteredSurahs));
  // }

  /// إلغاء البحث وإعادة القائمة الكاملة
  void clearSurahSearch() {
    emit(state.copyWith(searchSurahResults: quranSurahs.keys.toList()));
  }

  void clearReciterSearch() {
    emit(
      state.copyWith(
        searchReciterResults: surahPlayerRepo.getAllReciters(),
        reciterCountry: "كل الدول",
        reciterSearchQuery: "",
      ),
    );
  }

  //others
  Future<void> downloadSurah() async {
    final surahIndex = state.surahNumber;

    // لو السورة بالفعل قيد التحميل
    if (state.downloadingSurahs.contains(surahIndex)) {
      await LocalNotificationService.instance.showBasicNotification(
        "جاري تحميل السورة بالفعل...",
        "",
      );
      return;
    }

    // أضف السورة لقائمة التحميل
    emit(
      state.copyWith(
        downloadingSurahs: {...state.downloadingSurahs, surahIndex},
      ),
    );

    dev.log("start download");
    final directory = await getApplicationDocumentsDirectory();

    final reciterDir = Directory(
      '${directory.path}/Quran_listening/${state.reciter.nameArabic}',
    );

    await reciterDir.create(recursive: true);

    String surahNumberZeroPad = surahIndex.toString().padLeft(3, '0');
    Reciter reciter = state.reciter;
    String url =
        'https://download.quranicaudio.com/quran/${reciter.name}/$surahNumberZeroPad.mp3';

    final filePath = '${reciterDir.path}/${quranSurahs[surahIndex]}.mp3';
    final tempFilePath = '$filePath.part';

    final finalFile = File(filePath);
    final tempFile = File(tempFilePath);

    if (await finalFile.exists()) {
      await LocalNotificationService.instance.showBasicNotification(
        "السورة موجود بالفعل",
        "",
      );
      emit(
        state.copyWith(
          downloadingSurahs: {...state.downloadingSurahs}..remove(surahIndex),
        ),
      );
      return;
    }

    if (await tempFile.exists()) {
      await LocalNotificationService.instance.showBasicNotification(
        "جاري تحميل السورة بالفعل...",
        "",
      );
      emit(
        state.copyWith(
          downloadingSurahs: {...state.downloadingSurahs}..remove(surahIndex),
        ),
      );
      return;
    }

    final dio = Dio();

    try {
      await dio.download(
        url,
        tempFilePath,
        onReceiveProgress: ((count, total) async {
          final progress = ((count / total) * 100).toInt();
          final progressText = '$progress%';

          if (progress < 100) {
            await LocalNotificationService.instance.downloadNotification(
              groupKey: "quranSurahDownload",
              keyFeature: NotificationKeys.quranSoundDownload,
              title: "تحميل ${quranSurahs[surahIndex]!}",
              hasAction: false,
              isPlaying: false,
              progress: progress,
              maxProgress: 100,
              id: int.parse("1${surahIndex}1"),
              progressText: progressText,
            );
          } else {
            await LocalNotificationService.instance.cancelNotification(
              int.parse("1${surahIndex}1"),
            );
            await LocalNotificationService.instance.showCompletionNotification(
              2001,
              "تم تحميل ${quranSurahs[surahIndex]!} بنجاح",
            );
          }
        }),
      );

      // rename بعد التحميل
      await tempFile.rename(filePath);
    } on DioException catch (e) {
      dev.log("error downloading file $e");
      await LocalNotificationService.instance.showBasicNotification(
        "فشل تحميل السورة",
        "",
      );
      showToast("فشل تحميل السورة", AppColor.blueTint2);
      if (await tempFile.exists()) {
        await tempFile.delete();
      }
    } finally {
      // شيل السورة من قائمة التحميل سواء نجح أو فشل
      emit(
        state.copyWith(
          downloadingSurahs: {...state.downloadingSurahs}..remove(surahIndex),
        ),
      );
    }
  }

  shareSurah() async {
    final directory = await getApplicationDocumentsDirectory();

    final reciterDir = Directory(
      '${directory.path}/Quran_listening/${state.reciter.nameArabic}',
    );
    final filePath = '${reciterDir.path}/${quranSurahs[state.surahNumber]}.mp3';

    String surahNumberZeroPad = state.surahNumber.toString().padLeft(3, '0');
    Reciter reciter = state.reciter;
    String url =
        'https://download.quranicaudio.com/quran/${reciter.name}/$surahNumberZeroPad.mp3';

    try {
      if (await File(filePath).exists()) {
        //TODO : play WITH local SOUND

        await shareSound(
          filePath,
          des: quranSurahs[state.surahNumber],
          subject: "سورة من القرءان الكريم",
        );
      } else {
        await shareText(
          FormatText.surahShareText(
            surahName: quranSurahs[state.surahNumber]!,
            reciterName: reciter.nameArabic,
            url: url,
          ),
          subject: "سورة من القرآن الكريم",
        );
      }
    } catch (e) {
      dev.log(e.toString());
    }
  }

  //! surah favorite logic

  void toggleFavorite() async {
    dev.log("toggleFavorite");

    final isCurrentlyFavorite = surahPlayerRepo.isFavorite(
      surahNumber: state.surahNumber,
      reciterId: state.reciter.id,
    );
    dev.log("toggleFavorite $isCurrentlyFavorite");
    // تحديث الحالة
    emit(state.copyWith(isSurahFavorite: isCurrentlyFavorite));
  }

  Future<void> updateFavoriteList() async {
    dev.log("favorite list updated");
    final isCurrentlyFavorite = surahPlayerRepo.isFavorite(
      surahNumber: state.surahNumber,
      reciterId: state.reciter.id,
    );

    if (isCurrentlyFavorite) {
      await surahPlayerRepo.removeFavorite(
        surahNumber: state.surahNumber,
        reciterId: state.reciter.id,
      );
    } else {
      await surahPlayerRepo.addFavorite(
        surahNumber: state.surahNumber,
        surahName: quranSurahs[state.surahNumber]!,
        reciter: state.reciter,
      );
    }

    // تحديث الحالة
    emit(state.copyWith(isSurahFavorite: !isCurrentlyFavorite));
  }
  // Update changeSurahNum to handle async

  @override
  Future<void> close() async {
    for (final subscription in _playbackSubscriptions) {
      await subscription.cancel();
    }
    return super.close();
  }
}
