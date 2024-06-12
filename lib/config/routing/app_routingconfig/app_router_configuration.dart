import 'package:flutter/animation.dart';
import 'package:get/get.dart';
import 'package:lnastaqim/features/bookmark/views/bookmarks_view.dart';
import 'package:lnastaqim/features/note/views/note_view.dart';

import '../../../features/quran/view/screens/moshaf_view.dart';
import '../../../features/quran/view/screens/quran_sowar.dart';
import '../../../features/quran/view/screens/sora_details.dart';
import '../app_routes_info/app_routes_name.dart';

List<GetPage<dynamic>>? routes = [
  GetPage(
      page: () => const QuranSowar(),
      name: AppRouteName.quranSowar,
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500)),
  GetPage(
      curve: Curves.easeInOut,
      page: () => SoraDetails(soraModel: Get.arguments),
      name: AppRouteName.soraDetails,
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500)),
  GetPage(
      curve: Curves.easeInOut,
      page: () => const MoshafView(),
      name: AppRouteName.moshaf,
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500)),
  GetPage(
      curve: Curves.easeInOut,
      page: () => const BookmarksView(),
      name: AppRouteName.bookmark,
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500)),
  GetPage(
      curve: Curves.easeInOut,
      page: () => const NoteView(),
      name: AppRouteName.note,
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500)),
];
