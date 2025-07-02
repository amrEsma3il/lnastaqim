import 'dart:developer' as dev;
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../config/routing/app_routes_info/app_routes_name.dart';
import '../../../../../core/utilits/extensions/arabic_numbers.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/constants/images.dart';
import '../../../../quran_sound/logic/audio_cubit/audio_cubit.dart';
import '../../../bussniess_logic/font_cubit/qurn_fonts_downlod_progress_persentage_cubit.dart';
import '../../../bussniess_logic/quran/index_cubit/index_cubit.dart';
import '../../../bussniess_logic/quran/quran_cubit.dart';
import '../../../data/models/quran_model.dart';

class QuranSoraComponent extends StatelessWidget {
  final SurahModel indexEntity;
  final bool isFromDialog;
  const QuranSoraComponent({
    super.key,
    required this.indexEntity,
    this.isFromDialog = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        dev.log(
          "Tapped on Surah: ${indexEntity.name} with start page: ${indexEntity.startPage}",
        );
       

        if (isFromDialog) {
          Get.back();
        } else {
          // If not from dialog, we assume it's a page component

          QuranCubit.get(context).pageController = PageController(
            initialPage: 604 - (indexEntity.startPage),
          );
        }
        if (isFromDialog) {
          if (context.mounted) {
            BlocProvider.of<IndexCubit>(
              context,
            ).moveToPageEvent(context, indexEntity.startPage);
          }
        } else {
          Get.toNamed(AppRouteName.moshaf);
        }
        AudioControlCubit.get(context).updatePage(indexEntity.startPage,context);
        await FontDownloadPercentage().downloadAndLoadSurroundingFonts(
          currentPage: indexEntity.startPage,
        );
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(40.w, 6.h, 20.w, 6.h),
        margin: EdgeInsets.only(bottom: 11.h),
        width: Get.width - 100.w,
        height: 75.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Image.asset(
                      AppImages.pattern,
                      width: 32.w,
                      height: 32.h,
                      color: AppColor.blueColor,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 3.0),
                      child: Text(
                        indexEntity.id.toString().toArabic,
                        style: const TextStyle(
                          color: AppColor.blueColor,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 22.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 2),
                    Text(
                      indexEntity.name,
                      style: TextStyle(
                        color: AppColor.blueColor,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    SizedBox(height: 4.h),
                    Text(
                      "رقمها ${QuranCubit.get(context).getSurahNumberFromPage(indexEntity.startPage - 1).toString().toArabic} -اياتها ${QuranCubit.get(context).getSurahVersesNumber(indexEntity.name).toString().toArabic} -${indexEntity.makkia == 1 ? "مكية" : "مدنية"}",
                      style: const TextStyle(
                        color: AppColor.blueColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 13.5,
                        wordSpacing: 0.2,
                      ),
                    ),
                    const SizedBox(width: 20),
                  ],
                ),
              ],
            ),

            Container(
              width: 33,
              height: 32,
              alignment: Alignment.center,
              margin: const EdgeInsets.only(right: 20),
              decoration: BoxDecoration(
                color: AppColor.blueColor.withOpacity(0.85),
                shape: BoxShape.circle,
              ),
              child: Text(
                indexEntity.startPage.toString().toArabic,
                style: TextStyle(fontSize: 15, color: AppColor.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
