import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:audio_service/audio_service.dart';
import 'package:audio_session/audio_session.dart';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart' as just_audio;
import 'package:path_provider/path_provider.dart';

import '../../../constants/images.dart';
import 'ibtihal_playback_service.dart';
import 'playback_coordinator.dart';
import 'players_key.dart';
import 'surah_playback_service.dart';

class UnifiedAudioHandler extends BaseAudioHandler
    with SeekHandler
    implements SurahPlaybackService, IbtihalPlaybackService {
  UnifiedAudioHandler({
    just_audio.AudioPlayer? player,
    Uri? artworkUri,
    Uri? ibtihalArtworkUri,
  }) : _player = player ?? just_audio.AudioPlayer(),
       _artworkUri = artworkUri,
       _ibtihalArtworkUri = ibtihalArtworkUri {
    PlaybackCoordinator.instance.register(NotificationKeys.quranPlayer, pause);
    PlaybackCoordinator.instance.register(
      NotificationKeys.ibtihalatPlayer,
      pause,
    );
    _subscriptions.addAll([
      _player.playerStateStream.listen(_publishPlayerState),
      _player.positionStream.listen(_publishPosition),
      _player.durationStream.listen(_publishDuration),
      _player.playbackEventStream.listen(
        (_) {},
        onError: (Object error, StackTrace stackTrace) {
          unawaited(
            _handleFailure(
              normalizeSurahPlaybackFailure(error, uri: _currentItem?.uri),
            ),
          );
        },
      ),
    ]);
  }

  final just_audio.AudioPlayer _player;
  final Uri? _artworkUri;
  final Uri? _ibtihalArtworkUri;
  final List<StreamSubscription<dynamic>> _subscriptions = [];
  final StreamController<SurahPlaybackSnapshot> _snapshotController =
      StreamController<SurahPlaybackSnapshot>.broadcast();
  SurahPlaybackSnapshot _snapshot = const SurahPlaybackSnapshot();
  _UnifiedPlaybackItem? _currentItem;
  List<_UnifiedPlaybackItem> _playbackQueue = const [];
  String _activeParticipantKey = NotificationKeys.quranPlayer;
  int _queueIndex = 0;
  int _loadGeneration = 0;

  @override
  Stream<SurahPlaybackSnapshot> get snapshots => _snapshotController.stream;

  @override
  SurahPlaybackSnapshot get currentSnapshot => _snapshot;

  @override
  Future<void> loadQueueAndPlay(
    List<SurahPlaybackItem> items,
    int index, {
    Duration initialPosition = Duration.zero,
  }) async {
    if (items.isEmpty || index < 0 || index >= items.length) {
      final failure = const SurahPlaybackFailure(
        SurahPlaybackFailureType.invalidSelection,
        'اختيار السورة غير صالح.',
      );
      await _handleFailure(failure);
      throw failure;
    }
    try {
      final unifiedItems = items
          .map(
            (item) => _UnifiedPlaybackItem(
              id: item.id,
              uri: item.uri,
              mediaItem: buildSurahMediaItem(item, artworkUri: _artworkUri),
            ),
          )
          .toList(growable: false);
      await _loadUnifiedQueueAndPlay(
        unifiedItems,
        index,
        participantKey: NotificationKeys.quranPlayer,
        initialPosition: initialPosition,
      );
    } on SurahPlaybackFailure {
      rethrow;
    } catch (error) {
      final failure = SurahPlaybackFailure(
        SurahPlaybackFailureType.player,
        'تعذر إعداد قائمة التشغيل.',
        cause: error,
      );
      await _handleFailure(failure);
      throw failure;
    }
  }

  @override
  Future<void> loadIbtihalQueueAndPlay(
    List<IbtihalPlaybackItem> items,
    int index, {
    Duration initialPosition = Duration.zero,
  }) async {
    if (items.isEmpty || index < 0 || index >= items.length) {
      final failure = const SurahPlaybackFailure(
        SurahPlaybackFailureType.invalidSelection,
        'اختيار الابتهال غير صالح.',
      );
      await _handleFailure(failure);
      throw failure;
    }
    try {
      final unifiedItems = items
          .map(
            (item) => _UnifiedPlaybackItem(
              id: item.id,
              uri: item.uri,
              mediaItem: buildIbtihalMediaItem(
                item,
                artworkUri: _ibtihalArtworkUri,
              ),
            ),
          )
          .toList(growable: false);
      await _loadUnifiedQueueAndPlay(
        unifiedItems,
        index,
        participantKey: NotificationKeys.ibtihalatPlayer,
        initialPosition: initialPosition,
      );
    } on SurahPlaybackFailure {
      rethrow;
    } catch (error) {
      final failure = SurahPlaybackFailure(
        SurahPlaybackFailureType.player,
        'تعذر إعداد قائمة تشغيل الابتهالات.',
        cause: error,
      );
      await _handleFailure(failure);
      throw failure;
    }
  }

  Future<void> _loadUnifiedQueueAndPlay(
    List<_UnifiedPlaybackItem> items,
    int index, {
    required String participantKey,
    required Duration initialPosition,
  }) async {
    _playbackQueue = List.unmodifiable(items);
    _queueIndex = index;
    _activeParticipantKey = participantKey;
    queue.add(items.map((item) => item.mediaItem).toList(growable: false));
    await _loadAndPlay(items[index], initialPosition: initialPosition);
  }

  Future<void> _loadAndPlay(
    _UnifiedPlaybackItem item, {
    Duration initialPosition = Duration.zero,
  }) async {
    final generation = ++_loadGeneration;
    try {
      await PlaybackCoordinator.instance.activate(_activeParticipantKey);
    } catch (error) {
      final failure = SurahPlaybackFailure(
        SurahPlaybackFailureType.coordinatorActivation,
        'تعذر إيقاف المشغل الآخر وبدء التلاوة.',
        cause: error,
      );
      await _handleFailure(failure);
      throw failure;
    }
    _currentItem = item;
    mediaItem.add(item.mediaItem);
    _snapshot = SurahPlaybackSnapshot(
      itemId: item.id,
      processingState: SurahProcessingState.loading,
      position: initialPosition,
    );
    _snapshotController.add(_snapshot);
    _publishPlaybackState();

    try {
      await _player.setAudioSource(
        just_audio.AudioSource.uri(item.uri),
        initialPosition: initialPosition,
      );
      if (generation != _loadGeneration) return;
      _startPlayback();
    } catch (error) {
      if (generation != _loadGeneration) return;
      final failure = normalizeSurahPlaybackFailure(
        error,
        uri: item.uri,
        duringLoad: true,
      );
      await _handleFailure(failure);
      throw failure;
    }
  }

  @override
  Future<void> play() async {
    if (_currentItem == null) return;
    try {
      await PlaybackCoordinator.instance.activate(_activeParticipantKey);
    } catch (error) {
      await _handleFailure(
        SurahPlaybackFailure(
          SurahPlaybackFailureType.coordinatorActivation,
          'تعذر إيقاف المشغل الآخر واستئناف التلاوة.',
          cause: error,
        ),
      );
      return;
    }
    _startPlayback();
  }

  @override
  Future<void> pause() => _player.pause();

  @override
  Future<void> stop() async {
    _loadGeneration++;
    try {
      await _player.stop();
    } finally {
      PlaybackCoordinator.instance.markInactive(_activeParticipantKey);
      await super.stop();
    }
  }

  @override
  Future<void> onNotificationDeleted() => stop();

  @override
  Future<void> seek(Duration position) async {
    await _player.seek(position);
    _snapshot = _snapshot.copyWith(position: position);
    _snapshotController.add(_snapshot);
    _publishPlaybackState();
  }

  @override
  Future<void> setSpeed(double speed) => _player.setSpeed(speed);

  void _startPlayback() {
    unawaited(
      _player.play().catchError((Object error, StackTrace stackTrace) {
        return _handleFailure(
          normalizeSurahPlaybackFailure(error, uri: _currentItem?.uri),
        );
      }),
    );
  }

  Future<void> _handleFailure(SurahPlaybackFailure failure) async {
    try {
      await _player.stop();
    } catch (_) {
      // Preserve the original, actionable playback failure.
    } finally {
      PlaybackCoordinator.instance.markInactive(_activeParticipantKey);
    }
    _snapshot = _snapshot.copyWith(
      playing: false,
      processingState: SurahProcessingState.error,
      error: failure,
    );
    _snapshotController.add(_snapshot);
    _publishPlaybackState(errorMessage: failure.message);
  }

  void _publishPlayerState(just_audio.PlayerState state) {
    final processingState = switch (state.processingState) {
      just_audio.ProcessingState.idle => SurahProcessingState.idle,
      just_audio.ProcessingState.loading => SurahProcessingState.loading,
      just_audio.ProcessingState.buffering => SurahProcessingState.buffering,
      just_audio.ProcessingState.ready => SurahProcessingState.ready,
      just_audio.ProcessingState.completed => SurahProcessingState.completed,
    };
    final duration = _player.duration;
    _snapshot = SurahPlaybackSnapshot(
      itemId: _currentItem?.id,
      playing: state.playing,
      position: clampSurahPlaybackPosition(_player.position, duration),
      duration: duration,
      processingState: processingState,
    );
    _snapshotController.add(_snapshot);
    _publishPlaybackState();
  }

  void _publishPosition(Duration position) {
    _snapshot = _snapshot.copyWith(
      position: clampSurahPlaybackPosition(position, _snapshot.duration),
    );
    _snapshotController.add(_snapshot);
  }

  void _publishDuration(Duration? duration) {
    if (duration == null) return;
    _snapshot = _snapshot.copyWith(
      position: clampSurahPlaybackPosition(_snapshot.position, duration),
      duration: duration,
    );
    _snapshotController.add(_snapshot);
    _publishPlaybackState();
  }

  void _publishPlaybackState({String? errorMessage}) {
    playbackState.add(
      buildSurahPlaybackState(
        snapshot: _snapshot,
        bufferedPosition: _player.bufferedPosition,
        speed: _player.speed,
        queueIndex: _queueIndex,
        errorMessage: errorMessage,
      ),
    );
  }

  @override
  Future<void> skipToNext() async {
    if (_queueIndex >= _playbackQueue.length - 1) return;
    _queueIndex++;
    await _loadAndPlay(_playbackQueue[_queueIndex]);
  }

  @override
  Future<void> skipToPrevious() async {
    if (_queueIndex <= 0 || _playbackQueue.isEmpty) return;
    _queueIndex--;
    await _loadAndPlay(_playbackQueue[_queueIndex]);
  }

  Future<void> disposeHandler() async {
    PlaybackCoordinator.instance.unregister(NotificationKeys.quranPlayer);
    PlaybackCoordinator.instance.unregister(NotificationKeys.ibtihalatPlayer);
    for (final subscription in _subscriptions) {
      await subscription.cancel();
    }
    await _player.dispose();
    await _snapshotController.close();
  }
}

