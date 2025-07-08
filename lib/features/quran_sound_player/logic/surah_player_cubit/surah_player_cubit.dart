import 'dart:developer' as dev;
import 'dart:io';
import 'dart:isolate';
import 'dart:math';
import 'dart:ui';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/images.dart';
import '../../../../core/utilits/functions/format_text.dart';
import '../../../../core/utilits/functions/toast_message.dart';
import '../../../../core/utilits/services/audio_service/audio_players.dart';
import '../../../../core/utilits/services/audio_service/players_key.dart';
import '../../../../core/utilits/services/local_notification_service.dart';
import '../../../share/views/widgets/share_fun.dart';
import '../../data/models/reciter_model/reciters_model.dart';
import '../../data/repo/surah_player_repo.dart';
import 'surah_player_state.dart';

import 'package:audioplayers/audioplayers.dart';

class SurahPlayerCubit extends Cubit<SurahPlayerState> {
  final AudioPlayer audioPlayer = AudioPlayers().getPlayer(
    NotificationKeys.quranPlayer,
  );

  ReceivePort? receivePort;
  double? pendingSeek;

  final SurahPlayerRepo surahPlayerRepo;
  static SurahPlayerCubit get(BuildContext context) => BlocProvider.of(context);

  SurahPlayerCubit(this.surahPlayerRepo) : super(SurahPlayerState.initial()) {
  
    initListeners();

    registerPort();
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
    audioPlayer.onPlayerStateChanged.listen((PlayerState state) {
      if (state == PlayerState.playing) {
        emit(this.state.copyWith(isPlaying: true, isPaused: false));
      } else if (state == PlayerState.paused || state == PlayerState.stopped) {
        emit(this.state.copyWith(isPlaying: false, isPaused: true));
      }
    });

    audioPlayer.onPositionChanged.listen((Duration position) {
      if (!state.isSeeking && state.audioState is AudioFetchSuccess) {
        dev.log("Position changed: ${position.inSeconds}");
        emit(state.copyWith(currentPosition: position.inSeconds.toDouble()));
      }
    });

    audioPlayer.onDurationChanged.listen((Duration duration) {
      dev.log("changed duration listener ${duration.inSeconds.toInt()}");
      emit(state.copyWith(surahDuration: duration.inSeconds.toDouble()));
    });

    audioPlayer.onPlayerComplete.listen((_) async {
      // Check here if internet connection is available
      // var connectivityResult = await Connectivity().checkConnectivity();

      final bool isConnected =
          await InternetConnectionChecker.instance.hasConnection;

 {
        dev.log("internet connection");
        if (state.onRepeat) {
          await playSurah();
        } else {
          dev.log("state.isRandom ${state.isRandom}");
          if (state.isRandom) {
            playRandomSurah();
          } else {
            await nextSurah();
          }
        }
      }
      //check here if internet connection is available
    });
  }

  changeAudioState({required isPlaying, required isPaused}) {
    state.copyWith(isPlaying: isPlaying, isPaused: isPaused);
  }

  Future<void> registerPort() async {
    receivePort = ReceivePort();
    IsolateNameServer.registerPortWithName(
      receivePort!.sendPort,
      NotificationKeys.quranPlayer,
    );

    receivePort!.listen((message) async {
      dev.log('Received quran message: $message');
      await _handleNotificationAction(message);
    });
  }

