// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:developer';
import 'dart:developer' as dev;

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/keys.dart';
import '../../../../core/utilits/functions/toast_message.dart';
import '../../../quran/bussniess_logic/quran/quran_cubit.dart';
import '../../data/models/reciter_entity.dart';
import '../../view/widgets/reciters_component.dart';
import 'audio_state.dart';

class AudioControlCubit extends Cubit<AudioControlState> {
  final AudioPlayer _audioPlayer;

  AudioControlCubit()
    : _audioPlayer = AudioPlayer(),
      super(AudioControlState.initial());

  static AudioControlCubit get(BuildContext context) =>
      BlocProvider.of<AudioControlCubit>(context);

  audioPlayerListener(BuildContext context) {
    _audioPlayer.onPlayerComplete.listen((_) async {
      if (state.repeatCount < state.maxRepeats) {
        emit(state.copyWith(repeatCount: state.repeatCount + 1));
        await playVerse(state.currentVerse, context);
      } else {
        emit(state.copyWith(repeatCount: 0)); // Reset repeat counter
        playNextVerse(context);
      }
    });
  }

  updateVerseNumber(int verseNumber) {
    emit(state.copyWith(currentVerse: verseNumber));
  }

  Future<void> selectReciters(
    ReciterEntity reciter,
    BuildContext context,
  ) async {
    // Save the current position of the audio
    final Duration? currentPosition = await _audioPlayer.getCurrentPosition();

    log(currentPosition.toString());
    await stop();
    Box<ReciterEntity> box = Hive.box<ReciterEntity>(AppKeys.reciterBox);
    box.put(AppKeys.reciterNameKey, reciter);

    //TODO:stop immedatelly sound and save the time and play same sound at the saved time
    emit(state.copyWith(selectedReciter: reciter));
    if (context.mounted) playVerse(state.currentVerse, context);
  }

  changeAyaIndex(int verseNumber) {
    emit(state.copyWith(currentVerse: verseNumber));
  }

  Future<void> updatePage(
    int newPageNum,
    BuildContext context, {
    int verseNumber = 0,
  }) async {
    //remove this condition and use state
    if (newPageNum == state.pageNum + 1) {
      if (verseNumber != state.currentVerse + 1) {
        await stop();
      }
    } else {
      await stop();
    }

    emit(state.copyWith(pageNum: newPageNum));
  }

  Future<void> playVerse(
    int verseNumber,
    BuildContext context, {
    Duration? startPosition,
  }) async {
    // QuranCubit.get(context).searchAya(verseNumber-1);


    final quranCubit = QuranCubit.get(context);
    final directory = await getApplicationDocumentsDirectory();
    final reciterDir = Directory(
      '${directory.path}/Quran/${state.selectedReciter.reciter}',
    );

    log("page state from audio cubit${state.pageNum}");
    if (state.pageNum != quranCubit.getPageNumber(verseNumber)) {
      verseNumber = quranCubit.getFirstAyaPage(state.pageNum)!;
      log("first verse in page${quranCubit.getFirstAyaPage(state.pageNum)}");
    }
    // quranCubit.searchAya(verseNumber);


    final filePath = '${reciterDir.path}/$verseNumber.mp3';
    dev.log("before check file existence");
    if (await File(filePath).exists()) {
      dev.log("after check file found existence");
      emit(state.copyWith(playVerseBarStatus: PlayVerseBarStatus.turnOn));
      if (context.mounted) {
        //  print(quranCubit.getPageNumber(verseNumber).toDouble());
        quranCubit.pageController.jumpToPage(
          604 - quranCubit.getPageNumber(verseNumber),
        );
        emit(
          state.copyWith(pageNum: quranCubit.getPageNumber(verseNumber + 1)),
        );
        QuranCubit.get(context).searchAya(verseNumber);
      }
      // log(verseRepatedNumber[state.audioRepeat].toString());
      quranCubit.searchAya(verseNumber);

      await _audioPlayer.play(DeviceFileSource(filePath));
      print(state.isPlaying.toString());
      if (startPosition != null) {
        await _audioPlayer.seek(startPosition);
      }

      dev.log("state is playing before emit: ${state.isPlaying}");
      emit(state.copyWith(isPlaying: true, currentVerse: verseNumber));
      dev.log("state is playing after emit: ${state.isPlaying}");

      if (!await File('${reciterDir.path}/${verseNumber + 5}.mp3').exists() &&
          verseNumber < 6236 - 5) {
        downloadProcess(verseNumber, reciterDir);
      }
    } else {
      dev.log("after check file not foundexistance");
  final bool isConnected = await InternetConnectionChecker.instance.hasConnection;

if (isConnected){      print('Verse $verseNumber not found');
      //TODO:download 6 verse after and 2 befor

      emit(state.copyWith(playVerseBarStatus: PlayVerseBarStatus.loading));
      print(state.playVerseBarStatus.toString());
      downloadProcess(verseNumber, reciterDir).then((value) async {
        emit(state.copyWith(playVerseBarStatus: PlayVerseBarStatus.turnOn));
        if (context.mounted) {
          print(quranCubit.getPageNumber(verseNumber).toDouble());
          quranCubit.pageController.jumpToPage(
            604 - quranCubit.getPageNumber(verseNumber),
          );
          emit(state.copyWith(pageNum: quranCubit.getPageNumber(verseNumber)));

          QuranCubit.get(context).searchAya(verseNumber);
        }
        // log(verseRepatedNumber[state.audioRepeat].toString());
        quranCubit.searchAya(verseNumber);

        await _audioPlayer.play(DeviceFileSource(filePath));
        if (startPosition != null) {
          await _audioPlayer.seek(startPosition);
        }
        emit(state.copyWith(isPlaying: true, currentVerse: verseNumber));
      });
} else{
showToast("لتشغيل الآية لأول مرة يجب الاتصال بالإنترنت",AppColor.blueTint2);
  dev.log("No internet connection");
}   }
    if (verseNumber == 6236) {
      await stop();
    }
  }

