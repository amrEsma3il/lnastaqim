import 'surah_playback_service.dart';

class IbtihalPlaybackItem {
  const IbtihalPlaybackItem({
    required this.id,
    required this.uri,
    required this.title,
    required this.reciter,
    required this.index,
  });

  final String id;
  final Uri uri;
  final String title;
  final String reciter;
  final int index;
}

abstract interface class IbtihalPlaybackService {
  Stream<SurahPlaybackSnapshot> get snapshots;
  SurahPlaybackSnapshot get currentSnapshot;

  Future<void> loadIbtihalQueueAndPlay(
    List<IbtihalPlaybackItem> items,
    int index, {
    Duration initialPosition = Duration.zero,
  });
  Future<void> play();
  Future<void> pause();
  Future<void> stop();
  Future<void> seek(Duration position);
  Future<void> setSpeed(double speed);
}
