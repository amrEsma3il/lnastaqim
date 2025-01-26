import 'dart:developer';
import 'dart:ui';
import 'package:adhan/adhan.dart';
import 'package:alarm/alarm.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:lnastaqim/config/routing/app_routes_info/app_routes_name.dart';
import 'package:lnastaqim/core/constants/colors.dart';
import 'package:lnastaqim/features/bookmark/bussniess_logic/bookmark_cubit/bookmark_cubit.dart';
import 'package:lnastaqim/features/bookmark/data/models/bookmark_model.dart';
import 'package:lnastaqim/features/favourite/bussniess_logic/add_to_fav_cubit/add_to_fav_cubit.dart';
import 'package:lnastaqim/features/favourite/bussniess_logic/favourites_cubit/favourite_cubit.dart';
import 'package:lnastaqim/features/favourite/data/models/favourite_model.dart';
import 'package:lnastaqim/features/note/bussniess_logic/add_note_cubit/add_note_cubit.dart';
import 'package:lnastaqim/features/note/bussniess_logic/note_cubit/note_cubit.dart';
import 'package:lnastaqim/features/note/data/models/note_model.dart';
import 'package:lnastaqim/features/quran/bussniess_logic/quran/quran_cubit.dart';
import 'package:lnastaqim/features/tafaseer/bussniess_logic/tafseer_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'config/routing/app_routingconfig/app_router_configuration.dart';
import 'core/constants/constants.dart';
import 'core/constants/keys.dart';
import 'core/utilits/controller/deep_link_cubit.dart';
import 'core/utilits/controller/search_or_not/search_visibility.dart';
import 'core/utilits/services/audio_service/players_key.dart';
import 'core/utilits/services/local_notification_service.dart';
import 'core/utilits/services/location_service.dart';
import 'core/utilits/services/work_manager_service.dart';
import 'features/7adis/bussiness_logic/a7adith_cubit.dart';
import 'features/7adis/data/hadith_service/hadith_service.dart';
import 'features/azkar_with_sib7a/business_logic/azkar_category_cubit/azkar_category_cubit.dart';
import 'features/azkar_with_sib7a/business_logic/azkar_details_cubit/azkar_details_cubit.dart';
import 'features/azkar_with_sib7a/business_logic/shared_azkar_cubit/shared_azkar_cubit.dart';
import 'features/bookmark/bussniess_logic/add_bookmark_cubit/add_bookmark_cubit.dart';
import 'features/note/bussniess_logic/overlay_note_control/overlay_note_control_cubit.dart';
import 'features/notification/bussiness_logic/notification_cubit.dart';
import 'features/paryer_times/bussniess_logic/date_cubit.dart';
import 'features/paryer_times/bussniess_logic/prayers_times_cubit.dart';
import 'features/quran/bussniess_logic/fast_transition/fast_transition_cubit.dart';
import 'features/quran/bussniess_logic/font_cubit/qurn_fonts_downlod_progress_persentage_cubit.dart';
import 'features/quran/bussniess_logic/memorized_verse_cubit/memorized_verse_cubit.dart';
import 'features/quran/bussniess_logic/moshaf_book_mark_cubit/moshaf_bookmark_cubit.dart';
import 'features/quran/bussniess_logic/quran/index_cubit/index_cubit.dart';
import 'features/quran/bussniess_logic/quran_sowar/search_on_aya_from_whole_quran_cubit.dart';
import 'features/quran/bussniess_logic/quran_sowar/search_or_not_cubit.dart';
import 'features/quran/bussniess_logic/screen_tap_Visibility/screen_tap_visability.dart';
import 'features/quran/bussniess_logic/sowra_detail/sora_details_cubit.dart';
import 'features/quran_sound/data/models/reciter_entity.dart';
import 'features/quran_sound/logic/audio_cubit/audio_cubit.dart';
import 'features/quran_sound_player/data/repo/repo.dart';
import 'features/quran_sound_player/logic/surah_player_cubit/surah_player_cubit.dart';
import 'features/radio_stream_channels/bussniess_logic/radio_cubit.dart';
import 'firebase_options.dart';
import 'features/quran/bussniess_logic/font_cubit/font_loader_test.dart';

