import 'package:flutter_test/flutter_test.dart';
import 'package:lnastaqim/core/utilits/services/audio_service/playback_coordinator.dart';

void main() {
  final coordinator = PlaybackCoordinator.instance;

  setUp(coordinator.resetForTest);
  tearDown(coordinator.resetForTest);

  test('activating a participant pauses every other participant', () async {
    var surahPauses = 0;
    var versePauses = 0;
    coordinator.register('surah', () async => surahPauses++);
    coordinator.register('verse', () async => versePauses++);

    await coordinator.activate('surah');
    expect(versePauses, 1);
    expect(surahPauses, 0);
    expect(coordinator.activeParticipant, 'surah');

    await coordinator.activate('verse');
    expect(surahPauses, 1);
    expect(versePauses, 1);
    expect(coordinator.activeParticipant, 'verse');
  });

  test('concurrent activation requests are serialized', () async {
    final events = <String>[];
    coordinator.register('one', () async => events.add('pause-one'));
    coordinator.register('two', () async => events.add('pause-two'));

    await Future.wait([
      coordinator.activate('one'),
      coordinator.activate('two'),
    ]);

    expect(events, ['pause-two', 'pause-one']);
    expect(coordinator.activeParticipant, 'two');
  });
}
