import 'dart:io';

import '../../../core/utilits/services/audio_service/ibtihal_playback_service.dart';
import '../../../core/utilits/services/audio_service/surah_playback_service.dart';
import '../data/models/reciter_ibtihal_model/reciter_ibtihal_model.dart';

typedef IbtihalFileExists = Future<bool> Function(String path);

Future<List<IbtihalPlaybackItem>> buildIbtihalPlaybackQueue({
  required Directory documentsDirectory,
  required ReciterIbtihalModel reciter,
  IbtihalFileExists? fileExists,
}) async {
  try {
    final exists = fileExists ?? (path) => File(path).exists();
    final items = <IbtihalPlaybackItem>[];
    for (var index = 0; index < reciter.info.length; index++) {
      final info = reciter.info[index];
      final path =
          '${documentsDirectory.path}/Ibtihalat_listening/'
          '${reciter.nameArabic}/ابتهال ${info.name}.mp3';
      final uri = await exists(path) ? File(path).uri : Uri.parse(info.url);
      items.add(
        IbtihalPlaybackItem(
          id: 'ibtihal:${reciter.name}:$index',
          uri: uri,
          title: info.name,
          reciter: reciter.nameArabic,
          index: index,
        ),
      );
    }
    return List.unmodifiable(items);
  } catch (error) {
    throw SurahPlaybackFailure(
      SurahPlaybackFailureType.queueFilesystem,
      'تعذر فحص ملفات الابتهالات المحفوظة.',
      cause: error,
    );
  }
}
