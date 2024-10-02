

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lnastaqim/core/utilits/extensions/arabic_numbers.dart';

import '../../../../../core/constants/colors.dart';
import '../../../bussniess_logic/quran/index_cubit/index_cubit.dart';
import '../../../bussniess_logic/quran/quran_cubit.dart';
import '../../../data/models/quran_model.dart';

class QuranHizpComponent extends StatelessWidget {
  final HizpModel hizp;

  const QuranHizpComponent({
    super.key,
    required this.hizp,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // int page=indexEntity is SurahIndexState ?(indexEntity as SurahIndexState).indexList as List<SurahIndex>.sta:;
        
        
        // || indexEntity is ChapterIndexState ||indexEntity is HizbIndexState?indexEntity.indexList.startPage:0;
        Get.back();
        

        BlocProvider.of<IndexCubit>(context)
            .moveToPageEvent(context,hizp.page);
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(20.w, 6.h, 20.w, 6.h),
        margin: EdgeInsets.only(bottom:11.h),
        // width: Get.width-80.w,
        // height: 75.h,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(15.r)),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
           Row(children: [ Stack(
              alignment: Alignment.topCenter,
              children: [
                // Image.asset(
                //   AppImages.pattern,
                //   width: 32.w,
                //   height: 32.h,
                //   color:  AppColor.blueColor,
                // ),
                Container(
                   width: 32,
              height: 34,
              alignment: Alignment.center,
              // margin: const EdgeInsets.only(right: 20),
           decoration:   BoxDecoration(color: AppColor.grey.withOpacity(0.23),shape: BoxShape.circle),
                  padding:  EdgeInsets.only(top: 1.h),
                  child: Text(
                   IndexCubit.hizbQuarterToFraction(hizp.hizbQuarter).toArabic,
                    style:  const TextStyle(color: AppColor.blueColor,fontSize: 17),
                  ),
                )
              ],
            ),
            SizedBox(
              width: 18.w,
            ),
            Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 1,),
                SizedBox(width: 215.w,
                // height: 150,

                  child: Text(
                    hizp.text,
                    maxLines: 5,
                    softWrap: true,

                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(wordSpacing:-2,
                    // letterSpacing: 0.7,
                        color: AppColor.blueColor,
                        fontSize: 16.sp,
                        fontFamily: "Naskh",
                        fontWeight: FontWeight.w600),
                  ),
                ),

                SizedBox(height: 4.h,),
                Text("الصفحة ${hizp.page.toString().toArabic} - ${QuranCubit.removeTashkeel(hizp.surahName)} ${hizp.numberInSurah.toString().toArabic}",style:  TextStyle(color: AppColor.darkYellow,fontWeight: FontWeight.w600,fontSize: 15.2,wordSpacing: 0.2),),
             const   SizedBox(width: 20,)

              ],
            )],),

            Container(
              width: 33,
              height: 32,
              alignment: Alignment.center,
              margin: const EdgeInsets.only(right: 20),
           decoration:  BoxDecoration(color:  AppColor.blueColor.withOpacity(0.85),shape: BoxShape.circle),
              child: Text(hizp.page.toString().toArabic,style:  TextStyle(fontSize: 15,color: AppColor.white),))
          ],
        ),
      ),
    );
  }
}
