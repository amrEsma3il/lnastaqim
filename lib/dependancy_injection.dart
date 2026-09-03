import 'package:get_it/get_it.dart';

import 'features/quran/bussniess_logic/font_cubit/qurn_fonts_downlod_progress_persentage_cubit.dart';
import 'features/quran_sound_player/data/repo/surah_player_repo.dart';
import 'features/quran_sound_player/logic/surah_player_cubit/surah_player_cubit.dart';

final sl = GetIt.instance;

Future<void> setup() async {
  // Repositories
  if (!sl.isRegistered<SurahPlayerRepo>()) {
    sl.registerLazySingleton<SurahPlayerRepo>(() => SurahPlayerRepo());
  }

  // Cubits / Logic
  if (!sl.isRegistered<SurahPlayerCubit>()) {
    sl.registerLazySingleton(() => SurahPlayerCubit(sl<SurahPlayerRepo>()));
  }
  if (!sl.isRegistered<FontDownloadPercentage>()) {
    sl.registerLazySingleton(() => FontDownloadPercentage());
  }
}