// ignore_for_file: avoid_print

import 'dart:developer';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/keys.dart';
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
    _audioPlayer.onPlayerComplete.listen((_) {
      if (state.repeatCount < state.maxRepeats) {
        emit(state.copyWith(repeatCount: state.repeatCount + 1));
        playVerse(state.currentVerse, context);
      } else {
        emit(state.copyWith(repeatCount: 0)); // Reset repeat counter
        playNextVerse(context);
      }
    });
  }

  updateVerseNumber(int verseNumber) {
    emit(state.copyWith(currentVerse: verseNumber));
  }

  selectReciters(ReciterEntity reciter) {
    Box<ReciterEntity> box = Hive.box<ReciterEntity>(AppKeys.reciterBox);
    box.put(AppKeys.reciterNameKey, reciter);
    emit(state.copyWith(selectedReciter: reciter));
  }

  changeAyaIndex(int verseNumber) {
    emit(state.copyWith(currentVerse: verseNumber));
  }

  void updatePage(int newPageNum) {
    emit(state.copyWith(pageNum: newPageNum));
  }

  Future<void> playVerse(int verseNumber, BuildContext context) async {
    // QuranCubit.get(context).searchAya(verseNumber-1);
    final quranCubit = QuranCubit.get(context);
    final directory = await getApplicationDocumentsDirectory();
    final reciterDir =
        Directory('${directory.path}/${state.selectedReciter.reciter}');

    log("page state from audio cubit${state.pageNum}");
    if (state.pageNum != quranCubit.getPageNumber(verseNumber)) {
      verseNumber = quranCubit.getFirstAyaPage(state.pageNum)!;
      log("first verse in page${quranCubit.getFirstAyaPage(state.pageNum)}");
    }
    // quranCubit.searchAya(verseNumber);


    final filePath = '${reciterDir.path}/$verseNumber.mp3';

    if (await File(filePath).exists()) {
      emit(state.copyWith(playVerseBarStatus: PlayVerseBarStatus.turnOn));
      if (context.mounted) {
        //  print(quranCubit.getPageNumber(verseNumber).toDouble());
        quranCubit.pageController
            .jumpToPage(604 - quranCubit.getPageNumber(verseNumber));
        emit(
            state.copyWith(pageNum: quranCubit.getPageNumber(verseNumber + 1)));
        QuranCubit.get(context).searchAya(verseNumber);
      }
      // log(verseRepatedNumber[state.audioRepeat].toString());
      quranCubit.searchAya(verseNumber);

      await _audioPlayer.play(DeviceFileSource(filePath));
      print(state.isPlaying.toString());
      emit(state.copyWith(
        isPlaying: true,
        currentVerse: verseNumber,
      ));

      if (!await File('${reciterDir.path}/${verseNumber + 5}.mp3').exists() &&
          verseNumber < 6236 - 5) {
        downloadProcess(verseNumber, reciterDir);
      }
    } else {
      print('Verse $verseNumber not found');
      //TODO:download 6 verse after and 2 befor

      emit(state.copyWith(playVerseBarStatus: PlayVerseBarStatus.loading));
      print(state.playVerseBarStatus.toString());
      downloadProcess(verseNumber, reciterDir).then((value) async {
        emit(state.copyWith(playVerseBarStatus: PlayVerseBarStatus.turnOn));
        if (context.mounted) {
          print(quranCubit.getPageNumber(verseNumber).toDouble());
          quranCubit.pageController
              .jumpToPage(604 - quranCubit.getPageNumber(verseNumber));
          emit(state.copyWith(pageNum: quranCubit.getPageNumber(verseNumber)));

          QuranCubit.get(context).searchAya(verseNumber);
        }
        // log(verseRepatedNumber[state.audioRepeat].toString());
        quranCubit.searchAya(verseNumber);

        await _audioPlayer.play(DeviceFileSource(filePath));

        emit(state.copyWith(
          isPlaying: true,
          currentVerse: verseNumber,
        ));
      });
    }
    if (verseNumber == 6236) {
      stop();
    }
  }

  void playNextVerse(BuildContext context) {
    if (state.currentVerse < 6236) {
      playVerse(state.currentVerse + 1, context);
    } else {
      print('All verses played');
    }
  }

  void playPreviousVerse(BuildContext context) {
    if (state.currentVerse > 1) {
      playVerse(state.currentVerse - 1, context);
    }
  }

  void togglePlayPause(BuildContext context, {int? verseNumber}) {
    if (state.isPlaying) {
      _audioPlayer.pause();
    } else {
      if (_audioPlayer.state == PlayerState.stopped) {
        playVerse(verseNumber ?? state.currentVerse, context);
      } else {
        _audioPlayer.resume();
      }
    }
    emit(state.copyWith(isPlaying: !state.isPlaying));
  }

  void stop() {
    _audioPlayer.stop();
    emit(state.copyWith(
        isPlaying: false, playVerseBarStatus: PlayVerseBarStatus.init));
  }

  void toggleRepeat() {
    int newMaxRepeats =
     state.maxRepeats == 0 ?1:   ( state.maxRepeats == 1 ? 2 : 0);
    emit(state.copyWith(maxRepeats: newMaxRepeats, repeatCount: 0));
  }

  Future<void> downloadProcess(int verseNumber, Directory reciterDir) async {
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
              topRight: Radius.circular(48.r), topLeft: Radius.circular(48.r))),
      builder: (context) => Container(
        decoration: BoxDecoration(
            color: AppColor.blueColor.withOpacity(0.9),
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(48.r),
                topLeft: Radius.circular(48.r))),
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
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: const Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 27,
                        ))
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: ListView.separated(
                    separatorBuilder: (context, index) => Container(
                      width: Get.width,
                      height: 0.3,
                      color: Colors.white38,
                    ),
                    itemBuilder: (context, index) {
                      ReciterEntity reciter = recitersInfo[index];
                      return RecitersComponent(
                        reciter: reciter,
                      );
                    },
                    itemCount: recitersInfo.length,
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
