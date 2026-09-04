import 'dart:async';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:lnastaqim/core/utilits/services/audio_service/surah_playback_service.dart';
import 'package:lnastaqim/features/quran_sound_player/data/repo/surah_player_repo.dart';
import 'package:lnastaqim/features/quran_sound_player/logic/surah_player_cubit/surah_player_cubit.dart';
import 'package:lnastaqim/features/quran_sound_player/logic/surah_player_cubit/surah_player_state.dart';

class FakeSurahPlaybackService implements SurahPlaybackService {
  FakeSurahPlaybackService() {
    controller = StreamController<SurahPlaybackSnapshot>.broadcast(
      onListen: () => listeners++,
      onCancel: () => listeners--,
    );
  }

  late final StreamController<SurahPlaybackSnapshot> controller;
  SurahPlaybackSnapshot snapshot = const SurahPlaybackSnapshot();
  int listeners = 0;
  int playCalls = 0;
  int pauseCalls = 0;
  int stopCalls = 0;
  Duration? seekPosition;
  double? speed;
  Object? loadError;
  List<SurahPlaybackItem>? loadedItems;
  int? loadedIndex;

  void emit(SurahPlaybackSnapshot value) {
    snapshot = value;
    controller.add(value);
  }

  @override
  SurahPlaybackSnapshot get currentSnapshot => snapshot;

  @override
  Stream<SurahPlaybackSnapshot> get snapshots => controller.stream;

  @override
  Future<void> loadQueueAndPlay(
    List<SurahPlaybackItem> items,
    int index, {
    Duration initialPosition = Duration.zero,
  }) async {
    if (loadError case final error?) throw error;
    loadedItems = items;
    loadedIndex = index;
  }

  @override
  Future<void> pause() async => pauseCalls++;

  @override
  Future<void> play() async => playCalls++;

  @override
  Future<void> seek(Duration position) async => seekPosition = position;

  @override
  Future<void> setSpeed(double value) async => speed = value;

  @override
  Future<void> stop() async => stopCalls++;
}

