import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lnastaqim/core/utilits/extensions/arabic_numbers.dart';
import 'package:lnastaqim/core/utilits/extensions/color_from_hex.dart';
import 'package:lnastaqim/features/quran/bussniess_logic/quran/quran_cubit.dart';
import 'package:lnastaqim/features/quran/view/widgets/custom_span.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/constants/images.dart';
import '../../data/models/select_aya_model.dart';
import '../widgets/quran_page_info_banner.dart';
import '../widgets/surah_banner/surah_banner.dart';

class MoshafView extends StatelessWidget {
  const MoshafView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: GestureDetector(
        onTap: () {
          QuranCubit.get(context).onMoshafPageChangedEvent();
        },
        onHorizontalDragStart: (position) {
          QuranCubit.get(context).onMoshafPageChangedEvent();
        },
        child: PageView.builder(
            onPageChanged: (index) {
              QuranCubit.get(context).onMoshafPageChangedEvent();
            },
            itemCount: 604,
            reverse: true,
            padEnds: false,
            physics: const ClampingScrollPhysics(),
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: MoshafPage(pageIndex: 603 - index),
              );
            }),
      )),
    );
  }
}

class MoshafPage extends StatelessWidget {
  const MoshafPage({super.key, required this.pageIndex});

  final int pageIndex;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuranCubit, SelectAyaModel>(
      builder: (context, moshafPageState) {
        var cubit = QuranCubit.get(context);
        var pageAyahs =
            cubit.getCurrentPageAyahsSeparatedForBasmalah(pageIndex);
        return Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                QuranPageInfoBanner(index: pageIndex),
                SizedBox(height: 2.h),
                ...List.generate(pageAyahs.length, (i) {
                  final ayahs = pageAyahs[i];
                  return Column(
                    children: [
                      SurahBanner(
                          pageIndex: pageIndex, ayaIndex: i, firstPlace: true),
                      cubit.getSurahNumberByAyah(ayahs.first) == 9 ||
                              cubit.getSurahNumberByAyah(ayahs.first) == 1
                          ? const SizedBox.shrink()
                          : Padding(
                              padding: EdgeInsets.only(bottom: 3.h),
                              child: ayahs.first.ayahNumber == 1
                                  ? SvgPicture.asset(
                                      (cubit.getSurahNumberByAyah(
                                                      ayahs.first) ==
                                                  95 ||
                                              cubit.getSurahNumberByAyah(
                                                      ayahs.first) ==
                                                  97)
                                          ? 'assets/svgs/besmAllah2.svg'
                                          : 'assets/svgs/besmAllah.svg',
                                      width: 300.w,
                                      height: 41.h,
                                      colorFilter: const ColorFilter.mode(
                                          Color.fromARGB(255, 14, 10, 58),
                                          BlendMode.srcIn),
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
                                height: 2.04.h,
                              ),
                              children:
                                  List.generate(ayahs.length, (ayahIndex) {
                                return span(
                                  backgroundColor: moshafPageState.ayaNumber ==
                                          ayahs[ayahIndex].ayahUQNumber
                                      ? const Color.fromARGB(255, 150, 126, 68)
                                      : Colors.transparent,
                                  onLongPressStart:
                                      (LongPressStartDetails details) {
                                    print(moshafPageState);
                                    cubit.toggleAyahSelection(
                                        selectAya: SelectAyaModel(
                                            ayaNumber:
                                                ayahs[ayahIndex].ayahUQNumber,
                                            offset: details.globalPosition));
                                    // print(details.globalPosition);
                                    // print(Get.height);
                                    // print( Get.width- details.globalPosition.dx);
                                    // print(ayahs[ayahIndex].codeV2);
                                    // print(pageIndex);
                                  },
                                  isFirstAyah: ayahIndex == 0 ? true : false,
                                  text: ayahIndex == 0
                                      ? "${ayahs[ayahIndex].codeV2[0]}${ayahs[ayahIndex].codeV2.substring(1)}"
                                      : ayahs[ayahIndex].codeV2,
                                  pageIndex: pageIndex,
                                  fontSize: 100.sp,
                                  surahNum:
                                      cubit.getSurahNumberFromPage(pageIndex),
                                  ayahNum: ayahs[ayahIndex].ayahUQNumber,
                                );
                              
                              
                              })),
                        ),
                      ),
                 
                      SurahBanner(
                          pageIndex: pageIndex, ayaIndex: i, firstPlace: false),
                    ],
                  );
                }),
              ],
            ),
            moshafPageState.ayaNumber != -1
                ? Positioned(
                    right:
                        Get.width - moshafPageState.offset.dx.w < Get.width / 4
                            ? 1.w
                            : (Get.width - moshafPageState.offset.dx.w >
                                    (Get.width / 4) * 3
                                ? 68.w
                                : 37.w),
                    top: moshafPageState.offset.dy - 104.h,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        color: "#404c6e".toColor,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8)),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8)),
                            border: Border.all(
                                width: 2,
                                color: Get.theme.colorScheme.primary
                                    .withOpacity(.5))),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 2.w),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.menu_book_rounded,
                                    color: "#404c6e".toColor,
                                  )),
                              Container(
                                width: 1.5.w,
                                height: 19.h,
                                color: Color.fromARGB(255, 150, 126, 68),
                              ),
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.play_arrow_rounded,
                                    color: Color.fromARGB(255, 150, 126, 68),
                                    size: 32,
                                  )),
                              Container(
                                width: 1.5.w,
                                height: 19.h,
                                color: Color.fromARGB(255, 150, 126, 68),
                              ),
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.bookmark_border,
                                    color: "#404c6e".toColor,
                                  )),
                              Container(
                                width: 1.5.w,
                                height: 19.h,
                                color: Color.fromARGB(255, 150, 126, 68),
                              ),
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.content_copy_sharp,
                                    color: "#404c6e".toColor,
                                  )),
                              Container(
                                width: 1.5.w,
                                height: 19.h,
                                color: Color.fromARGB(255, 150, 126, 68),
                              ),
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.share_outlined,
                                    color: "#404c6e".toColor,
                                  )),
                              Container(
                                width: 1.5.w,
                                height: 19.h,
                                color: Color.fromARGB(255, 150, 126, 68),
                              ),
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.note_alt_outlined,
                                    color: "#404c6e".toColor,
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
            Positioned(
              right: Get.width / 2 - 29.w,
              bottom: 6.h,
              child: Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 3.h),
                      child: Image.asset(
                        AppImages.numberingaPage4,
                        width: 32.w,
                        height: 31.h,
                        // color:"#404c6e".toColor,
                      ),
                    ),
                    Text(
                      (pageIndex + 1).toString().toArabic,
                      style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w900,
                          fontFamily: 'naskh',
                          color: const Color.fromARGB(255, 150, 126, 68)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