class _UnifiedPlaybackItem {
  const _UnifiedPlaybackItem({
    required this.id,
    required this.uri,
    required this.mediaItem,
  });

  final String id;
  final Uri uri;
  final MediaItem mediaItem;
}

Duration clampSurahPlaybackPosition(Duration position, Duration? duration) {
  if (position < Duration.zero) return Duration.zero;
  if (duration != null && position > duration) return duration;
  return position;
}

PlaybackState buildSurahPlaybackState({
  required SurahPlaybackSnapshot snapshot,
  required Duration bufferedPosition,
  required double speed,
  required int queueIndex,
  String? errorMessage,
}) => PlaybackState(
  controls: [
    MediaControl.skipToPrevious,
    snapshot.playing ? MediaControl.pause : MediaControl.play,
    MediaControl.stop,
    MediaControl.skipToNext,
  ],
  systemActions: const {MediaAction.seek},
  androidCompactActionIndices: const [0, 1, 3],
  processingState: switch (snapshot.processingState) {
    SurahProcessingState.idle => AudioProcessingState.idle,
    SurahProcessingState.loading => AudioProcessingState.loading,
    SurahProcessingState.buffering => AudioProcessingState.buffering,
    SurahProcessingState.ready => AudioProcessingState.ready,
    SurahProcessingState.completed => AudioProcessingState.completed,
    SurahProcessingState.error => AudioProcessingState.error,
  },
  playing: snapshot.playing,
  updatePosition: snapshot.position,
  bufferedPosition: bufferedPosition,
  speed: speed,
  queueIndex: queueIndex,
  errorMessage: errorMessage,
);

