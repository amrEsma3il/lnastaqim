import 'package:flutter_test/flutter_test.dart';
import 'package:lnastaqim/core/utilits/services/audio_service/players_key.dart';
import 'package:lnastaqim/dependancy_injection.dart';
import 'package:lnastaqim/features/notification/bussiness_logic/notification_cubit.dart';
import 'package:lnastaqim/features/quran_sound_player/logic/surah_player_cubit/surah_player_cubit.dart';

void main() {
  test('alarm preview no longer shares the legacy Quran player key', () {
    expect(
      NotificationCubit.audioPlayerKey,
      NotificationKeys.notificationAndAlarm,
    );
    expect(
      NotificationCubit.audioPlayerKey,
      isNot(NotificationKeys.quranPlayer),
    );
  });

  test(
    'dependency setup does not register a second SurahPlayerCubit',
    () async {
      await sl.reset();
      await setup();

      expect(sl.isRegistered<SurahPlayerCubit>(), isFalse);
    },
  );
}
