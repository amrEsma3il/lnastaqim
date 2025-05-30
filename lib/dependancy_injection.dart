import 'package:get_it/get_it.dart';

import 'features/quran/bussniess_logic/font_cubit/qurn_fonts_downlod_progress_persentage_cubit.dart';
import 'features/quran_sound_player/data/repo/surah_player_repo.dart';
import 'features/quran_sound_player/logic/surah_player_cubit/surah_player_cubit.dart';

final sl = GetIt.instance;

Future<void> setup()async {

sl.registerLazySingleton<SurahPlayerRepo>(() => SurahPlayerRepo());
  sl.registerLazySingleton(() => SurahPlayerCubit(sl<SurahPlayerRepo>()));


//cubit

// sl.registerSingleton(() =>SurahPlayerCubit(sl()));
sl.registerLazySingleton(() =>FontDownloadPercentage());













//repo

sl.registerLazySingleton<SurahPlayerRepo>(() => SurahPlayerRepo());




//datasources

// sl.registerLazySingleton(() => AuthRemoteDataSources(sl()));


// //other
// sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
// sl.registerLazySingleton(() => InternetConnectionChecker());
// final sharedPreferences = await SharedPreferences.getInstance();
// sl.registerLazySingleton(() => sharedPreferences);
// sl.registerLazySingleton(() =>Dio());




 
}