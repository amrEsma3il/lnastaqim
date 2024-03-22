import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lnastaqim/features/quran/bussniess_logic/quran/quran_cubit.dart';
import 'package:lnastaqim/features/quran/view/widgets/custom_span.dart';
import 'package:flutter_svg/svg.dart';

import '../widgets/quran_page_info_banner.dart';
import '../widgets/surah_banner/surah_banner.dart';

class MoshafView extends StatelessWidget {
  const MoshafView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: PageView.builder(
              itemCount: 604,
              reverse: true,
              padEnds: false,
              physics: const ClampingScrollPhysics(),
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: MoshafPage(pageIndex: 603 - index),
                );
              })),
    );
  }
}

class MoshafPage extends StatelessWidget {
  const MoshafPage({super.key, required this.pageIndex});

  final int pageIndex;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuranCubit, QuranState>(
      builder: (context, state) {
        var cubit = QuranCubit.get(context);
        var pageAyahs =
            cubit.getCurrentPageAyahsSeparatedForBasmalah(pageIndex);
        return Column(
          mainAxisSize: MainAxisSize.min,
          children:[ 
            QuranPageInfoBanner(index: pageIndex),
            SizedBox(height:4.h),
            ...List.generate(pageAyahs.length, (i) {
            final ayahs = pageAyahs[i];
            return Column(
              children: [
                SurahBanner(pageIndex: pageIndex,ayaIndex: i,firstPlace: true),
                cubit.getSurahNumberByAyah(ayahs.first) == 9 ||
                        cubit.getSurahNumberByAyah(ayahs.first) == 1
                    ? const SizedBox.shrink()
                    : Padding(
                        padding:  EdgeInsets.only(bottom: 3.h),
                        child: ayahs.first.ayahNumber == 1
                            ? SvgPicture.asset(
                                (cubit.getSurahNumberByAyah(ayahs.first) ==
                                            95 ||
                                        cubit.getSurahNumberByAyah(
                                                ayahs.first) ==
                                            97)
                                    ? 'assets/svgs/besmAllah2.svg'
                                    : 'assets/svgs/besmAllah.svg',
                                width: 300.w,
                                height: 41.h,
                                colorFilter: ColorFilter.mode(Color.fromARGB(255, 14, 10, 58), BlendMode.srcIn),
                              )
                            : const SizedBox.shrink(),
                      ),
                FittedBox(
                  fit: BoxFit.fitWidth,
                  child: RichText(
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.center,
                    text: TextSpan(
                        style: TextStyle(
                          shadows: [
                            Shadow(
                                color: Colors.black87,
                                offset: Offset(0.7.w, 0.7.h),
                                blurRadius: 0.7.r),
                     
                    
                       
                          ],
                          height: 2.h,
                        ),
                        children: List.generate(ayahs.length, (ayahIndex) {
                          return span(
                            isFirstAyah: ayahIndex == 0 ? true : false,
                            text: ayahs[ayahIndex].code_v2,
                            pageIndex: pageIndex,
                            fontSize: 300.sp,
                            surahNum: cubit.getSurahNumberFromPage(pageIndex),
                            ayahNum: ayahs[ayahIndex].ayahUQNumber,
                          );
                        })),
                  ),
                ),
                  SurahBanner(pageIndex: pageIndex,ayaIndex: i,firstPlace: false),
              ],
            );
          })],
        );
      },
    );
  }
}
