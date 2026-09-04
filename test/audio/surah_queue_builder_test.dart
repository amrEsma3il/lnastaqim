import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:lnastaqim/features/quran_sound_player/data/models/reciter_model/reciters_model.dart';
import 'package:lnastaqim/features/quran_sound_player/logic/surah_player_cubit/surah_player_cubit.dart';
import 'package:lnastaqim/features/quran_sound_player/logic/surah_player_cubit/surah_queue_builder.dart';

void main() {
  test('every queue item prefers its downloaded file when present', () async {
    final documentsDirectory = await Directory.systemTemp.createTemp(
      'lnastaqim-surah-queue-',
    );
    addTearDown(() => documentsDirectory.delete(recursive: true));
    final reciter = Reciter(
      id: 1,
      name: 'test_reciter',
      nameArabic: 'قارئ الاختبار',
      nationality: 'مصر',
    );
    final reciterDirectory = Directory(
      '${documentsDirectory.path}/Quran_listening/${reciter.nameArabic}',
    );
    await reciterDirectory.create(recursive: true);
    final downloadedSecondSurah = File(
      '${reciterDirectory.path}/${SurahPlayerCubit.quranSurahs[2]}.mp3',
    );
    await downloadedSecondSurah.writeAsBytes([1, 2, 3]);

    final queue = await buildSurahPlaybackQueue(
      documentsDirectory: documentsDirectory,
      reciter: reciter,
      surahNames: SurahPlayerCubit.quranSurahs,
    );

    expect(queue, hasLength(114));
    expect(queue[1].uri, downloadedSecondSurah.uri);
    expect(queue[0].uri.scheme, 'https');
    expect(queue[2].uri.scheme, 'https');
  });
}