@pragma('vm:entry-point')
void notificationTapBackground(
    NotificationResponse notificationResponse) async {
  log("hi from onDidReceiveNotificationBackgroundResponse");
  log("before switch case${notificationResponse.actionId}");

  String action = notificationResponse.actionId!;

    switch (action) {
      case '${NotificationKeys.quranPlayer}play':
        log('play quran sound');

        IsolateNameServer.lookupPortByName(NotificationKeys.quranPlayer)
            ?.send('play');

        break;
      case '${NotificationKeys.quranPlayer}pause':
        log('pause quran sound');

        IsolateNameServer.lookupPortByName(NotificationKeys.quranPlayer)
            ?.send('pause');

        break;

      case '${NotificationKeys.quranPlayer}stop':
        log('stop quran sound');
        IsolateNameServer.lookupPortByName(NotificationKeys.quranPlayer)
            ?.send('stop');

        break;

      case '${NotificationKeys.quranPlayer}next':
        log('next quran sound');
        IsolateNameServer.lookupPortByName(NotificationKeys.quranPlayer)
            ?.send('next');

        break;
      case '${NotificationKeys.quranPlayer}previous':
        log('previous quran sound');
        IsolateNameServer.lookupPortByName(NotificationKeys.quranPlayer)
            ?.send('previous');

        break;



        //================================================================================


              case '${NotificationKeys.radio}play':
        log('play radio sound');

        IsolateNameServer.lookupPortByName(NotificationKeys.radio)
            ?.send('play');

        break;
      case '${NotificationKeys.radio}pause':
        log('pause radio sound');

        IsolateNameServer.lookupPortByName(NotificationKeys.radio)
            ?.send('pause');

        break;

      case '${NotificationKeys.radio}stop':
        log('stop radio sound');
        IsolateNameServer.lookupPortByName(NotificationKeys.radio)
            ?.send('stop');

        break;

      case '${NotificationKeys.radio}next':
        log('next radio sound');
        IsolateNameServer.lookupPortByName(NotificationKeys.radio)
            ?.send('next');

        break;
      case '${NotificationKeys.radio}previous':
        log('previous radio sound');
        IsolateNameServer.lookupPortByName(NotificationKeys.radio)
            ?.send('previous');

        break;
        
        
          case 'استئناف':
        log('play quran download sound');

        IsolateNameServer.lookupPortByName(NotificationKeys.quranDownload)
            ?.send('play');

        break;
      case 'ايقاف':
        log('pause quran download sound');

        IsolateNameServer.lookupPortByName(NotificationKeys.quranDownload)
            ?.send('pause');

        break;


    }


}

late SharedPreferences prefs;
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Coordinates? coordinates;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('ar', null);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  prefs = await SharedPreferences.getInstance();
  coordinates =await LocationService.determinePosition();
  await Hive.initFlutter();

  Hive.registerAdapter(BookmarkModelAdapter());
  await Hive.openBox<BookmarkModel>(kBookmarkBox);
  Hive.registerAdapter(NoteModelAdapter());
  await Hive.openBox<NoteModel>(kNoteBox);
  Hive.registerAdapter(FavouriteModelAdapter());
  await Hive.openBox<FavouriteModel>(kAzkarFavouriteBox);
  await Hive.openBox<FavouriteModel>(k7adisFavouriteBox);

  await Hive.openBox<bool>('notificationBox');
  await Hive.openBox('userPreferences');

  await Hive.openBox<ReciterEntity>(AppKeys.reciterBox);

  await Future.wait([
    WorkManagerService().init(),
        Alarm.init()
  ]);

  await requestStoragePermission();
  await LocalNotificationService.requestNotificationPermission();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: AppColor.blueColor.withOpacity(0.74)));

  await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  Future<void> handleMediaAction(String action) async {

    switch (action) {
      case '${NotificationKeys.quranPlayer}play':
        log('play sound');

        IsolateNameServer.lookupPortByName(NotificationKeys.quranPlayer)
            ?.send('play');

        break;
      case '${NotificationKeys.quranPlayer}pause':
        log('pause sound');

        IsolateNameServer.lookupPortByName(NotificationKeys.quranPlayer)
            ?.send('pause');

        break;

      case '${NotificationKeys.quranPlayer}stop':
        log('stop sound');
        IsolateNameServer.lookupPortByName(NotificationKeys.quranPlayer)
            ?.send('stop');

        break;

      case '${NotificationKeys.quranPlayer}next':
        log('next sound');
        IsolateNameServer.lookupPortByName(NotificationKeys.quranPlayer)
            ?.send('next');

        break;
      case '${NotificationKeys.quranPlayer}previous':
        log('previous sound');
        IsolateNameServer.lookupPortByName(NotificationKeys.quranPlayer)
            ?.send('previous');

        break;



        //================================================================================


              case '${NotificationKeys.radio}play':
        log('play sound');

        IsolateNameServer.lookupPortByName(NotificationKeys.radio)
            ?.send('play');

        break;
      case '${NotificationKeys.radio}pause':
        log('pause sound');

        IsolateNameServer.lookupPortByName(NotificationKeys.radio)
            ?.send('pause');

        break;

      case '${NotificationKeys.radio}stop':
        log('stop sound');
        IsolateNameServer.lookupPortByName(NotificationKeys.radio)
            ?.send('stop');

        break;

      case '${NotificationKeys.radio}next':
        log('next sound');
        IsolateNameServer.lookupPortByName(NotificationKeys.radio)
            ?.send('next');

        break;
      case '${NotificationKeys.radio}previous':
        log('previous sound');
        IsolateNameServer.lookupPortByName(NotificationKeys.radio)
            ?.send('previous');

        break;

    }


  }

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  InitializationSettings settings = const InitializationSettings(
    android: AndroidInitializationSettings('@mipmap/ic_launcher'),
    iOS: DarwinInitializationSettings(),
  );
  await flutterLocalNotificationsPlugin.initialize(settings,
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) async {
    log("hi from onDidReceiveNotificationResponse");

    log(notificationResponse.actionId.toString());
// if (notificationResponse.actionId == null) {
//   log("action id is null");
// } else {
    await handleMediaAction(notificationResponse.actionId!);

// }
  }, onDidReceiveBackgroundNotificationResponse: notificationTapBackground);

  ///




  runApp(const Lnastaqim());

  await FontDownloadPercentage().checkAnyChapterDownloaded()
      ? await FontDownloadPercentage().loadFontsIndividually()
      : null;
}