class AudioServices {
  AudioServices._();

  static late final UnifiedAudioHandler handler;
  static bool _initialized = false;

  static Future<void> initialize() async {
    if (_initialized) return;
    final session = await AudioSession.instance;
    await session.configure(AudioSessionConfiguration.speech());

    final artworkUri = await prepareSurahNotificationArtwork();
    final ibtihalArtworkUri = await prepareIbtihalNotificationArtwork();
    final createdHandler = UnifiedAudioHandler(
      artworkUri: artworkUri,
      ibtihalArtworkUri: ibtihalArtworkUri,
    );
    handler = createdHandler;
    await AudioService.init(
      builder: () => createdHandler,
      config: const AudioServiceConfig(
        androidNotificationChannelId: 'com.islam.lnastaqim.audio.playback',
        androidNotificationChannelName: 'Audio playback',
        androidNotificationOngoing: false,
        androidStopForegroundOnPause: true,
      ),
    );
    _initialized = true;
  }
}

MediaItem buildSurahMediaItem(
  SurahPlaybackItem item, {
  required Uri? artworkUri,
}) => MediaItem(
  id: item.id,
  title: item.title,
  artist: item.reciter,
  artUri: artworkUri,
  extras: {
    'mode': 'surah',
    'surahNumber': item.surahNumber,
    'uri': item.uri.toString(),
  },
);

