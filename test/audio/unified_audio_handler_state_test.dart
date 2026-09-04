import 'package:audio_service/audio_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lnastaqim/core/utilits/services/audio_service/surah_playback_service.dart';
import 'package:lnastaqim/core/utilits/services/audio_service/ibtihal_playback_service.dart';
import 'package:lnastaqim/core/utilits/services/audio_service/unified_audio_handler.dart';

void main() {
  test('automatic player resume publishes playing state and pause control', () {
    // This snapshot represents playerStateStream emitting after just_audio
    // resumes itself following an interruption; no handler play/skip command
    // is involved.
    const automaticResume = SurahPlaybackSnapshot(
      itemId: 'surah:reciter:2',
      playing: true,
      position: Duration(seconds: 20),
      duration: Duration(minutes: 3),
      processingState: SurahProcessingState.ready,
    );

    final published = buildSurahPlaybackState(
      snapshot: automaticResume,
      bufferedPosition: const Duration(seconds: 30),
      speed: 1,
      queueIndex: 1,
    );

    expect(published.playing, isTrue);
    expect(published.controls, contains(MediaControl.pause));
    expect(published.controls, isNot(contains(MediaControl.play)));
  });

  test('Surah media items expose cached notification artwork', () {
    final artworkUri = Uri.file('/app-support/surah_notification_artwork.png');
    final item = SurahPlaybackItem(
      id: 'surah:reciter:2',
      uri: Uri.https('example.test', '/002.mp3'),
      title: 'سورة البقرة',
      reciter: 'القارئ',
      surahNumber: 2,
    );

    final mediaItem = buildSurahMediaItem(item, artworkUri: artworkUri);

    expect(mediaItem.artUri, artworkUri);
    expect(mediaItem.id, item.id);
    expect(mediaItem.title, item.title);
    expect(mediaItem.artist, item.reciter);
  });

  test('tail position is clamped to duration before snapshot publication', () {
    const duration = Duration(milliseconds: 46215);
    const finalPositionTick = Duration(milliseconds: 46236);

    final position = clampSurahPlaybackPosition(finalPositionTick, duration);

    expect(position, duration);
  });

  test('Ibtihal media items expose feature-specific notification artwork', () {
    final artworkUri = Uri.file(
      '/app-support/ibtihal_notification_artwork.png',
    );
    final item = IbtihalPlaybackItem(
      id: 'ibtihal:reciter:2',
      uri: Uri.https('example.test', '/ibtihal.mp3'),
      title: 'ابتهال',
      reciter: 'المبتهل',
      index: 2,
    );

    final mediaItem = buildIbtihalMediaItem(item, artworkUri: artworkUri);

    expect(mediaItem.artUri, artworkUri);
    expect(mediaItem.extras!['mode'], 'ibtihal');
    expect(mediaItem.extras!['index'], 2);
  });
}
