
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';


import 'package:lnastaqim/core/constants/colors.dart';

import 'config/routing/app_routingconfig/app_router_configuration.dart';
// import 'core/utilits/functions/search_string_pattern/boyer_moore_algo.dart' as boyer;
import 'core/constants/keys.dart';
import 'core/utilits/controller/search_or_not/search_visibility.dart';
import 'core/utilits/services/local_notification_service.dart';
import 'core/utilits/services/work_manager_service.dart';
import 'features/note/bussniess_logic/overlay_note_control/overlay_note_control_cubit.dart';
import 'features/paryer_times/bussniess_logic/date_cubit.dart';
import 'features/paryer_times/bussniess_logic/prayers_times_cubit.dart';


import 'package:hive_flutter/adapters.dart';

import 'package:lnastaqim/features/bookmark/bussniess_logic/bookmark_cubit/bookmark_cubit.dart';
import 'package:lnastaqim/features/bookmark/data/models/bookmark_model.dart';
import 'package:lnastaqim/features/note/bussniess_logic/add_note_cubit/add_note_cubit.dart';
import 'package:lnastaqim/features/note/bussniess_logic/note_cubit/note_cubit.dart';
import 'package:lnastaqim/features/note/data/models/note_model.dart';
import 'package:lnastaqim/features/quran/bussniess_logic/quran/quran_cubit.dart';
import 'package:lnastaqim/features/tafaseer/bussniess_logic/tafseer_cubit.dart';

import 'config/routing/app_routingconfig/app_router_configuration.dart';
import 'core/constants/constants.dart';
import 'core/utilits/services/local_notification_service.dart';
import 'core/utilits/services/work_manager_service.dart';
import 'features/bookmark/bussniess_logic/add_bookmark_cubit/add_bookmark_cubit.dart';
import 'features/notification/bussiness_logic/notification_cubit.dart';
import 'features/quran/bussniess_logic/quran_sowar/quran_sowar_cubit.dart';

import 'core/constants/constants.dart';

// import 'core/utilits/functions/search_string_pattern/boyer_moore_algo.dart' as boyer;

import 'features/azkar_with_sib7a/business_logic/azkar_category_cubit/azkar_category_cubit.dart';
import 'features/azkar_with_sib7a/business_logic/azkar_details_cubit/azkar_details_cubit.dart';

import 'features/azkar_with_sib7a/business_logic/shared_azkar_cubit/shared_azkar_cubit.dart';

import 'features/bookmark/bussniess_logic/add_bookmark_cubit/add_bookmark_cubit.dart';

import 'features/quran/bussniess_logic/fast_transition/fast_transition_cubit.dart';


import 'features/quran/bussniess_logic/moshaf_book_mark_cubit/moshaf_bookmark_cubit.dart';

import 'features/quran/bussniess_logic/quran_sowar/search_on_aya_from_whole_quran_cubit.dart';

import 'features/quran/bussniess_logic/quran_sowar/search_or_not_cubit.dart';
import 'features/quran/bussniess_logic/sowra_detail/sora_details_cubit.dart';


import 'features/quran/bussniess_logic/quran/index_cubit/index_cubit.dart';

import 'features/quran_sound/data/models/reciter_entity.dart';
import 'features/quran_sound/logic/audio_cubit/audio_cubit.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapter(BookmarkModelAdapter());
  await Hive.openBox<BookmarkModel>(kBookmarkBox);
  Hive.registerAdapter(NoteModelAdapter());
  await Hive.openBox<NoteModel>(kNoteBox);


  await Hive.openBox<bool>('notificationBox');
  await Hive.openBox('userPreferences');

  await Future.wait(
    [
      LocalNotificationService.init(),
      WorkManagerService().init(),
    ],
  );

  await Hive.openBox<ReciterEntity>(AppKeys.reciterBox);
  await Future.wait([
    LocalNotificationService.init(),
    WorkManagerService().init(),
  ]);

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: AppColor.blueColor.withOpacity(0.74)));


  runApp(const Lnastaqim());
}

class Lnastaqim extends StatelessWidget {

  const Lnastaqim({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      designSize: const Size(393, 852),
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [

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

//
            BlocProvider(
              create: (context) =>
                  AudioControlCubit()..audioPlayerListener(context),
            ),
   

            BlocProvider(create: (context) => AddBookmarkCubit()),
            BlocProvider(
                create: (context) => BookmarkCubit()..fetchBookmarks()),
            BlocProvider(create: (context) => AddNoteCubit()),
            BlocProvider(create: (context) => NoteCubit()..fetchNotes()),



            BlocProvider(
              create: (context) => TafseerCubit(),
            ),
            // Provide the NotificationCubit
            BlocProvider(
              create: (context) => NotificationCubit(WorkManagerService()),
            ),

             BlocProvider(
              create: (context) => OverlayNoteControlCubit(),
            ),

            BlocProvider(
              create: (context) => DateCubit()..getDates(),
            ),

            BlocProvider(
                create: (BuildContext context) =>
                    AzkarCategoryCubit()..getAzkarCategory()),
            BlocProvider(
                create: (BuildContext context) =>
                    AzkarDetailsCubit()..getAzkarDetails()),
            BlocProvider(create: (BuildContext context) => SharedAzkarCubit()),

          ],
          child: GetMaterialApp(
            locale: const Locale('ar'),
            debugShowCheckedModeBanner: false,
            getPages: routes,
          ),
        );
      },
    );
  }
}