  Future<void> _handleNotificationAction(String action) async {
    switch (action) {
      case 'play':
        dev.log("action play");
        await togglePlayPause();
        break;
      case 'pause':
        await togglePlayPause();
        break;
      case 'stop':
        await audioPlayer.stop();
        break;

      case 'previous':
        await previousSurah();

        break;

      case 'next':
        await nextSurah(isFromUserHitAction: true);

        break;
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

  List<Reciter> getAllReciters() {
    return surahPlayerRepo.getAllReciters();
  }

  Future<void> playSurah({int? surahNumber}) async {
    dev.log("audio player id from cubit ${audioPlayer.playerId}");
    dev.log("from play method");
    emit(state.copyWith(audioState: AudioFetchLoading()));

    // تعيين مصدر الصوت وتشغيله مباشرة
    try {
      String surahNumberZeroPad = state.surahNumber.toString().padLeft(3, '0');
      final directory = await getApplicationDocumentsDirectory();
      Reciter reciter = state.reciter;
      String url =
          'https://download.quranicaudio.com/quran/${reciter.name}/$surahNumberZeroPad.mp3';

      final reciterDir = Directory(
        '${directory.path}/Quran_listening/${state.reciter.nameArabic}',
      );

      final filePath =
          '${reciterDir.path}/${quranSurahs[state.surahNumber]}.mp3';

      await AudioPlayers().pauseAll();

      await LocalNotificationService.instance.showMediaNotification(
        groupKey: "quran",
        isPlaying: true,
        id: 30,
        keyFeature: NotificationKeys.quranPlayer,
        body: state.reciter.nameArabic,
        title: quranSurahs[state.surahNumber]!,
      );

      Source source;
      if (await File(filePath).exists()) {
        source = DeviceFileSource(filePath);
      } else {
        source = UrlSource(url);
      }

      // Reset position if surah number changes
      final position =
          surahNumber != null && surahNumber != state.surahNumber
              ? 0
              : state.currentPosition.toInt();
      await audioPlayer.play(source, position: Duration(seconds: position));
      // await channel.invokeMethod('playMedia');
      emit(
        state.copyWith(
          audioState: AudioFetchSuccess(),
          isPlaying: true,
          isPaused: false,
          currentPosition: position.toDouble(),
        ),
      );
    } catch (e) {
      //TODO: neccessary handle errors
      dev.log(e.toString());
      await audioPlayer.stop();
      showToast("توجد مشكلة اثناء تشغيل السورة", AppColor.blueTint2);
      // await LocalNotificationService.instance.showMediaNotification(
      //   groupKey: "ibtihal",
      //   isPlaying: false,
      //   id: 310,
      //   keyFeature: NotificationKeys.ibtihalatPlayer,
      //   body: state.reciter.nameArabic,
      //   title: state.reciter.info[ibtihalNum ?? state.ibtihalNumber].name,
      // );
      emit(
        state.copyWith(
          isPlaying: false,
          isPaused: false,
          audioState: AudioFetchFailure("توجد مشكلة اثناء تشغيل السورة"),
        ),
      );
    }

    // استخدام تأخير زمني لمحاولة الحصول على الطول الصوتي
    // await Future.delayed(const Duration(seconds: 3));

    final duration = await audioPlayer.getDuration();

    // التحقق إذا كان الطول الصوتي متاحًا
    if (duration != null) {
      emit(state.copyWith(surahDuration: duration.inSeconds.toDouble()));
    } else {
      emit(state.copyWith(surahDuration: 0)); // في حالة تعذر الحصول على الطول
    }
  }

  Future<void> togglePlayPause() async {
    //TODO: should change state from any place trigger audio => state.isPlaying
    dev.log("from toggle play pause");
    dev.log(state.isPlaying.toString());
    if (state.isPlaying) {
      await audioPlayer.pause();
      // await channel.invokeMethod('pauseMedia');
      emit(state.copyWith(isPlaying: false, isPaused: true));
      await LocalNotificationService.instance.showMediaNotification(
        groupKey: "quran",
        isPlaying: false,
        id: 30,
        keyFeature: NotificationKeys.quranPlayer,
        body: state.reciter.nameArabic,
        title: quranSurahs[state.surahNumber]!,
      );
    } else {
      if (state.isPaused) {
        await AudioPlayers().pauseAll();
        await audioPlayer.resume();
        emit(state.copyWith(isPlaying: true, isPaused: false));
        await LocalNotificationService.instance.showMediaNotification(
          groupKey: "quran",
          isPlaying: true,
          id: 30,
          keyFeature: NotificationKeys.quranPlayer,
          body: state.reciter.nameArabic,
          title: quranSurahs[state.surahNumber]!,
        );
      } else {
        dev.log("صباحو");
        await playSurah();
      }
      // await channel.invokeMethod('playMedia');
    }
  }

  Future<void> nextSurah({bool isFromUserHitAction = false}) async {
    if (isFromUserHitAction) {
      await audioPlayer.stop();
      emit(
        state.copyWith(
          isPlaying: !isFromUserHitAction,
          isPaused: !isFromUserHitAction,
          currentPosition: 0,
          audioState: AudioFetchInit(),
        ),
      );
    }
    if (state.surahNumber < 114) {
      emit(
        state.copyWith(surahNumber: state.surahNumber + 1, currentPosition: 0),
      );
      toggleFavorite();
      if (!isFromUserHitAction) {
        await playSurah();
      }
    }

    {
      String surahNumberZeroPad = state.surahNumber.toString().padLeft(3, '0');

      Reciter reciter = state.reciter;
      audioPlayer
          .setSourceUrl(
            'https://download.quranicaudio.com/quran/${reciter.name}/$surahNumberZeroPad.mp3',
          )
          .then((_) async {
            final duration = await audioPlayer.getDuration();
            if (duration != null) {
              dev.log("surah duration: ${duration.inSeconds}");
              emit(
                state.copyWith(surahDuration: duration.inSeconds.toDouble()),
              );
            } else {
              dev.log("Failed to get initial duration");
            }
          });
    }
  }

  Future<void> previousSurah() async {
    await audioPlayer.stop();
    emit(state.copyWith(isPlaying: false, isPaused: true, currentPosition: 0));
    if (state.surahNumber > 1) {
      emit(state.copyWith(surahNumber: state.surahNumber - 1));
      toggleFavorite();
    }

    {
      String surahNumberZeroPad = state.surahNumber.toString().padLeft(3, '0');

      Reciter reciter = state.reciter;
      audioPlayer
          .setSourceUrl(
            'https://download.quranicaudio.com/quran/${reciter.name}/$surahNumberZeroPad.mp3',
          )
          .then((_) async {
            final duration = await audioPlayer.getDuration();
            if (duration != null) {
              dev.log("surah duration: ${duration.inSeconds}");
              emit(
                state.copyWith(surahDuration: duration.inSeconds.toDouble()),
              );
            } else {
              dev.log("Failed to get initial duration");
            }
          });
    }
  }

  //TODO:SCROLL TO CURENT SURAH WHEN OPEN BOTTOM SHEET

  void changeSurahNum(int surahNumber) async {
    if (state.surahNumber != surahNumber) {
      await audioPlayer.stop();
      emit(
        state.copyWith(
          isPlaying: false,
          isPaused: true,
          currentPosition: 0,
          surahNumber: surahNumber,
          audioState: AudioFetchInit(),
        ),
      );
    }

    {
      String surahNumberZeroPad = state.surahNumber.toString().padLeft(3, '0');

      Reciter reciter = state.reciter;
      audioPlayer
          .setSourceUrl(
            'https://download.quranicaudio.com/quran/${reciter.name}/$surahNumberZeroPad.mp3',
          )
          .then((_) async {
            final duration = await audioPlayer.getDuration();
            if (duration != null) {
              dev.log("surah duration: ${duration.inSeconds}");
              emit(
                state.copyWith(surahDuration: duration.inSeconds.toDouble()),
              );
            } else {
              dev.log("Failed to get initial duration");
            }
          });
    }
  }

  //TODO:SCROLL TO CURENT RECITER WHEN OPEN BOTTOM SHEET
  changeReciter(Reciter reciter) async {
    if (state.reciter.name != reciter.name) {
      await audioPlayer.stop();
      emit(
        state.copyWith(
          isPlaying: false,
          isPaused: true,
          currentPosition: 0,
          reciter: reciter,
          surahNumber: 1,

          audioState: AudioFetchInit(),
        ),
      );
    }

    {
      String surahNumberZeroPad = state.surahNumber.toString().padLeft(3, '0');

      Reciter reciter = state.reciter;
      audioPlayer
          .setSourceUrl(
            'https://download.quranicaudio.com/quran/${reciter.name}/$surahNumberZeroPad.mp3',
          )
          .then((_) async {
            final duration = await audioPlayer.getDuration();
            if (duration != null) {
              dev.log("surah duration: ${duration.inSeconds}");
              emit(
                state.copyWith(surahDuration: duration.inSeconds.toDouble()),
              );
            } else {
              dev.log("Failed to get initial duration");
            }
          });
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
        await audioPlayer.seek(Duration(seconds: position.toInt()));
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
          audioState: AudioFetchFailure("توجد مشكلة اثناء تشغيل السورة"),
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

  void playRandomSurah() async {
    final random = Random();
    int randomSurah = random.nextInt(114) + 1;
    emit(state.copyWith(surahNumber: randomSurah, currentPosition: 0));
    await playSurah();
  }

  //here
  void changeRandomStatus() async {
    emit(state.copyWith(isRandom: !state.isRandom));
  }

  void setPlaybackRate(double rate) async {
    emit(state.copyWith(audioSpeed: rate));
    await audioPlayer.setPlaybackRate(rate);
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
  Future<void> close() {
    IsolateNameServer.removePortNameMapping(NotificationKeys.quranPlayer);
    receivePort?.close();
    audioPlayer.dispose();
    return super.close();
  }
}