void main() {
  late FakeSurahPlaybackService playback;
  late SurahPlayerCubit cubit;

  setUp(() {
    playback = FakeSurahPlaybackService();
    cubit = SurahPlayerCubit(
      SurahPlayerRepo(),
      playbackService: playback,
      documentsDirectoryProvider: () async => Directory('/tmp'),
      queueBuilder:
          ({
            required documentsDirectory,
            required reciter,
            required surahNames,
          }) async => List.generate(
            114,
            (index) => SurahPlaybackItem(
              id: 'surah:${reciter.name}:${index + 1}',
              uri: Uri.parse('https://example.test/${index + 1}.mp3'),
              title: surahNames[index + 1]!,
              reciter: reciter.nameArabic,
              surahNumber: index + 1,
            ),
          ),
      errorPresenter: (_) {},
    );
  });

  tearDown(() async {
    if (!cubit.isClosed) await cubit.close();
    await playback.controller.close();
  });

  test(
    'maps handler readiness, playback, position, and duration to state',
    () async {
      playback.emit(
        const SurahPlaybackSnapshot(
          itemId: 'surah:minshawi_mujawwad:1',
          playing: true,
          position: Duration(seconds: 12),
          duration: Duration(seconds: 30),
          processingState: SurahProcessingState.ready,
        ),
      );
      await Future<void>.delayed(Duration.zero);

      expect(cubit.state.isPlaying, isTrue);
      expect(cubit.state.isPaused, isFalse);
      expect(cubit.state.currentPosition, 12);
      expect(cubit.state.surahDuration, 30);
      expect(cubit.state.audioState, isA<AudioFetchSuccess>());
    },
  );

  test('maps handler errors without leaving UI in playing state', () async {
    playback.emit(
      SurahPlaybackSnapshot(
        itemId: 'surah:minshawi_mujawwad:1',
        processingState: SurahProcessingState.error,
        error: StateError('network failed'),
      ),
    );
    await Future<void>.delayed(Duration.zero);

    expect(cubit.state.isPlaying, isFalse);
    expect(cubit.state.audioState, isA<AudioFetchFailure>());
  });

  test('play and pause commands are explicit and idempotent', () async {
    playback.emit(
      const SurahPlaybackSnapshot(
        itemId: 'surah:minshawi_mujawwad:1',
        playing: false,
        processingState: SurahProcessingState.ready,
      ),
    );
    await Future<void>.delayed(Duration.zero);

    await cubit.togglePlayPause();
    expect(playback.playCalls, 1);
    expect(playback.pauseCalls, 0);

    playback.emit(
      const SurahPlaybackSnapshot(
        itemId: 'surah:minshawi_mujawwad:1',
        playing: true,
        processingState: SurahProcessingState.ready,
      ),
    );
    await Future<void>.delayed(Duration.zero);
    await cubit.togglePlayPause();
    expect(playback.pauseCalls, 1);
  });

  test('close cancels the handler snapshot subscription', () async {
    expect(playback.listeners, 1);

    await cubit.close();

    expect(playback.listeners, 0);
    playback.emit(
      const SurahPlaybackSnapshot(
        itemId: 'surah:minshawi_mujawwad:1',
        playing: true,
        processingState: SurahProcessingState.ready,
      ),
    );
    await Future<void>.delayed(Duration.zero);
    expect(cubit.isClosed, isTrue);
  });

  test('seek and speed changes are delegated to the handler', () async {
    playback.emit(
      const SurahPlaybackSnapshot(
        itemId: 'surah:minshawi_mujawwad:1',
        processingState: SurahProcessingState.ready,
      ),
    );
    await Future<void>.delayed(Duration.zero);
    await cubit.seek(42);
    await cubit.setPlaybackRate(1.25);

    expect(playback.seekPosition, const Duration(seconds: 42));
    expect(playback.speed, 1.25);
  });

  test(
    'selecting another surah loads it instead of resuming the old item',
    () async {
      playback.emit(
        const SurahPlaybackSnapshot(
          itemId: 'surah:minshawi_mujawwad:3',
          playing: true,
          processingState: SurahProcessingState.ready,
        ),
      );
      await Future<void>.delayed(Duration.zero);

      await cubit.changeSurahNum(4);
      await cubit.togglePlayPause();

      expect(playback.playCalls, 0);
      expect(playback.loadedIndex, 3);
      expect(playback.loadedItems![3].id, 'surah:minshawi_mujawwad:4');
    },
  );

  test(
    'selecting another reciter loads the new reciter instead of stale audio',
    () async {
      playback.emit(
        const SurahPlaybackSnapshot(
          itemId: 'surah:minshawi_mujawwad:3',
          playing: true,
          processingState: SurahProcessingState.ready,
        ),
      );
      await Future<void>.delayed(Duration.zero);
      final reciter = cubit.getAllReciters().firstWhere(
        (item) => item.name != 'minshawi_mujawwad',
      );

      await cubit.changeReciter(reciter);
      await cubit.togglePlayPause();

      expect(playback.playCalls, 0);
      expect(playback.loadedIndex, 0);
      expect(playback.loadedItems!.first.id, 'surah:${reciter.name}:1');
      playback.emit(
        SurahPlaybackSnapshot(
          itemId: 'surah:${reciter.name}:1',
          playing: true,
          processingState: SurahProcessingState.ready,
        ),
      );
      await Future<void>.delayed(Duration.zero);
      expect(cubit.state.isPlaying, isTrue);
    },
  );

  test('rejects invalid selection and leaves playback stopped', () async {
    await cubit.changeSurahNum(0);
    await cubit.playSurah();

    final failure = cubit.state.audioState as AudioFetchFailure;
    expect(failure.type, SurahPlaybackFailureType.invalidSelection);
    expect(playback.stopCalls, greaterThanOrEqualTo(2));
    expect(cubit.state.isPlaying, isFalse);
    expect(cubit.state.isPaused, isFalse);
  });

  test(
    'reports queue filesystem failure and does not call the player',
    () async {
      await cubit.close();
      cubit = SurahPlayerCubit(
        SurahPlayerRepo(),
        playbackService: playback,
        documentsDirectoryProvider: () async => Directory('/tmp'),
        queueBuilder:
            ({
              required documentsDirectory,
              required reciter,
              required surahNames,
            }) async =>
                throw const SurahPlaybackFailure(
                  SurahPlaybackFailureType.queueFilesystem,
                  'filesystem failed',
                ),
        errorPresenter: (_) {},
      );

      await cubit.playSurah();

      final failure = cubit.state.audioState as AudioFetchFailure;
      expect(failure.type, SurahPlaybackFailureType.queueFilesystem);
      expect(playback.loadedItems, isNull);
      expect(playback.stopCalls, 1);
    },
  );

  for (final type in [
    SurahPlaybackFailureType.network,
    SurahPlaybackFailureType.localFile,
    SurahPlaybackFailureType.player,
    SurahPlaybackFailureType.coordinatorActivation,
  ]) {
    test('surfaces $type load failure and cleans up playback', () async {
      playback.loadError = SurahPlaybackFailure(type, '$type failed');

      await cubit.playSurah();

      final failure = cubit.state.audioState as AudioFetchFailure;
      expect(failure.type, type);
      expect(playback.stopCalls, 1);
      expect(cubit.state.isPlaying, isFalse);
      expect(cubit.state.isPaused, isFalse);
    });
  }

  test('surfaces an asynchronous player stream failure by category', () async {
    playback.emit(
      const SurahPlaybackSnapshot(
        itemId: 'surah:minshawi_mujawwad:1',
        processingState: SurahProcessingState.error,
        error: SurahPlaybackFailure(
          SurahPlaybackFailureType.localFile,
          'corrupt local file',
        ),
      ),
    );
    await Future<void>.delayed(Duration.zero);

    final failure = cubit.state.audioState as AudioFetchFailure;
    expect(failure.type, SurahPlaybackFailureType.localFile);
    expect(cubit.state.isPlaying, isFalse);
  });
}
