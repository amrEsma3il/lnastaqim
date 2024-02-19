import 'package:get/get.dart';
import 'package:lnastaqim/features/azkar_with_sib7a/view/screens/azkar_category_view.dart';

import '../../../features/azkar_with_sib7a/view/screens/azkar_details_view.dart';
import '../../../features/quran/view/screens/quran_sowar.dart';
import '../../../features/quran/view/screens/sora_details.dart';
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
  GetPage(
      page: () => const AzkarView(),
      name: AppRouteName.azkarView,
      transition: Transition.leftToRightWithFade,
      transitionDuration: const Duration(milliseconds: 500)),
  GetPage(
      page: () => const AzkarDetailsView(),
      name: AppRouteName.azkarDetails,
      transition: Transition.leftToRightWithFade,
      transitionDuration: const Duration(milliseconds: 500)),
];
