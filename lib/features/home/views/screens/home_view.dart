import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';
import 'package:lnastaqim/core/constants/images.dart';
import 'package:lnastaqim/core/utilits/extensions/arabic_numbers.dart';
import 'package:lnastaqim/features/home/data/models/prayer_time_model.dart';

import '../../../../core/utilits/models/hijri_date_model.dart';
import '../../../../core/utilits/services/hijri_date_service.dart';
import '../../../paryer_times/bussniess_logic/date_cubit.dart';
import '../../../paryer_times/view/widgets/prayers_stepper.dart';
import '../../../quran/bussniess_logic/moshaf_book_mark_cubit/moshaf_bookmark_cubit.dart';
import '../../../quran/bussniess_logic/moshaf_book_mark_cubit/moshaf_bookmark_state.dart';
import '../widgets/carousel_slider_ayah.dart';
import '../widgets/features_grid_view.dart';
import '../widgets/prayer_time_item.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff2f4f9),
      body: Column(
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
                  child: const Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(
                          Icons.search,
                          color: Colors.white,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 9.0),
                          child: Icon(
                            Icons.notifications_none_outlined,
                            color: Colors.white,
                          ),
                        ),
                        Icon(
                          Icons.wb_sunny_outlined,
                          color: Colors.white,
                        )
                      ]),
                ),
                Positioned(
                    top: 128.h,
                    left: 19.w,
                    child: SizedBox(
                      width: Get.width - 35.w,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              const Text(
                                "القراءة الاخيرة",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 21,
                                    fontWeight: FontWeight.w400,
                                    wordSpacing: -2),
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              GestureDetector(
                                child: Row(
                                  children: [
                                    BlocBuilder<MoshafBookmarkCubit, MoshafBookmarkState>(
                                      builder: (context, moshafBookmarState) {
                                             bool isMarkExist=moshafBookmarState.isMark&&moshafBookmarState.pageNumber!=0;
                                          int   pageNumber=moshafBookmarState.pageNumber;
                                        return  Text(
                                         isMarkExist? '${'صفحة رقم '} ${pageNumber.toString().toArabic}': "لا توجد قراه بعد",
                                          style: const TextStyle(
                                              color: Colors.white60,
                                              fontSize: 21,
                                              fontWeight: FontWeight.w400,
                                              wordSpacing: 1.9),
                                        );
                                      },
                                    ),
                                    SizedBox(
                                      width: 3.w,
                                    ),
                                    const Icon(
                                      Icons.bookmark,
                                      color: Colors.white,
                                      size: 21,
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          BlocBuilder<DateCubit, Map<String, String>>(
                            builder: (context, dateState) {
                              return Column(
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
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 21,
                                        fontWeight: FontWeight.w400,
                                        wordSpacing: 1.9),
                                  ),
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                    ))
              ],
            ),
          ),
          const Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "مواعيد الصلاوات",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        PrayersStepper()
                      ],
                    ),
                  ),
                  CarouselSliderAyah(),
                  Padding(
                    padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "المميزات",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        FeaturesGridView(),
                        SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