MediaItem buildIbtihalMediaItem(
  IbtihalPlaybackItem item, {
  required Uri? artworkUri,
}) => MediaItem(
  id: item.id,
  title: item.title,
  artist: item.reciter,
  artUri: artworkUri,
  extras: {'mode': 'ibtihal', 'index': item.index, 'uri': item.uri.toString()},
);

Future<Uri?> prepareSurahNotificationArtwork({
  Future<ByteData> Function(String assetKey)? assetLoader,
  Future<Directory> Function()? directoryProvider,
}) async {
  try {
    final data = await (assetLoader ?? rootBundle.load)(
      AppImages.homeBackground,
    );
    final directory =
        await (directoryProvider ?? getApplicationSupportDirectory)();
    final file = File('${directory.path}/surah_notification_artwork.png');
    final bytes = Uint8List.sublistView(data);
    if (!await file.exists() || await file.length() != bytes.length) {
      await file.writeAsBytes(bytes, flush: true);
    }
    return file.uri;
  } catch (_) {
    // Artwork is optional; playback and service startup must still succeed.
    return null;
  }
}

Future<Uri?> prepareIbtihalNotificationArtwork({
  Future<ByteData> Function(String assetKey)? assetLoader,
  Future<Directory> Function()? directoryProvider,
}) async {
  try {
    final data = await (assetLoader ?? rootBundle.load)(AppImages.ibtihalImage);
    final directory =
        await (directoryProvider ?? getApplicationSupportDirectory)();
    final file = File('${directory.path}/ibtihal_notification_artwork.png');
    final bytes = Uint8List.sublistView(data);
    if (!await file.exists() || await file.length() != bytes.length) {
      await file.writeAsBytes(bytes, flush: true);
    }
    return file.uri;
  } catch (_) {
    return null;
  }
}
