enum SurahProcessingState { idle, loading, buffering, ready, completed, error }

enum SurahPlaybackFailureType {
  invalidSelection,
  queueFilesystem,
  coordinatorActivation,
  network,
  localFile,
  player,
}

class SurahPlaybackFailure implements Exception {
  const SurahPlaybackFailure(this.type, this.message, {this.cause});

  final SurahPlaybackFailureType type;
  final String message;
  final Object? cause;

  @override
  String toString() => 'SurahPlaybackFailure($type, $message, $cause)';
}

SurahPlaybackFailure normalizeSurahPlaybackFailure(
  Object error, {
  Uri? uri,
  bool duringLoad = false,
}) {
  if (error is SurahPlaybackFailure) return error;
  if (uri?.scheme == 'file') {
    return SurahPlaybackFailure(
      SurahPlaybackFailureType.localFile,
      'تعذر تشغيل الملف المحفوظ. قد يكون مفقودًا أو تالفًا.',
      cause: error,
    );
  }
  if (duringLoad && (uri?.scheme == 'http' || uri?.scheme == 'https')) {
    return SurahPlaybackFailure(
      SurahPlaybackFailureType.network,
      'تعذر تحميل السورة من الإنترنت. تحقق من الاتصال وحاول مجددًا.',
      cause: error,
    );
  }
  return SurahPlaybackFailure(
    SurahPlaybackFailureType.player,
    'حدث خطأ في مشغل الصوت. حاول تشغيل السورة مرة أخرى.',
    cause: error,
  );
}

class SurahPlaybackItem {
  const SurahPlaybackItem({
    required this.id,
    required this.uri,
    required this.title,
    required this.reciter,
    required this.surahNumber,
  });

  final String id;
  final Uri uri;
  final String title;
  final String reciter;
  final int surahNumber;
}

class SurahPlaybackSnapshot {
  const SurahPlaybackSnapshot({
    this.itemId,
    this.playing = false,
    this.position = Duration.zero,
    this.duration,
    this.processingState = SurahProcessingState.idle,
    this.error,
  });

  final String? itemId;
  final bool playing;
  final Duration position;
  final Duration? duration;
  final SurahProcessingState processingState;
  final Object? error;

  SurahPlaybackSnapshot copyWith({
    String? itemId,
    bool? playing,
    Duration? position,
    Duration? duration,
    SurahProcessingState? processingState,
    Object? error,
    bool clearError = false,
  }) => SurahPlaybackSnapshot(
    itemId: itemId ?? this.itemId,
    playing: playing ?? this.playing,
    position: position ?? this.position,
    duration: duration ?? this.duration,
    processingState: processingState ?? this.processingState,
    error: clearError ? null : error ?? this.error,
  );
}

abstract interface class SurahPlaybackService {
  Stream<SurahPlaybackSnapshot> get snapshots;
  SurahPlaybackSnapshot get currentSnapshot;

  Future<void> loadQueueAndPlay(
    List<SurahPlaybackItem> items,
    int index, {
    Duration initialPosition = Duration.zero,
  });
  Future<void> play();
  Future<void> pause();
  Future<void> stop();
  Future<void> seek(Duration position);
  Future<void> setSpeed(double speed);
}
