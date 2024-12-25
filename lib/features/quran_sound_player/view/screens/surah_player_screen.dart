import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../core/constants/colors.dart';
import '../../../../main.dart';
import '../../data/repo/repo.dart';
import '../../logic/surah_player_cubit/surah_player_cubit.dart';
import '../../logic/surah_player_cubit/surah_player_state.dart';
import '../widgets/reciters_bottom_sheet_component.dart';
import '../widgets/surah_controls_widget.dart';
import '../widgets/surah_info_widget.dart';
import '../widgets/surah_slider_widget.dart';
import '../widgets/surahs_bottom_sheet_component.dart';

class SurahPlayerScreen extends StatelessWidget {
  const SurahPlayerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            height: Get.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter, // يبدأ من الأعلى
                end: Alignment.bottomCenter, // ينتهي في الأسفل
                colors: [
                  AppColor.lightBlue2, // أزرق فاتح جدًا (أعلى)
                  AppColor.blueColor, // أزرق متوسط
                  AppColor.blueBlack2, // أزرق أغمق (أسفل)
                ],
                stops: const [0.0, 0.5, 1.0], // توزيع الألوان
              ),

              // color: Color.fromARGB(255, 64, 110, 82)
            ),
            padding: const EdgeInsets.fromLTRB(2, 9, 6, 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: Get.width,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 4.0),
                      child: IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: Icon(
                          Icons.arrow_back,
                          color: AppColor.white,
                          size: 28,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 8.w),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          //////////
                          GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                //  isScrollControlled: true,
                                enableDrag: false,
                                context: context,
                                backgroundColor: AppColor.blueColor,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(25.0)),
                                ),
                                builder: (bottomSheetContext) {
                                  return RecitersBottomSheetComponent(
                                      cubit: SurahPlayerCubit.get(context));
                                },
                              );
                            },
                            child:
                                BlocBuilder<SurahPlayerCubit, SurahPlayerState>(
                              builder: (context, state) {
                                return Text(
                                  state.reciter.nameArabic,
                                  style: TextStyle(
                                      wordSpacing: 0.1,
                                      fontSize: 16.sp,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400),
                                );
                              },
                            ),
                          ),
                          //  SizedBox(height: 2.h),

                          GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                //  isScrollControlled: true,
                                enableDrag: false,
                                context: context,
                                backgroundColor: AppColor.blueColor,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(25.0)),
                                ),
                                builder: (bottomSheetContext) {
                                  return SurahsBottomSheetComponent(
                                      cubit: SurahPlayerCubit.get(context));
                                },
                              );
                            },
                            child: Padding(
                              padding: EdgeInsets.only(right: 4.w),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  BlocBuilder<SurahPlayerCubit,
                                      SurahPlayerState>(
                                    builder: (context, state) {
                                      return Text(
                                        SurahPlayerCubit
                                            .quranSurahs[state.surahNumber]
                                            .toString(),
                                        style: TextStyle(
                                            fontSize: 14.sp,
                                            color: Colors.white70,
                                            fontWeight: FontWeight.w600),
                                      );
                                    },
                                  ),
                                  SizedBox(
                                    width: 4.w,
                                  ),
                                  const Icon(Icons.keyboard_arrow_down_sharp,
                                      size: 21, color: Colors.white70)
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.favorite,
                        color: AppColor.white,
                        size: 26,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 47.h),
                const SurahInfoWidget(),
                SizedBox(height: 80.h),
                const SurahSliderWidget(),
                SizedBox(height: 11.h),
                const SurahControlsWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
