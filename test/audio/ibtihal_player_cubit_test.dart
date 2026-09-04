import 'dart:async';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:lnastaqim/core/utilits/services/audio_service/ibtihal_playback_service.dart';
import 'package:lnastaqim/core/utilits/services/audio_service/surah_playback_service.dart';
import 'package:lnastaqim/features/ibtihal/bussnies_logic/ibtihal_player_cubit.dart';
import 'package:lnastaqim/features/ibtihal/data/models/ibtihal_info.dart';
import 'package:lnastaqim/features/ibtihal/data/models/reciter_ibtihal_model/reciter_ibtihal_model.dart';
import 'package:lnastaqim/features/ibtihal/data/repo/ibtihal_player_repo.dart';

class FakeIbtihalPlaybackService implements IbtihalPlaybackService {
  FakeIbtihalPlaybackService() {
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
  List<IbtihalPlaybackItem>? loadedItems;
  int? loadedIndex;
  Object? loadError;
  Duration? seekPosition;
  double? speed;

  void emit(SurahPlaybackSnapshot value) {
    snapshot = value;
    controller.add(value);
  }

  @override
  SurahPlaybackSnapshot get currentSnapshot => snapshot;

  @override
  Stream<SurahPlaybackSnapshot> get snapshots => controller.stream;

  @override
  Future<void> loadIbtihalQueueAndPlay(
    List<IbtihalPlaybackItem> items,
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

class TestIbtihalRepo extends IbtihalatPlayerRepo {
  @override
  bool isFavorite({required int ibtihalNumber, required int reciterId}) =>
      false;
}

void main() {
  late FakeIbtihalPlaybackService playback;
  late IbtihalatPlayerCubit cubit;

  List<IbtihalPlaybackItem> queueFor(ReciterIbtihalModel reciter) =>
      List.generate(
        reciter.info.length,
        (index) => IbtihalPlaybackItem(
          id: 'ibtihal:${reciter.name}:$index',
          uri: Uri.parse(reciter.info[index].url),
          title: reciter.info[index].name,
          reciter: reciter.nameArabic,
          index: index,
        ),
      );

  setUp(() {
    playback = FakeIbtihalPlaybackService();
    cubit = IbtihalatPlayerCubit(
      TestIbtihalRepo(),
      playbackService: playback,
      documentsDirectoryProvider: () async => Directory('/tmp'),
      queueBuilder:
          ({required documentsDirectory, required reciter}) async =>
              queueFor(reciter),
      errorPresenter: (_) {},
    );
  });

  tearDown(() async {
    if (!cubit.isClosed) await cubit.close();
    await playback.controller.close();
  });

  test('maps matching handler snapshots and clamps tail position', () async {
    playback.emit(
      const SurahPlaybackSnapshot(
        itemId: 'ibtihal:mohammed_omran:0',
        playing: true,
        position: Duration(milliseconds: 46236),
        duration: Duration(milliseconds: 46215),
        processingState: SurahProcessingState.ready,
      ),
    );
    await Future<void>.delayed(Duration.zero);

    expect(cubit.state.isPlaying, isTrue);
    expect(cubit.state.currentPosition, 46.215);
    expect(cubit.state.ibtihalDuration, 46.215);
    expect(cubit.state.audioState, isA<AudioFetchSuccess>());
  });

  test('resumes only when loaded media matches current selection', () async {
    playback.emit(
      const SurahPlaybackSnapshot(
        itemId: 'ibtihal:mohammed_omran:0',
        processingState: SurahProcessingState.ready,
      ),
    );
    await Future<void>.delayed(Duration.zero);
    await cubit.togglePlayPause();
    expect(playback.playCalls, 1);

    await cubit.changeIbtihalNum(1);
    await cubit.togglePlayPause();
    expect(playback.playCalls, 1);
    expect(playback.loadedIndex, 1);
    expect(playback.loadedItems![1].id, 'ibtihal:mohammed_omran:1');
  });

  test('a delayed stopped snapshot cannot undo a new UI selection', () async {
    await cubit.changeIbtihalNum(1);
    playback.emit(
      const SurahPlaybackSnapshot(
        itemId: 'ibtihal:mohammed_omran:0',
        processingState: SurahProcessingState.idle,
      ),
    );
    await Future<void>.delayed(Duration.zero);

    expect(cubit.state.ibtihalNumber, 1);
  });

  test('changing reciter loads new selection and accepts its state', () async {
    final reciter = ReciterIbtihalModel(
      id: 99,
      name: 'new_reciter',
      nameArabic: 'مبتهل جديد',
      nationality: 'مصر',
      info: [IbtihalInfo(name: 'جديد', url: 'https://example.test/new.mp3')],
    );

    await cubit.changeReciter(reciter);
    await cubit.togglePlayPause();
    expect(playback.loadedItems!.single.id, 'ibtihal:new_reciter:0');

    playback.emit(
      const SurahPlaybackSnapshot(
        itemId: 'ibtihal:new_reciter:0',
        playing: true,
        processingState: SurahProcessingState.ready,
      ),
    );
    await Future<void>.delayed(Duration.zero);
    expect(cubit.state.isPlaying, isTrue);
  });

  test('stale idle snapshots cannot undo a bottom-sheet selection', () async {
    await cubit.changeIbtihalNum(1);
    playback.emit(
      const SurahPlaybackSnapshot(
        itemId: 'ibtihal:mohammed_omran:0',
        processingState: SurahProcessingState.idle,
      ),
    );
    await Future<void>.delayed(Duration.zero);

    expect(cubit.state.ibtihalNumber, 1);
  });

  test('natural completion advances and loads the next item', () async {
    playback.emit(
      const SurahPlaybackSnapshot(
        itemId: 'ibtihal:mohammed_omran:0',
        processingState: SurahProcessingState.completed,
      ),
    );
    await Future<void>.delayed(const Duration(milliseconds: 10));

    expect(cubit.state.ibtihalNumber, 1);
    expect(playback.loadedIndex, 1);
  });

  for (final type in SurahPlaybackFailureType.values) {
    test('surfaces and cleans up $type failures', () async {
      playback.loadError = SurahPlaybackFailure(type, 'failure');

      await cubit.playIbtihal();

      final failure = cubit.state.audioState as AudioFetchFailure;
      expect(failure.type, type);
      expect(failure.errorMessage, isNotEmpty);
      expect(playback.stopCalls, 1);
      expect(cubit.state.isPlaying, isFalse);
      expect(cubit.state.isPaused, isFalse);
    });
  }

  test('queue-building failure is surfaced before player loading', () async {
    await cubit.close();
    cubit = IbtihalatPlayerCubit(
      TestIbtihalRepo(),
      playbackService: playback,
      documentsDirectoryProvider: () async => Directory('/tmp'),
      queueBuilder:
          ({required documentsDirectory, required reciter}) async =>
              throw const SurahPlaybackFailure(
                SurahPlaybackFailureType.queueFilesystem,
                'filesystem failed',
              ),
      errorPresenter: (_) {},
    );

    await cubit.playIbtihal();

    expect(playback.loadedItems, isNull);
    expect(
      (cubit.state.audioState as AudioFetchFailure).type,
      SurahPlaybackFailureType.queueFilesystem,
    );
    expect(playback.stopCalls, 1);
  });

  test('invalid selected index is rejected without loading a queue', () async {
    await cubit.changeIbtihalNum(-1);
    await cubit.playIbtihal();

    expect(playback.loadedItems, isNull);
    expect(
      (cubit.state.audioState as AudioFetchFailure).type,
      SurahPlaybackFailureType.invalidSelection,
    );
  });

  test('seek and speed delegate to the unified service', () async {
    playback.emit(
      const SurahPlaybackSnapshot(
        itemId: 'ibtihal:mohammed_omran:0',
        processingState: SurahProcessingState.ready,
      ),
    );
    await Future<void>.delayed(Duration.zero);

    await cubit.seek(12.25);
    await cubit.setPlaybackRate(1.25);

    expect(playback.seekPosition, const Duration(milliseconds: 12250));
    expect(playback.speed, 1.25);
  });

  test('close cancels the shared snapshot subscription', () async {
    expect(playback.listeners, 1);
    await cubit.close();
    expect(playback.listeners, 0);
  });
}
