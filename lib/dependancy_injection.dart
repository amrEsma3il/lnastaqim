import 'package:get_it/get_it.dart';

import 'features/quran/bussniess_logic/font_cubit/qurn_fonts_downlod_progress_persentage_cubit.dart';

final sl = GetIt.instance;

Future<void> setup() async {
  if (!sl.isRegistered<FontDownloadPercentage>()) {
    sl.registerLazySingleton(() => FontDownloadPercentage());
  }
}
