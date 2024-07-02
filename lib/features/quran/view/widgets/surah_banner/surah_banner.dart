import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../bussniess_logic/quran/quran_cubit.dart';

class SurahBanner extends StatelessWidget {
  final int pageIndex ,ayaIndex;
  final bool firstPlace;
  const SurahBanner({super.key, required this.pageIndex, required this.ayaIndex, required this.firstPlace});

  @override
  Widget build(BuildContext context) {
      final cubit = QuranCubit.get(context);
           final pageAyahs =
            cubit.getCurrentPageAyahsSeparatedForBasmalah(pageIndex)[ayaIndex];
    return firstPlace?
 (   pageAyahs.first.ayahNumber == 1
        ? cubit.topOfThePageIndex.contains(pageIndex)
            ? const SizedBox.shrink()
            :   Padding(
      padding: EdgeInsets.symmetric(vertical: 5.h),
      child: Stack(
        alignment: Alignment.center,
        children: [
            SvgPicture.asset(
      'assets/svgs/surah_banner1.svg',
      height:  44.h,
      width: Get.width,
    ),// banner
           SvgPicture.asset(
      'assets/svgs/surah_name/00${ cubit.getSurahNumberByAyah(pageAyahs.first).toString()}.svg',
      height:  41.w,
      width: 250.w,
    )
        ],
      ),
    )
        : const SizedBox.shrink())
    :(cubit.downThePageIndex.contains(pageIndex)
        ? Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Stack(
        alignment: Alignment.center,
        children: [
          SvgPicture.asset(
     'assets/svgs/surah_banner1.svg',
      height:  35,
      width: Get.width,
    ),// banner
              SvgPicture.asset(
      'assets/svgs/surah_name/00${ (cubit.getSurahNumberByAyah(pageAyahs.first)+1).toString()}.svg',
      height:  41.w,
      width: 250.w,
    )
        ],
      ),
    )
        : const SizedBox.shrink());
  }
}



