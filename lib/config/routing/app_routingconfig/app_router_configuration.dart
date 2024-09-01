import 'package:flutter/animation.dart';
import 'package:get/get.dart';
import 'package:lnastaqim/features/azkar_with_sib7a/view/screens/azkar_category_view.dart';
import 'package:lnastaqim/features/bookmark/views/bookmarks_view.dart';
import 'package:lnastaqim/features/note/views/note_view.dart';
import 'package:lnastaqim/features/qibla/view/screen/quiblah_screen.dart';

import '../../../features/azkar_with_sib7a/view/screens/azkar_details_view.dart';
import '../../../features/home/views/screens/home_view.dart';
import '../../../features/notification/view/notification_screen.dart';
import '../../../features/paryer_times/view/screens/test_screen.dart';



import '../../../features/quran/view/screens/moshaf_index.dart';
import '../../../features/quran/view/screens/moshaf_view.dart';
import '../../../features/quran_sound_player/view/screens/surah_player_screen.dart';

import '../../../features/radio_stream_channels/view/pages/radio_screen.dart';
import '../../../features/sibha/views/screens/sibha_view.dart';
import '../app_routes_info/app_routes_name.dart';

List<GetPage<dynamic>>? routes = [
  GetPage(
      page: () => const HomeView(),
      name: AppRouteName.home,
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500)),
  // GetPage(
  //     page: () => const QuranSowar(),
  //     name: AppRouteName.quranSowar,
  //     transition: Transition.fadeIn, 
  //     transitionDuration: const Duration(milliseconds: 500)),
        GetPage(
      page: () => const RadioScreen(),
      name: AppRouteName.radio,
      transition: Transition.fadeIn, 
      transitionDuration: const Duration(milliseconds: 500)),
  // GetPage(
  //     curve: Curves.easeInOut,
  //     page: () => SoraDetails(soraModel: Get.arguments),
  //     name: AppRouteName.soraDetails,
  //     transition: Transition.fadeIn,
  //     transitionDuration: const Duration(milliseconds: 500)),
  GetPage(
      curve: Curves.easeInOut,
      page: () => const SurahPlayerScreen(),
      name: AppRouteName.surahPlayerScreen,
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500)),
  GetPage(
      curve: Curves.easeInOut,
      page: () => const MoshafView(),
      name: AppRouteName.moshaf,
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500)),//moshafIndex
      // GetPage(
      // curve: Curves.easeInOut,
      // page: () => const MoshafIndex(),
      // name: AppRouteName.moshafIndex,
      // transition: Transition.fadeIn,
      // transitionDuration: const Duration(milliseconds: 500)),//
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
  GetPage(
      curve: Curves.easeInOut,
      page: () => const AzkarView(),
      name: AppRouteName.azkarView,
      transition: Transition.leftToRightWithFade,
      transitionDuration: const Duration(milliseconds: 500)),
  GetPage(
      page: () => const AzkarDetailsView(),
      name: AppRouteName.azkarDetails,
      transition: Transition.leftToRightWithFade,
      transitionDuration: const Duration(milliseconds: 500)),
  GetPage(
      page: () => const SibhaView(),
      name: AppRouteName.sibhaView,
      transition: Transition.leftToRightWithFade,
      transitionDuration: const Duration(milliseconds: 500)),
  GetPage(
      curve: Curves.easeInOut,
      page: () => const QuiblahScreen(),
      name: AppRouteName.qibla,
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 500)),
  GetPage(
      curve: Curves.easeInOut,
      page: () => const NotificationScreen(),
      name: AppRouteName.notification,
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 500)),
];
