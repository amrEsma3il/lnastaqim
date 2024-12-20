import 'dart:developer' as dev;
import 'dart:io';
import 'dart:math';

// import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

import '../../../../core/constants/images.dart';
import '../../../share/views/widgets/share_fun.dart';
import '../../data/models/reciters__model.dart';
import '../../data/repo/repo.dart';
import 'surah_player_state.dart';

import 'package:audioplayers/audioplayers.dart';

class SurahPlayerCubit extends Cubit<SurahPlayerState> {
  final AudioPlayer audioPlayer = AudioPlayer();
  final RecitersRepository recitersRepository;
  // static const channel = MethodChannel('qr.lnastaqim/channel');
  static SurahPlayerCubit get(BuildContext context) => BlocProvider.of(context);

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
    "غير معروف": AppImages.unknownFlag
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


static List<double> audioSpeedRates=[0.5,0.75,1,1.25,1.75,2];
  SurahPlayerCubit(this.recitersRepository)
      : super(SurahPlayerState.initial()) {
    // تحديث حالة التشغيل
    audioPlayer.onPlayerStateChanged.listen((PlayerState state) {
      emit(state == PlayerState.playing
          ? this.state.copyWith(isPlaying: true)
          : this.state.copyWith(isPlaying: false));
    });

    // تحديث حالة الموقع الحالي
    audioPlayer.onPositionChanged.listen((Duration p) {
      if (!state.isSeeking) {
        // لا يتم تحديث السلايدر أثناء السحب
        dev.log("تم تغير البوزيشن تلقائيًا: ${p.inSeconds}");
        emit(state.copyWith(currentPosition: p.inSeconds.toDouble()));
      }
    });

    // تحديث مدة الصوت
    audioPlayer.onDurationChanged.listen((Duration d) {
      dev.log("تم تغير طول الساوند");
      dev.log(d.inSeconds.toDouble().toString());
      emit(state.copyWith(surahDuration: d.inSeconds.toDouble()));
    });

    // عند انتهاء الصوت
    audioPlayer.onPlayerComplete.listen((event) {
      if (state.onRepeat) {
        // emit(state.copyWith(repeatCount: state.repeatCount + 1));
        playSurah();
      } else {
        // emit(state.copyWith(repeatCount: 0)); // Reset repeat counter
        nextSurah();
      }
    });
  }

  static String formatDuration(int seconds) {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final secs = (seconds % 60).toString().padLeft(2, '0');
    return "$minutes:$secs";
  }

  List<Reciter> getAllReciters() {
    return recitersRepository.getAllReciters();
  }

