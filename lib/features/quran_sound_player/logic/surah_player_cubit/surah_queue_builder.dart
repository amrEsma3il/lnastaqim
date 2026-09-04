import 'dart:io';

import '../../../../core/utilits/services/audio_service/surah_playback_service.dart';
import '../../data/models/reciter_model/reciters_model.dart';

Future<List<SurahPlaybackItem>> buildSurahPlaybackQueue({
  required Directory documentsDirectory,
  required Reciter reciter,
  required Map<int, String> surahNames,
}) async {
  try {
    final reciterDirectory = Directory(
      '${documentsDirectory.path}/Quran_listening/${reciter.nameArabic}',
    );
    return await Future.wait(
      List<Future<SurahPlaybackItem>>.generate(114, (index) async {
        final number = index + 1;
        final paddedNumber = number.toString().padLeft(3, '0');
        final title = surahNames[number]!;
        final localFile = File('${reciterDirectory.path}/$title.mp3');
        return SurahPlaybackItem(
          id: 'surah:${reciter.name}:$number',
          uri:
              await localFile.exists()
                  ? localFile.uri
                  : Uri.parse(
                    'https://download.quranicaudio.com/quran/${reciter.name}/$paddedNumber.mp3',
                  ),
          title: title,
          reciter: reciter.nameArabic,
          surahNumber: number,
        );
      }),
    );
  } catch (error) {
    throw SurahPlaybackFailure(
      SurahPlaybackFailureType.queueFilesystem,
      'تعذر فحص ملفات التلاوة المحفوظة على الجهاز.',
      cause: error,
    );
  }
}
