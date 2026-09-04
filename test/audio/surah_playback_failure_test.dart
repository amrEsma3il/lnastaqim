import 'package:flutter_test/flutter_test.dart';
import 'package:lnastaqim/core/utilits/services/audio_service/surah_playback_service.dart';

void main() {
  test('remote load failures are classified as network failures', () {
    final failure = normalizeSurahPlaybackFailure(
      StateError('connection reset'),
      uri: Uri.parse('https://example.test/001.mp3'),
      duringLoad: true,
    );
    expect(failure.type, SurahPlaybackFailureType.network);
  });

  test('missing or corrupt local sources are classified as local failures', () {
    final failure = normalizeSurahPlaybackFailure(
      StateError('file missing'),
      uri: Uri.file('/downloads/001.mp3'),
      duringLoad: true,
    );
    expect(failure.type, SurahPlaybackFailureType.localFile);
  });

  test('runtime decoder errors are classified as player failures', () {
    final failure = normalizeSurahPlaybackFailure(
      StateError('decoder failed'),
      uri: Uri.parse('https://example.test/001.mp3'),
    );
    expect(failure.type, SurahPlaybackFailureType.player);
  });

  test('an existing typed failure is preserved', () {
    const original = SurahPlaybackFailure(
      SurahPlaybackFailureType.coordinatorActivation,
      'activation failed',
    );
    expect(normalizeSurahPlaybackFailure(original), same(original));
  });
}