  Future<void> playNextVerse(BuildContext context) async {
    if (state.currentVerse < 6236) {
    await  playVerse(state.currentVerse + 1, context);
    } else {
      print('All verses played');
    }
  }

  Future<void> playPreviousVerse(BuildContext context) async {
    if (state.currentVerse > 1) {
      await playVerse(state.currentVerse - 1, context);
    }
  }

  Future<void> togglePlayPause(BuildContext context, {int? verseNumber}) async {
    dev.log("current verse number: ${state.currentVerse}");
    dev.log("verse number: $verseNumber");
    if (state.isPlaying) {
      dev.log("pause verse");
     await _audioPlayer.pause();
    } else {
      if (_audioPlayer.state == PlayerState.stopped) {
        dev.log(" play new verse");
      await  playVerse(verseNumber ?? state.currentVerse, context);
      } else {
        if (verseNumber != null && verseNumber != state.currentVerse) {
          dev.log("stop and play new verse $verseNumber");
          await stop();
          if (context.mounted) playVerse(verseNumber, context);
        } else {
          dev.log("resume current verse");
      await    _audioPlayer.resume();
        }
      }
    }
    emit(
      state.copyWith(isPlaying: !state.isPlaying, currentVerse: verseNumber),
    );
  }

  Future<void> stop() async {
    await _audioPlayer.stop();
    emit(
      state.copyWith(
        isPlaying: false,
        playVerseBarStatus: PlayVerseBarStatus.init,
      ),
    );
  }

  void toggleRepeat() {
    int newMaxRepeats =
        state.maxRepeats == 0 ? 1 : (state.maxRepeats == 1 ? 2 : 0);
    emit(state.copyWith(maxRepeats: newMaxRepeats, repeatCount: 0));
  }

  Future<void> downloadProcess(int verseNumber, Directory reciterDir) async {
    //TODO: SHOW NOTIFICATION WITH DOWNLOAD INDICATOR BAR
    await reciterDir.create(recursive: true);

    for (int i = verseNumber; i <= verseNumber + 5; i++) {
      final url = '${state.selectedReciter.downloadUrl}$i.mp3';
      final filePath = '${reciterDir.path}/$i.mp3';

      if (!await File(filePath).exists()) {
        try {
          final response = await http.get(Uri.parse(url));
          if (response.statusCode == 200) {
            final file = File(filePath);
            await file.writeAsBytes(response.bodyBytes);
          }
        } catch (e) {
          showToast("فشل في تحميل الآية رقم $i",AppColor.blueTint2);
          print('Error downloading verse $i: $e');
        }
      }
    }
  }

  showReciters(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColor.blueColor.withOpacity(0.9),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(48.r),
          topLeft: Radius.circular(48.r),
        ),
      ),
      builder:
          (context) => Container(
            decoration: BoxDecoration(
              color: AppColor.blueColor.withOpacity(0.9),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(48.r),
                topLeft: Radius.circular(48.r),
              ),
            ),
            height: 600.h,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 8.w),
                        child: const Text(
                          "اختار القارئ",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(width: 15),
                      IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: const Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 27,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: ListView.separated(
                      separatorBuilder:
                          (context, index) => Container(
                            width: Get.width,
                            height: 0.3,
                            color: Colors.white38,
                          ),
                      itemBuilder: (context, index) {
                        ReciterEntity reciter = recitersInfo[index];
                        return RecitersComponent(reciter: reciter);
                      },
                      itemCount: recitersInfo.length,
                    ),
                  ),
                ],
              ),
            ),
          ),
    );
  }
}
