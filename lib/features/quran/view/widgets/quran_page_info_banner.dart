import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lnastaqim/core/utilits/extensions/arabic_numbers.dart';

import '../../bussniess_logic/quran/quran_cubit.dart';

class QuranPageInfoBanner extends StatelessWidget {
  final int index;

  const QuranPageInfoBanner({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final cubit = QuranCubit.get(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // const Gap(16),
        Row(
          children: [
            GestureDetector(
              onTap: () {
                // bookmarkCtrl.addPageBookmarkOnTap(context, index);
              },
              child: SvgPicture.asset(
                'assets/svgs/bookmark.svg',
                height: 45.h,
                width: 30.w,
                // color: Color.fromARGB(255, 17, 24, 164),
              ),
            ),
         SizedBox(width: 5.w,),
            Text(
              '${'الجزء'}:${cubit.getPageInfo(index).juz.toString().toArabic}',
              style: TextStyle(
                  fontSize: 14.sp,
                  fontFamily: 'Naskh',
                  color: Color.fromARGB(255, 10, 10, 10)),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 3.5.w),
              width: 1.w,
              height: 14.h,
              color: const Color.fromARGB(255, 58, 30, 147),
            ),
            Text(
              '${'الحزب'}:${cubit.getPageInfo(index).hizbQuarter.toString().toArabic}',
              style: TextStyle(
                  fontSize: 14.sp,
                  fontFamily: 'naskh',
                  color: Color.fromARGB(255, 10, 10, 10)),
            ),
          ],
        ),
        Container(
          margin: EdgeInsets.only(left: 25.w),
          child: Text(
            (index + 1).toString().toArabic,
            style: TextStyle(
                fontSize: 15.5.sp,
                fontFamily: 'naskh',
                color: Color.fromARGB(255, 19, 18, 18)),
          ),
        ),
        Text(
          cubit.getSurahNameFromPage(index),
          style: TextStyle(
              fontSize: 14.sp,
              fontFamily: 'naskh',
              color: Color.fromARGB(255, 19, 18, 18)),
        ),
      ],
    );
  }
}
