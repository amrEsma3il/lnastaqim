import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:lnastaqim/core/utilits/services/audio_service/surah_playback_service.dart';
import 'package:lnastaqim/features/ibtihal/bussnies_logic/ibtihal_queue_builder.dart';
import 'package:lnastaqim/features/ibtihal/data/models/ibtihal_info.dart';
import 'package:lnastaqim/features/ibtihal/data/models/reciter_ibtihal_model/reciter_ibtihal_model.dart';

void main() {
  final reciter = ReciterIbtihalModel(
    id: 1,
    name: 'reciter',
    nameArabic: 'المبتهل',
    nationality: 'مصر',
    info: [
      IbtihalInfo(name: 'الأول', url: 'https://example.test/1.mp3'),
      IbtihalInfo(name: 'الثاني', url: 'https://example.test/2.mp3'),
      IbtihalInfo(name: 'الثالث', url: 'https://example.test/3.mp3'),
    ],
  );

  test('prefers downloaded files for every queue item', () async {
    final queue = await buildIbtihalPlaybackQueue(
      documentsDirectory: Directory('/documents'),
      reciter: reciter,
      fileExists:
          (path) async => path.contains('الأول') || path.contains('الثالث'),
    );

    expect(queue[0].uri.scheme, 'file');
    expect(queue[1].uri, Uri.parse('https://example.test/2.mp3'));
    expect(queue[2].uri.scheme, 'file');
    expect(queue.map((item) => item.id), [
      'ibtihal:reciter:0',
      'ibtihal:reciter:1',
      'ibtihal:reciter:2',
    ]);
  });

  test('wraps filesystem failures in a typed queue error', () async {
    expect(
      () => buildIbtihalPlaybackQueue(
        documentsDirectory: Directory('/documents'),
        reciter: reciter,
        fileExists: (_) async => throw FileSystemException('denied'),
      ),
      throwsA(
        isA<SurahPlaybackFailure>().having(
          (failure) => failure.type,
          'type',
          SurahPlaybackFailureType.queueFilesystem,
        ),
      ),
    );
  });
}
