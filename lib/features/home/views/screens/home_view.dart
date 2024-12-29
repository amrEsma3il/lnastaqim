import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';
import 'package:lnastaqim/core/constants/images.dart';
import 'package:lnastaqim/core/utilits/extensions/arabic_numbers.dart';
import 'package:lnastaqim/features/home/views/widgets/custom_drawer.dart';

import '../../../../config/routing/app_routes_info/app_routes_name.dart';
import '../../../paryer_times/bussniess_logic/date_cubit.dart';
import '../../../paryer_times/view/widgets/prayers_stepper.dart';
import '../../../quran/bussniess_logic/font_cubit/font_cubit.dart';
import '../../../quran/bussniess_logic/font_cubit/font_loader_test.dart';
import '../../../quran/bussniess_logic/moshaf_book_mark_cubit/moshaf_bookmark_cubit.dart';
import '../../../quran/bussniess_logic/moshaf_book_mark_cubit/moshaf_bookmark_state.dart';
import '../../../quran/bussniess_logic/quran/quran_cubit.dart';
import '../widgets/carousel_slider_ayah.dart';
import '../widgets/features_grid_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    // _initializeFonts();
  }

//Temporarily method to can call asynchronous method in init state (also stateful screen will change in future to stateless)
// Future<void> _initializeFonts() async {
// try {
//     await FontService.getfontServiceInstance().downloadProcess();
//   await FontService.getfontServiceInstance().loadFont('604');
//   await FontService.getfontServiceInstance().loadFont('603');
//     await FontService.getfontServiceInstance().loadFont('602');

//   await FontService.getfontServiceInstance().loadFont('601');

// } catch (e) {
//   log(e.toString());
// }
// }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      endDrawer: CustomDrawer(
        scaffoldKey: scaffoldKey,
      ),
      backgroundColor: const Color(0xfff2f4f9),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              child: Stack(
                children: [
                  Image(
                    width: Get.width,
                    fit: BoxFit.cover,
                    image: const AssetImage(AppImages.homeBackground),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 53.h, left: 17.w),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 9.0),
                            child: GestureDetector(
                              onTap: () async {
                                // Get.toNamed(AppRouteName.notification);
                              
                                //FontCubit

bool isFontExixit=await FontService.getfontServiceInstance().checkfileExisit();

log("font exist? = ${isFontExixit}");



                                // await FontService.getfontServiceInstance().downloadFont();
                                // await FontService.getfontServiceInstance()
                                //     .loadFont("009");


                                    log("=======================================================================================================================================================================");
                                    //   FontCubit.getFontCubit(context)
                                    // .listFilesInDirectory();

                              },
                              child: const Icon(
                                Icons.notifications,
                                color: Colors.white,
                              ),
                            ),
                          ),

                          const Expanded(child: SizedBox.shrink()),
                          // const Icon(
                          //   Icons.wb_sunny_outlined,
                          //   color: Colors.white,
                          // ),
                          GestureDetector(
                            onTap: () {
                              scaffoldKey.currentState!.openEndDrawer();
                            },
                            child: const Icon(
                              Icons.menu,
                              color: Colors.white,
                            ),
                          ),
                        ]),
                  ),
                  Positioned(
                      top: 116.h,
                      left: 19.w,
                      child: SizedBox(
                        width: Get.width - 35.w,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: 63.w),
                                    child: const Text(
                                      textAlign: TextAlign.center,
                                      "القراءة الاخيرة",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 21,
                                          fontWeight: FontWeight.w400,
                                          wordSpacing: -2),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 2.h,
                                  ),
                                  GestureDetector(
                                    child: Row(
                                      children: [
                                        BlocBuilder<MoshafBookmarkCubit,
                                            MoshafBookmarkState>(
                                          builder:
                                              (context, moshafBookmarState) {
                                            bool isMarkExist =
                                                moshafBookmarState.isMark &&
                                                    moshafBookmarState
                                                            .pageNumber !=
                                                        0;
                                            int pageNumber =
                                                moshafBookmarState.pageNumber;
                                            return GestureDetector(
                                              onTap: () async {
                                                if (isMarkExist) {
                                                  //  QuranCubit.get(context).clearScreen(context);
                                                  QuranCubit.get(context)
                                                          .pageController =
                                                      PageController(
                                                          initialPage:
                                                              604 - pageNumber);
                                                  Get.toNamed(
                                                      AppRouteName.moshaf);
                                                  log(pageNumber.toString());
                                                }
                                              },
                                              child: Text(
                                                isMarkExist
                                                    ? '${'صفحة رقم'} ${pageNumber.toString().toArabic}'
                                                    : "لا توجد قراه بعد",
                                                style: const TextStyle(
                                                    color: Colors.white60,
                                                    fontSize: 21,
                                                    fontWeight: FontWeight.w400,
                                                    wordSpacing: 1.9),
                                              ),
                                            );
                                          },
                                        ),
                                        SizedBox(
                                          width: 3.w,
                                        ),
                                        const Icon(
                                          Icons.bookmark_outline,
                                          color: Colors.white,
                                          size: 21,
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            BlocBuilder<DateCubit, Map<String, String>>(
                              builder: (context, dateState) {
                                return Expanded(
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(right: 5.w),
                                        child: Text(
                                          dateState["gregorian"]!,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 21,
                                              fontWeight: FontWeight.w400,
                                              wordSpacing: -2),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 2.h,
                                      ),
                                      Text(
                                        dateState["hijri"]!,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 21,
                                            fontWeight: FontWeight.w400,
                                            wordSpacing: 1.9),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ))
                ],
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "مواعيد الصلاوات",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15.5.sp),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const PrayersStepper()
                    ],
                  ),
                ),
                const CarouselSliderAyah(),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "المميزات",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15.5.sp),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const FeaturesGridView(),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
