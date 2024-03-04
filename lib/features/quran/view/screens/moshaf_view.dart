import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lnastaqim/core/utilits/extensions/arabic_numbers.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/local_database/quran/quran_pages_local_database.dart';
import '../../../../core/utilits/widgets/surah_banner.dart';
import '../../bussniess_logic/sowra_detail/sora_details_cubit.dart';

class Moshaf extends StatelessWidget {
  const Moshaf({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: SizedBox(
      width: Get.width,
      height: Get.height,
      child: PageView.builder(
          reverse: true,
          scrollDirection: Axis.horizontal,
          itemCount: quranPages.length,
          itemBuilder: (context, index) {
            return SizedBox(
              height: Get.height,
              width: Get.width,
              child: Stack(
                children: [
                  SingleChildScrollView(
                      child: Column(
                    children: [
                      for (int i = 0;
                          i <=
                              (quranPages[603 - index]['content'] as List)
                                      .length -
                                  1;
                          i++) ...{
                        if ((quranPages[603 - index]['content'][i] as String)
                            .contains("سُورَةُ")) ...{
                          Column(
                            children: [
                              SizedBox(
                                height: 8.h,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.w),
                                child: SizedBox(
                                  height: 62.h,
                                  width: Get.width,
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Container(
                                        width: Get.width,
                                        height: 75.h,
                                        color: const Color.fromARGB(
                                            223, 201, 185, 223),
                                      ),
                                      Positioned(
                                          top: 0.h,
                                          child: Container(
                                            width: Get.width,
                                            height: 11.h,
                                            color: const Color.fromARGB(
                                                228, 148, 114, 196),
                                          )),
                                      Positioned(
                                          bottom: 0.h,
                                          child: Container(
                                            width: Get.width,
                                            height: 11.h,
                                            color: const Color.fromARGB(
                                                228, 148, 114, 196),
                                          )),
                                      Positioned(
                                        right: 0,
                                        child: CustomPaint(
                                          size: Size(130.w,
                                              135.h), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
                                          painter: RPSCustomPainter(),
                                        ),
                                      ),
                                      Positioned(
                                        left: 0,
                                        child: CustomPaint(
                                          size: Size(130.w,
                                              130.h), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
                                          painter: LPSCustomPainter(),
                                        ),
                                      ),
                                      Center(
                                        child: Text(
                                            quranPages[603 - index]['content']
                                                [i],
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                wordSpacing: -2,
                                                fontSize: 26.sp,
                                                fontWeight: FontWeight.w600,
                                                fontFamily: "Authmanic")),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )
                        } else if ((quranPages[603 - index]['content'][i]
                                as String)
                            .contains(" ﷽")) ...{
                          Column(
                            children: [
                              SizedBox(height: 5.h),
                              Center(
                                child: Text(" ﷽",
                                    style: TextStyle(
                                        fontSize: 22.sp,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: "Amiri")),
                              ),
                            ],
                          )
                        } else if (!((quranPages[603 - index]['content'][i]
                                        as String)
                                    .contains("سُورَةُ") ||
                                (quranPages[603 - index]['content'][i]
                                        as String)
                                    .contains(" ﷽")) &&
                            ((quranPages[603 - index]['content'][i - 1]
                                        as String)
                                    .contains("سُورَةُ") ||
                                (quranPages[603 - index]['content'][i - 1]
                                        as String)
                                    .contains(" ﷽"))) ...{
                          Column(
                            children: [
                              SizedBox(height: 5.h),
                              Center(
                                child: Container(
                                    width: Get.width - 12.w,
                                    padding:
                                        EdgeInsets.only(top: 2.h,bottom: 10.h),
                                    child:
                                        BlocBuilder<QuranSowarVersusCubit, int>(
                                      builder: (context, state) {
                                        return RichText(
                                            selectionColor: AppColor.softGray,
                                            textAlign: TextAlign.center,
                                            textDirection: TextDirection.rtl,
                                            text: TextSpan(
                                                style: TextStyle(
                                                    wordSpacing: -4.5.w,
                                                    height: 1.3.h,
                                                    color: AppColor.black,
                                                    fontSize: 24.sp,
                                                    fontWeight: FontWeight.w600,
                                                    fontFamily: "Authmanic"),
                                                children: [
                                                  for (int aya = i;
                                                      (aya <=
                                                              (quranPages[603 - index]
                                                                              ['content']
                                                                          as List)
                                                                      .length -
                                                                  1) &&
                                                          (!(quranPages[603 - index]
                                                                          ['content'][aya]
                                                                      as String)
                                                                  .contains(
                                                                      "سُورَةُ") );
                                                      aya++) ...{
                                                    TextSpan(
                                                        style: TextStyle(
                                                          
                                                            backgroundColor: state ==
                                                                    603 - index
                                                                ? const Color
                                                                    .fromARGB(
                                                                    255,
                                                                    148,
                                                                    139,
                                                                    204)
                                                                : Colors
                                                                    .transparent),
                                                        recognizer:
                                                            TapGestureRecognizer()
                                                              ..onTap = () {
                                                                BlocProvider.of<
                                                                            QuranSowarVersusCubit>(
                                                                        context)
                                                                    .selectedVerse(
                                                                        603 -
                                                                            index);

                                                                Future.delayed(
                                                                    const Duration(
                                                                        seconds:
                                                                            10));
                                                                // showModalBottomSheet(
                                                                //   context:
                                                                //       context,
                                                                //   shape: RoundedRectangleBorder(
                                                                //       borderRadius: BorderRadius.only(
                                                                //           topRight: Radius.circular(48
                                                                //               .r),
                                                                //           topLeft:
                                                                //               Radius.circular(48.r))),
                                                                //   builder:
                                                                //       (context) =>
                                                                //           SizedBox(
                                                                //     height:
                                                                //         240.h,
                                                                //     child:
                                                                //         Center(
                                                                //       child:
                                                                //           Text(
                                                                //         " رقم الاية${(603 - index + 1).toString().toArabic}",
                                                                //         style: TextStyle(
                                                                //             fontWeight:
                                                                //                 FontWeight.w700,
                                                                //             fontSize: 24.sp),
                                                                //       ),
                                                                //     ),
                                                                //   ),
                                                                // );
                                                              },
                                                        text: quranPages[
                                                                    603 - index]
                                                                ['content'][aya]
                                                            .toString()
                                                            .toArabic),
                                                    //${(0 + 1).toString().toArabic}
                                                    TextSpan(
                                                      text:
                                                          " ${(i + 1).toString().toArabic} ",
                                                      style: TextStyle(
                                                        fontSize: 32.sp,
                                                        color: const Color
                                                            .fromARGB(
                                                            255, 101, 88, 182),
                                                      ),
                                                    )
                                                  }
                                                ]));
                                      },
                                    )),
                              ),
                            ],
                          )
                        },
                      }
                    ],
                  )),
                ],
              ),
            );
          }),
    )));
  }
}
