import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:audio_service/audio_service.dart';
import 'package:audio_session/audio_session.dart';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart' as just_audio;
import 'package:path_provider/path_provider.dart';

import '../../../constants/images.dart';
import 'playback_coordinator.dart';
import 'players_key.dart';
import 'surah_playback_service.dart';

class UnifiedAudioHandler extends BaseAudioHandler
    with SeekHandler
    implements SurahPlaybackService {
  UnifiedAudioHandler({just_audio.AudioPlayer? player, Uri? artworkUri})
    : _player = player ?? just_audio.AudioPlayer(),
      _artworkUri = artworkUri {
    PlaybackCoordinator.instance.register(NotificationKeys.quranPlayer, pause);
    _subscriptions.addAll([
      _player.playerStateStream.listen(_publishPlayerState),
      _player.positionStream.listen(_publishPosition),
      _player.durationStream.listen(_publishDuration),
      _player.playbackEventStream.listen(
        (_) {},
        onError: (Object error, StackTrace stackTrace) {
          unawaited(_handleFailure(normalizeSurahPlaybackFailure(error, uri: _currentItem?.uri)));
        },
      ),
    ]);
  }

  final just_audio.AudioPlayer _player;
  final Uri? _artworkUri;
  final List<StreamSubscription<dynamic>> _subscriptions = [];
  final StreamController<SurahPlaybackSnapshot> _snapshotController =
      StreamController<SurahPlaybackSnapshot>.broadcast();
  SurahPlaybackSnapshot _snapshot = const SurahPlaybackSnapshot();
  SurahPlaybackItem? _currentItem;
  List<SurahPlaybackItem> _surahQueue = const [];
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
      _surahQueue = List.unmodifiable(items);
      _queueIndex = index;
      queue.add(items.map(_toMediaItem).toList(growable: false));
      await _loadAndPlay(items[index], initialPosition: initialPosition);
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

  Future<void> _loadAndPlay(
    SurahPlaybackItem item, {
    Duration initialPosition = Duration.zero,
  }) async {
    final generation = ++_loadGeneration;
    try {
      await PlaybackCoordinator.instance.activate(NotificationKeys.quranPlayer);
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
    mediaItem.add(_toMediaItem(item));
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
      final failure = normalizeSurahPlaybackFailure(error, uri: item.uri, duringLoad: true);
      await _handleFailure(failure);
      throw failure;
    }
  }

  MediaItem _toMediaItem(SurahPlaybackItem item) =>
      buildSurahMediaItem(item, artworkUri: _artworkUri);

  @override
  Future<void> play() async {
    if (_currentItem == null) return;
    try {
      await PlaybackCoordinator.instance.activate(NotificationKeys.quranPlayer);
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
      PlaybackCoordinator.instance.markInactive(NotificationKeys.quranPlayer);
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
        return _handleFailure(normalizeSurahPlaybackFailure(error, uri: _currentItem?.uri));
      }),
    );
  }

  Future<void> _handleFailure(SurahPlaybackFailure failure) async {
    try {
      await _player.stop();
    } catch (_) {
      // Preserve the original, actionable playback failure.
    } finally {
      PlaybackCoordinator.instance.markInactive(NotificationKeys.quranPlayer);
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
    if (_queueIndex >= _surahQueue.length - 1) return;
    _queueIndex++;
    await _loadAndPlay(_surahQueue[_queueIndex]);
  }

  @override
  Future<void> skipToPrevious() async {
    if (_queueIndex <= 0 || _surahQueue.isEmpty) return;
    _queueIndex--;
    await _loadAndPlay(_surahQueue[_queueIndex]);
  }

  Future<void> disposeHandler() async {
    PlaybackCoordinator.instance.unregister(NotificationKeys.quranPlayer);
    for (final subscription in _subscriptions) {
      await subscription.cancel();
    }
    await _player.dispose();
    await _snapshotController.close();
  }
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
    final createdHandler = UnifiedAudioHandler(artworkUri: artworkUri);
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

MediaItem buildSurahMediaItem(SurahPlaybackItem item, {required Uri? artworkUri}) => MediaItem(
  id: item.id,
  title: item.title,
  artist: item.reciter,
  artUri: artworkUri,
  extras: {'mode': 'surah', 'surahNumber': item.surahNumber, 'uri': item.uri.toString()},
);

Future<Uri?> prepareSurahNotificationArtwork({
  Future<ByteData> Function(String assetKey)? assetLoader,
  Future<Directory> Function()? directoryProvider,
}) async {
  try {
    final data = await (assetLoader ?? rootBundle.load)(AppImages.homeBackground);
    final directory = await (directoryProvider ?? getApplicationSupportDirectory)();
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
