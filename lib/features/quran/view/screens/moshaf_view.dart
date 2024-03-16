import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lnastaqim/features/quran/bussniess_logic/quran/quran_cubit.dart';
import 'package:lnastaqim/features/quran/view/widgets/custom_span.dart';

class MoshafView extends StatelessWidget {
  const MoshafView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: PageView.builder(
              itemCount: 604,
              padEnds: false,
              physics: const ClampingScrollPhysics(),
              itemBuilder: (context, index) {
                return Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 12.w),
                  child: MoshafPage(pageIndex: index),
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
        return SizedBox(height: Get.height,
          child: Column(mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: List.generate(pageAyahs.length, (i) {
              final ayahs = pageAyahs[i];
              return Column(
                children: [
                  FittedBox(
                    fit: BoxFit.fitWidth,
                    child: RichText(
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.center,
                      text: TextSpan(
                          style: TextStyle(
                          height: 1.9.h,
                          ),
                          children: List.generate(ayahs.length, (ayahIndex) {
                            return span(
                              isFirstAyah: ayahIndex == 0 ? true : false,
                              text: ayahs[ayahIndex].code_v2,
                              pageIndex: pageIndex,
                              fontSize: 100.sp,
                              
                              surahNum: cubit.getSurahNumberFromPage(pageIndex),
                              ayahNum: ayahs[ayahIndex].ayahUQNumber,
                            );
                          })),
                    ),
                  )
                ],
              );
            }),
          ),
        );
      },
    );
  }
}