  Future<void> playSurah() async {
    dev.log("from play method");
    String surahNumberZeroPad = state.surahNumber.toString().padLeft(3, '0');
    final directory = await getApplicationDocumentsDirectory();
    Reciter reciter = state.reciter;
    String url =
        'https://download.quranicaudio.com/quran/${reciter.name}/$surahNumberZeroPad.mp3';

    final reciterDir = Directory(
        '${directory.path}/Quran_listening/${state.reciter.nameArabic}');

    emit(state.copyWith(audioState: AudioFetchLoading()));
    // تعيين مصدر الصوت وتشغيله مباشرة
    try {
      final String filePath = '${reciterDir.path}/${state.surahNumber}.mp3';

      if (await File(filePath).exists()) {

        dev.log("بلاي من الاستوردج");
        //TODO : play WITH local SOUND
        await audioPlayer.play(DeviceFileSource(filePath));
      } else {
        await audioPlayer.setSourceUrl(url);
        // await _audioHandler.play();
        await audioPlayer.play(UrlSource(url));
      }

      // await channel.invokeMethod('playMedia');
      emit(state.copyWith(
          audioState: AudioFetchSuccess(), isPlaying: true, isPaused: false));
    } catch (e) {
      //TODO: neccessary handle errors
      dev.log(e.toString());
      await audioPlayer.stop();
      // await channel.invokeMethod('pauseMedia');
      emit(state.copyWith(isPlaying: false, audioState: AudioFetchFailure()));
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

  void togglePlayPause() async {
    if (state.isPlaying) {
      await audioPlayer.pause();
      // await channel.invokeMethod('pauseMedia');
      emit(state.copyWith(isPlaying: false, isPaused: true));
    } else {
      if (state.isPaused) {
    await    audioPlayer.resume();
        emit(state.copyWith(isPlaying: true, isPaused: false));
      } else {
     await   playSurah();
      }
      // await channel.invokeMethod('playMedia');
    }
  }

  void nextSurah()async {
    if (state.surahNumber < 114) {
      emit(state.copyWith(
          surahNumber: state.surahNumber + 1, currentPosition: 0));
   await   playSurah();
    }
  }

  void previousSurah()async {
    if (state.surahNumber > 1) {
      emit(state.copyWith(
          surahNumber: state.surahNumber - 1, currentPosition: 0));
  await    playSurah();
    }
  }

  changeSurahNum(int surahNumber) async{
    if (state.surahNumber != surahNumber) {
      emit(state.copyWith(surahNumber: surahNumber, currentPosition: 0));

     await playSurah();
    } else {
      if (state.isPaused) {
     await   audioPlayer.resume();
      } else if (!state.isPlaying) {
      await  playSurah();
      } else {
        emit(state.copyWith(isPlaying: true, isPaused: false));
      }
    }
    // تشغيل السورة المختارة
    Get.back();
  }

  changeReciter(Reciter reciter)async {
    if (state.reciter.name != reciter.name) {
      emit(state.copyWith(reciter: reciter, currentPosition: 0));

     await playSurah();
    } else {
      if (state.isPaused) {
      await  audioPlayer.resume();
      } else if (!state.isPlaying) {
    await    playSurah();
      } else {
        emit(state.copyWith(isPlaying: true, isPaused: false));
      }
    }
    // تشغيل السورة المختارة
    Get.back();
  }

  void toggleRepeat() {
    // int newMaxRepeats =
    //  state.maxRepeats == 0 ?1:   ( state.maxRepeats == 1 ? 2 : 0);
    emit(state.copyWith(onRepeat: !state.onRepeat));
  }

  void seek(double position) async {
    dev.log("تغير مكان السلايدر بالتفاعل: $position");

    // تعطيل التحديثات التلقائية
    emit(state.copyWith(isSeeking: true, audioState: AudioFetchLoading()));

    // تنفيذ seek
    try {
      await audioPlayer.seek(Duration(seconds: position.toInt()));

     await playSurah();
      // emit(state.copyWith(  audioState: AudioFetchSuccess(),
      //     isPlaying: true,isPaused: false));
    } on PlatformException catch (e) {
      dev.log(e.toString());
      await audioPlayer.stop();
      emit(state.copyWith(isPlaying: false, audioState: AudioFetchFailure()));
    }

    // تمكين التحديثات التلقائية
    emit(state.copyWith(isSeeking: false));
  }


  changeAudioPosition(double value) {
    emit(state.copyWith(currentPosition: value));
  }

  void sliderSeekToggle({required bool isSeeking}) {
    emit(state.copyWith(isSeeking: isSeeking));
  }

  void playRandomSurah() async{
    final random = Random();
    int randomSurah = random.nextInt(114) + 1;
    emit(state.copyWith(surahNumber: randomSurah));
   await playSurah();
  }


 void setPlaybackRate(double rate)async {
 
     emit(state.copyWith(audioSpeed: rate));
     await audioPlayer.setPlaybackRate(rate);
          // await    playSurah();

  
  }







//البحث والفلترة

  /// البحث عن السور بناءً على الاسم
  void searchSurahs(String query) {
    if (query.isEmpty) {
      emit(state
          .copyWith(searchSurahResults: [])); // إفراغ النتائج عند البحث الفارغ
      return;
    }

    final filteredSurahs = quranSurahs.entries
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

    final filteredReciters =
        recitersRepository.filterReciters(reciterCountry, reciterSearchQuery);

    emit(state.copyWith(
      searchReciterResults: filteredReciters,
      reciterCountry: reciterCountry,
      reciterSearchQuery: reciterSearchQuery,
    ));
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
    emit(state.copyWith(
      searchSurahResults: quranSurahs.keys.toList(),
    ));
  }

  void clearReciterSearch() {
    emit(state.copyWith(
        searchReciterResults: recitersRepository.getAllReciters(),
        reciterCountry: "كل الدول",
        reciterSearchQuery: ""));
  }

//others
  Future<void> downloadSurah() async {

    dev.log("start download");
    final directory = await getApplicationDocumentsDirectory();

    final reciterDir = Directory(
        '${directory.path}/Quran_listening/${state.reciter.nameArabic}');
    //TODO: SHOW NOTIFICATION WITH DOWNLOAD INDICATOR BAR
    await reciterDir.create(recursive: true);

    String surahNumberZeroPad = state.surahNumber.toString().padLeft(3, '0');
    Reciter reciter = state.reciter;
    String url =
        'https://download.quranicaudio.com/quran/${reciter.name}/$surahNumberZeroPad.mp3';

    final filePath = '${reciterDir.path}/${state.surahNumber}.mp3';

    if (!await File(filePath).exists()) {
      try {
        final response = await http.get(Uri.parse(url));
        if (response.statusCode == 200) {
          final file = File(filePath);
          await file.writeAsBytes(response.bodyBytes);
        }
      } catch (e) {
        print('Error downloading Surah ${quranSurahs[state.surahNumber]} ');
      }
    }
  }

  shareSurah() async {
    final directory = await getApplicationDocumentsDirectory();

    final reciterDir = Directory(
        '${directory.path}/Quran_listening/${state.reciter.nameArabic}');
    final filePath = '${reciterDir.path}/${state.surahNumber}.mp3';

    String surahNumberZeroPad = state.surahNumber.toString().padLeft(3, '0');
    Reciter reciter = state.reciter;
    String url =
        'https://download.quranicaudio.com/quran/${reciter.name}/$surahNumberZeroPad.mp3';

    try {
      if (await File(filePath).exists()) {
        //TODO : play WITH local SOUND

        await shareSound(filePath,des: quranSurahs[state.surahNumber],subject: "سورة من القرءان الكريم");
      } else {
        await shareText("${quranSurahs[state.surahNumber]}............... رابط الاستماع والتحميل : $url",subject: "سورة من القرءان الكريم");
      }
    } catch (e) {
      dev.log(e.toString());
    }
  }

  @override
  Future<void> close() {
    audioPlayer.dispose();
    return super.close();
  }
}
