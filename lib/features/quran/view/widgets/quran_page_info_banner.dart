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
            // GestureDetector(
            //   onTap: () {
            //     // bookmarkCtrl.addPageBookmarkOnTap(context, index);
            //   },
            //   child: SvgPicture.asset(
            //     'assets/svgs/bookmark.svg',
            //     height: 46.h,
            //     width: 30.w,
            //     // color: Color.fromARGB(255, 17, 24, 164),
            //   ),
            // ),
         SizedBox(width: 5.w,),
            Text(
              '${'الجزء'}:${cubit.getPageInfo(index).juz.toString().toArabic}',
              style: TextStyle(
                  fontSize: 15.sp,
                  fontFamily: 'Naskh',
                  color:const Color.fromARGB(255, 150, 126, 68)),
            ),
SizedBox(width: 2.w,),
            Text(
             "${cubit.getHizbQuarterDisplayByPage(index+1)}",
              style: TextStyle(
                  fontSize: 15.sp,
                  fontFamily: 'naskh',
                  color:const Color.fromARGB(255, 150, 126, 68)),
            ),
          ],
        ),
      Text(
          cubit.getSurahNameFromPage(index),
          style: TextStyle(
              fontSize: 15.sp,
              fontFamily: 'naskh',
              color:const Color.fromARGB(255, 150, 126, 68)),
        ),
      ],
    );
  }
}