class Lnastaqim extends StatelessWidget {
  const Lnastaqim({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      designSize: const Size(411.5, 867.5),
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => DeepLinkCubit(),
            ),
            //SearchOnAyaCubit
            BlocProvider(
              create: (context) => SearchVisabilityCubit(),
            ),
            BlocProvider(
              create: (context) => SearchOnAyaCubit(),
            ),

            BlocProvider(
              create: (context) => IndexCubit(),
            ),

            BlocProvider(
              create: (context) => FastTransitionCubit(),
            ),
            BlocProvider(
              create: (context) => ScreenOverlayCubit(),
            ),

            BlocProvider(
              create: (context) => SearchOrNot(),
            ),
            BlocProvider(
              create: (context) => MoshafBookmarkCubit(),
            ), //
            BlocProvider(
              create: (context) => QuranSowarVersusCubit(),
            ),
            BlocProvider(
              lazy: false,
              create: (context) => QuranCubit()..loadQuran(),
            ),

            BlocProvider(create: (context) => HadithCubit()),
            BlocProvider(
              create: (context) =>
                  AudioControlCubit()..audioPlayerListener(context),
            ),

              BlocProvider(
              create: (context) =>
                  RadioCubit(),
            ),//RadioCubit()

            BlocProvider(create: (context) => AddBookmarkCubit()),
            BlocProvider(
                create: (context) => BookmarkCubit()..fetchBookmarks()),

            BlocProvider(create: (context) => AddToFavouriteCubit()),
            BlocProvider(
                create: (context) => FavouriteCubit()
                  ..fetchAzkarFavourite()
                  ..fetch7adisFavourite()),
            BlocProvider(create: (context) => AddNoteCubit()),
            BlocProvider(create: (context) => NoteCubit()..fetchNotes()),
            BlocProvider(
              create: (context) => TafseerCubit(),
            ),
            // Provide the NotificationCubit
            BlocProvider(
              create: (context) => NotificationCubit(),
            ),
            BlocProvider(
              create: (context) => OverlayNoteControlCubit(), //FontCubit
            ),
            BlocProvider(
              create: (context) => FontDownloadPercentage(), //FontCubit
            ),

//  BlocProvider(
//               create: (context) => FontCubit(),
//             ),
            BlocProvider(
              create: (context) => DateCubit(),
            ),

            BlocProvider(
                create: (BuildContext context) =>
                    AzkarCategoryCubit()..getAzkarCategory()),
            BlocProvider(
                create: (BuildContext context) => MemorizedVerseCubit()),
            BlocProvider(
              create: (BuildContext context) =>
                  SurahPlayerCubit(RecitersRepository()),
            ), //
            BlocProvider(
                create: (BuildContext context) =>
                    PrayersTimesCubit()),
            BlocProvider(
                create: (BuildContext context) =>
                    AzkarDetailsCubit()..getAzkarDetails()),
            BlocProvider(create: (BuildContext context) => SharedAzkarCubit()),
          ],
          child: BlocListener<DeepLinkCubit, Uri?>(
            listener: (context, deepLink) {
              if (deepLink != null) {
                if (deepLink.path == "/moshaf") {
                  int page = int.parse(deepLink.queryParameters["page"]!);
                  int ayaNum = int.parse(deepLink.queryParameters["verse"]!);

                  QuranCubit.get(context).pageController =
                      PageController(initialPage: 604 - page);
                  Get.toNamed(deepLink.path);

                  QuranCubit.get(context).searchAya(ayaNum);
                } else if (deepLink.path == AppRouteName.azkarDetails) {
                  int category =
                      int.parse(deepLink.queryParameters["category"]!);
                  int zekr = int.parse(deepLink.queryParameters["zekr"]!);

                  Get.toNamed(deepLink.path);
                } else {
                  Get.toNamed(deepLink.path);
                }
              }
            },
            child: GetMaterialApp(
              navigatorKey: navigatorKey,
              locale: const Locale('ar'),
              debugShowCheckedModeBanner: false,
              getPages: routes,
            ),
          ),
        );
      },
    );
  }
}
