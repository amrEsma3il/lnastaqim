import 'package:get/get.dart';
import '../../../features/quran/view/screens/sora_details.dart';

import '../../../features/quran/view/screens/quran_sowar.dart';
import '../app_routes_info/app_routes_name.dart';

List<GetPage<dynamic>>? routes = [
  GetPage(
      page: () => const QuranSowar(),
      name: AppRouteName.quranSowar,
      transition: Transition.leftToRightWithFade,
      transitionDuration: const Duration(milliseconds: 500)),
  GetPage(
      page: () => const SoraDetails(),
      name: AppRouteName.soraDetails,
      transition: Transition.leftToRightWithFade,
      transitionDuration: const Duration(milliseconds: 500)),
];


