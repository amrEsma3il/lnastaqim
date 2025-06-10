import 'package:flutter/animation.dart';
import 'package:get/get.dart';
import 'package:lnastaqim/features/Competitions/view/screens/competitions_view.dart';
import 'package:lnastaqim/features/about_us/views/about_us_view.dart';
import 'package:lnastaqim/features/azkar_with_sib7a/view/screens/azkar_view.dart';
import 'package:lnastaqim/features/bookmark/views/bookmarks_view.dart';
import 'package:lnastaqim/features/calender/view/screens/calender_view.dart';
import 'package:lnastaqim/features/community/view/screens/community_view.dart';
import 'package:lnastaqim/features/favourite/views/favourites_view.dart';
import 'package:lnastaqim/features/favourite/views/general_favourite_view.dart';
import 'package:lnastaqim/features/help/views/help_view.dart';
import 'package:lnastaqim/features/layout/presentation/pages/layout.dart';
import 'package:lnastaqim/features/library/view/screens/library_view.dart';
import 'package:lnastaqim/features/note/views/note_view.dart';
import 'package:lnastaqim/features/qibla/view/screen/quiblah_screen.dart';
import 'package:lnastaqim/features/settings/views/screens/settings_view.dart';
import 'package:lnastaqim/features/sibha/views/widgets/azkar_sibha_view.dart';
import 'package:lnastaqim/features/support/view/screens/support_view.dart';

import '../../../features/7adis/view/screen/main_a7adith.dart';
import '../../../features/azkar_with_sib7a/view/screens/azkar_details_view.dart';
import '../../../features/home/views/screens/home_view.dart';
import '../../../features/ibtihal/view/screens/ibtihalat_player_screen.dart';
import '../../../features/notification/view/screnns/notification_screen.dart';
import '../../../features/quran/view/screens/moshaf_view.dart';
import '../../../features/quran_sound_player/view/screens/surah_player_screen.dart';
import '../../../features/radio_stream_channels/view/pages/radio_screen.dart';
import '../../../features/sibha/views/screens/sibha_view.dart';
import '../../../features/splash/view/screens/splash_screen.dart';
import '../app_routes_info/app_routes_name.dart';

List<GetPage<dynamic>>? routes = [

    GetPage(
      page: () => const SplashScreen(),
      name: AppRouteName.splash,
      transition: Transition.noTransition,
     ),
  GetPage(
      page: () => const Layout(),
      name: AppRouteName.layout,
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500)),

  GetPage(
      page: () => const HomeView(),
      name: AppRouteName.home,
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500)),

  GetPage(
      page: () => const LibraryView(),
      name: AppRouteName.library,
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500)),
  GetPage(
      page: () => const CommunityView(),
      name: AppRouteName.community,
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500)),
  GetPage(
      page: () => const CompetitionsView(),
      name: AppRouteName.competition,
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500)),
  GetPage(
      page: () => const CalenderView(),
      name: AppRouteName.calender,
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500)),
  GetPage(
      page: () => const SupportView(),
      name: AppRouteName.support,
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
      transitionDuration: const Duration(milliseconds: 500)),//ibtihalPlayerScreen

      GetPage(
      curve: Curves.easeInOut,
      page: () => const IbtihalatPlayerScreen(),
      name: AppRouteName.ibtihalPlayerScreen,
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500)),
  GetPage(
      curve: Curves.easeInOut,
      page: () => const MoshafView(),
      name: AppRouteName.moshaf,
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500)), //moshafIndex
  // GetPage(
  // curve: Curves.easeInOut,
  // page: () => const MoshafIndex(),
  // name: AppRouteName.moshafIndex,
  // transition: Transition.fadeIn,
  // transitionDuration: const Duration(milliseconds: 500)),//
  GetPage(
      curve: Curves.easeInOut,
      page: () => const MainHadithScreen(),
      name: AppRouteName.a7adithView,
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
      page: () => const AzkarSibhaView(),
      name: AppRouteName.sibhaAzkar,
      transition: Transition.leftToRightWithFade,
      transitionDuration: const Duration(milliseconds: 500)),
  GetPage(
      curve: Curves.easeInOut,
      page: () => const QuiblahScreen(),
      name: AppRouteName.qibla,
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 500)),
  GetPage(
      page: () => const NotificationScreen(),
      name: AppRouteName.notification,
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 500)),
  GetPage(
      curve: Curves.easeInOut,
      page: () => const FavouritesView(
            isZekr: true,
          ),
      name: AppRouteName.favAzkar,
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 500)),

  GetPage(
      curve: Curves.easeInOut,
      page: () => const FavouritesView(
            isZekr: false,
          ),
      name: AppRouteName.fav7adis,
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 500)),

  GetPage(
      curve: Curves.easeInOut,
      page: () => const GeneralFavouriteView(),
      name: AppRouteName.generalFav,
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 500)),
  GetPage(
      curve: Curves.easeInOut,
      page: () => const HelpView(),
      name: AppRouteName.help,
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 500)),
  GetPage(
      curve: Curves.easeInOut,
      page: () => const SettingsView(),
      name: AppRouteName.setting,
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 500)),
  GetPage(
      curve: Curves.easeInOut,
      page: () => const AboutUsView(),
      name: AppRouteName.aboutUs,
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 500)),
];
