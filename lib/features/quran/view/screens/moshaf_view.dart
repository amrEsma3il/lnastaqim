import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lnastaqim/core/constants/colors.dart';
import 'package:lnastaqim/core/utilits/extensions/arabic_numbers.dart';
import 'package:lnastaqim/core/utilits/extensions/color_from_hex.dart';
import 'package:lnastaqim/features/bookmark/bussniess_logic/bookmark_cubit/bookmark_cubit.dart';
import 'package:lnastaqim/features/bookmark/data/models/bookmark_model.dart';
import 'package:lnastaqim/features/bookmark/views/bookmark_bottom_sheet.dart';
import 'package:lnastaqim/features/note/views/note_bottom_sheet.dart';
import 'package:lnastaqim/features/quran/bussniess_logic/quran/quran_cubit.dart';
import 'package:lnastaqim/features/quran/view/widgets/custom_span.dart';

import 'package:lnastaqim/features/share/views/widgets/share_bottom_sheet.dart';
import 'package:screenshot/screenshot.dart';

import 'package:lnastaqim/features/tafaseer/view/screen/tafseer.dart';
import '../../../../core/constants/images.dart';
import '../../../../core/utilits/controller/search_or_not/search_visibility.dart';
import '../../../../core/utilits/widgets/custom_text_field.dart';
import '../../../quran_sound/logic/audio_cubit/audio_cubit.dart';
import '../../../quran_sound/logic/audio_cubit/audio_state.dart';
import '../../../share/views/widgets/share_ayah_checkbox.dart';
import '../../../tafaseer/bussniess_logic/tafseer_cubit.dart';
import '../../bussniess_logic/pageMoshaf_cubit/page_cubit.dart';
import '../../bussniess_logic/pageMoshaf_cubit/page_state.dart';
import '../../bussniess_logic/quran_sowar/search_on_aya_from_whole_quran_cubit.dart';
import '../../bussniess_logic/screen_tap_Visibility/screen_tap_visability.dart';
import '../../data/models/search_ayah_entity.dart';
import '../../data/models/select_aya_model.dart';
import '../widgets/quran_page_info_banner.dart';
import '../widgets/search_item_component.dart';
import '../widgets/surah_banner/surah_banner.dart';

class MoshafView extends StatelessWidget {
  const MoshafView({super.key});

  // final int? indexP;

  @override
  Widget build(BuildContext context) {
    final cubit = QuranCubit.get(context);
    // final pageController = PageController(
    //   initialPage: indexP ?? 0,
    // );
    return Scaffold(
      resizeToAvoidBottomInset: false, //
      body: SafeArea(
          child: PopScope(
        onPopInvoked: (didPop) {
          QuranCubit.get(context).clearScreen(context);
        },
        child: BlocBuilder<AudioControlCubit, AudioControlState>(
          builder: (context, verseSoundstate) {
            return GestureDetector(
              onTap: () {
                if (!verseSoundstate.isPlaying) {
                  QuranCubit.get(context).clearMenuOverlayEvent();
                }
              },
              onHorizontalDragStart: (position) {
                if (!verseSoundstate.isPlaying) {
                  QuranCubit.get(context).clearScreen(context);
                } else {
                  ScreenOverlayCubit.get(context).clearIverlayVisability();
                }
              },
              child: PageView.builder(
                  controller: cubit.pageController,
                  onPageChanged: (index) {
                    if (!verseSoundstate.isPlaying) {
                      QuranCubit.get(context).clearScreen(context);
                    } else {
                      ScreenOverlayCubit.get(context).clearIverlayVisability();
                    }
                    AudioControlCubit.get(context).updatePage(604 - index);
                  },
                  itemCount: 604,
                  reverse: true,
                  padEnds: false,
                  physics: const ClampingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Stack(
                      children: [
                        GestureDetector(
                          onTap: () {
                            ScreenOverlayCubit.get(context)
                                .overlaysVisability();
                            if (!verseSoundstate.isPlaying) {
                              QuranCubit.get(context).clearMenuOverlayEvent();
                            }
                          },
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(10.w, 0, 10.w, 0),
                            child: MoshafPage(
                              pageIndex: 603 - index,
                              verseSoundstate: verseSoundstate,
                            ),
                          ),
                        ),

                        GestureDetector(
                          onTap: () {
                            ScreenOverlayCubit.get(context)
                                .overlaysVisability();
                          },
                          child: BlocBuilder<ScreenOverlayCubit, int>(
                            builder: (context, state) {
                              return state == 2
                                  ? Container(
                                      width: Get.width,
                                      height: Get.height,
                                      color: Colors.black45,
                                    )
                                  : const SizedBox();
                            },
                          ),
                        ),

                        BlocBuilder<ScreenOverlayCubit, int>(
                          builder: (context, state) {
                            return Stack(
                              children: [
                                state == 1 || state == 2
                                    ? BlocBuilder<SearchVisabilityCubit, bool>(
                                        builder: (context, searchState) {
                                          return Positioned(
                                            top: 0,
                                            left: 0,
                                            right: 0,
                                            child: Container(
                                              width: Get.width,
                                              height: 70.h,
                                              decoration: BoxDecoration(
                                                  color: AppColor.blueColor
                                                      .withOpacity(0.74)),
                                              child: Stack(
                                                children: [
                                                  Positioned(
                                                    right: 3,
                                                    top: 9,
                                                    child: IconButton(
                                                      onPressed: () {
                                                        QuranCubit.get(context)
                                                            .clearScreen(
                                                                context);
                                                        AudioControlCubit.get(
                                                                context)
                                                            .stop();
                                                        Get.back();
                                                      },
                                                      icon: const Icon(
                                                        Icons.arrow_back,
                                                        color: Colors.white,
                                                        size: 25,
                                                      ),
                                                    ),
                                                  ),
                                                  Positioned(
                                                      left: 9,
                                                      top: 9,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          IconButton(
                                                            onPressed: () {
                                                              // List<SearchAyahEntity>
                                                              //     searchResult = cubit
                                                              //         .searchInMoshaf(
                                                              //             searchText:
                                                              //                 'يا');
                                                              // print(searchResult
                                                              //     .length);
                                                              // String finalResult =
                                                              //     "${searchResult[0].aya.ayaTextEmlaey.substring(0, searchResult[0].startPosition)} ${searchResult[0].aya.ayaTextEmlaey.substring(searchResult[0].startPosition, searchResult[0].startPosition + 2)} ${searchResult[0].aya.ayaTextEmlaey.substring(2 + searchResult[0].startPosition, searchResult[0].aya.ayaTextEmlaey.length)}";
                                                              // log(finalResult);
                                                              // print(searchResult.map(
                                                              //     (e) => e.aya
                                                              //         .ayaTextEmlaey));
                                                              if (searchState) {
                                                                SearchOnAyaCubit
                                                                        .get(
                                                                            context)
                                                                    .clearSearchEvent();
                                                              } else {}

                                                              SearchVisabilityCubit
                                                                      .get(
                                                                          context)
                                                                  .searchVisability();
                                                            },
                                                            icon: Icon(
                                                              searchState ==
                                                                      false
                                                                  ? Icons.search
                                                                  : Icons.close,
                                                              color:
                                                                  Colors.white,
                                                              size: 25,
                                                            ),
                                                          ),
                                                          IconButton(
                                                            onPressed: () {},
                                                            icon: const Icon(
                                                              Icons
                                                                  .bookmark_outline,
                                                              color:
                                                                  Colors.white,
                                                              size: 25.5,
                                                            ),
                                                          ),
                                                          // CompositedTransformTarget(
                                                          //   link: cubit.layerLink,
                                                          //   child: IconButton(
                                                          //     onPressed: () {
                                                          //       ScreenOverlayCubit
                                                          //               .get(context)
                                                          //           .menuShow();
                                                          //     },
                                                          //     icon: const Icon(
                                                          //       Icons.more_vert,
                                                          //       color: Colors.white,
                                                          //       size: 22,
                                                          //     ),
                                                          //   ),
                                                          // ),
                                                          CompositedTransformTarget(
                                                            link:
                                                                cubit.layerLink,
                                                            child: InkWell(
                                                              onTap: () {
                                                                SearchOnAyaCubit
                                                                        .get(
                                                                            context)
                                                                    .clearSearchEvent();
                                                                ScreenOverlayCubit
                                                                        .get(
                                                                            context)
                                                                    .menuShow();
                                                              },
                                                              child:
                                                                  Image.asset(
                                                                AppImages.menu,
                                                                color: Colors
                                                                    .white,
                                                                height: 27,
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      )),
                                                  Positioned(
                                                      right: 70,
                                                      // top: 2,

                                                      child: SizedBox(
                                                        width: 211,
                                                        child: Stack(
                                                          children: [
                                                            AnimatedOpacity(
                                                              opacity:
                                                                  searchState ==
                                                                          true
                                                                      ? 0
                                                                      : 1,
                                                              duration:
                                                                  const Duration(
                                                                milliseconds:
                                                                    450,
                                                              ),
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Text(
                                                                    cubit.getSurahNameFromPage(
                                                                        603 -
                                                                            index),
                                                                    style: TextStyle(
                                                                        fontSize: 24
                                                                            .sp,
                                                                        fontFamily:
                                                                            'naskh',
                                                                        color: Colors
                                                                            .white),
                                                                  ),
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Text(
                                                                        '${'صفحة'} ${(603 - index).toString().toArabic}, ',
                                                                        style: TextStyle(
                                                                            fontSize: 15
                                                                                .sp,
                                                                            fontFamily:
                                                                                'Naskh',
                                                                            color:
                                                                                Colors.white70),
                                                                      ),
                                                                      Text(
                                                                        '${'الجزء'}:${cubit.getPageInfo(603 - index).juz.toString().toArabic}',
                                                                        style: TextStyle(
                                                                            fontSize: 15
                                                                                .sp,
                                                                            fontFamily:
                                                                                'Naskh',
                                                                            color:
                                                                                Colors.white70),
                                                                      ),
                                                                      SizedBox(
                                                                        width:
                                                                            2.w,
                                                                      ),
                                                                    ],
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                            Positioned(
                                                                top: 10,
                                                                right: 0,
                                                                // left: 0,

                                                                child:
                                                                    AnimatedOpacity(
                                                                  opacity:
                                                                      searchState ==
                                                                              true
                                                                          ? 1
                                                                          : 0,
                                                                  duration:
                                                                      const Duration(
                                                                    milliseconds:
                                                                        450,
                                                                  ),
                                                                  child:
                                                                      CustomTextField(
                                                                    textColor:
                                                                        Colors
                                                                            .white70,
                                                                    onChanged:
                                                                        (p0) {
                                                                      SearchOnAyaCubit.get(
                                                                              context)
                                                                          .searchEvent(
                                                                              context);
                                                                    },
                                                                    controller:
                                                                        SearchOnAyaCubit.get(context)
                                                                            .searchController,
                                                                    height: 40,
                                                                    width: searchState ==
                                                                            true
                                                                        ? 210
                                                                        : 0,
                                                                    hintText:
                                                                        "بحث في القرءان",
                                                                  ),
                                                                )),
                                                          ],
                                                        ),
                                                      ))
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      )
                                    : const SizedBox(),
                                state == 1 || state == 2
                                    ? Positioned(
                                        bottom: 0,
                                        right: 0,
                                        left: 0,
                                        child: Container(
                                          width: Get.width,
                                          height: 55.h,
                                          decoration: BoxDecoration(
                                            color: AppColor.blueColor
                                                .withOpacity(0.74),
                                          ),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              BlocBuilder<AudioControlCubit,
                                                  AudioControlState>(
                                                builder: (context, verseBarStatus) {

                                                  if (verseBarStatus.playVerseBarStatus==PlayVerseBarStatus.turnOn) {
                                                return      Expanded(
                                                  child: Center(
                                                    child: Padding(
                                                      padding:  EdgeInsets.only(right: 10.w),
                                                      child: Row(
                                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                                          children: [
                                                                              Stack(
                                                                                children: [
                                                                                  Positioned(
                                                                                    child: IconButton(
                                                                                    icon: const Icon(Icons.repeat,  color: Colors.white,),
                                                                                    onPressed: () {
                                                                                     
                                                                                      context.read<AudioControlCubit>().repeatverse();
                                                                                    },
                                                                                                                                                                  
                                                                                                                                                                ),
                                                                                  ),
                                                                             Positioned(top: 2.5,right: 6,
                                                                              child: Text(AudioControlCubit.verseRepatedNumber [verseBarStatus.audioRepeat].toString().toArabic,style: const TextStyle(color: Colors.white60,fontSize: 20),))   ],
                                                                              ),
                                                                            IconButton(
                                                                              icon: const Icon(Icons.skip_next,  color: Colors.white,),
                                                                              onPressed: () {
                                                                                // final selectedReciter = context.read<AudioControlCubit>().state.selectedReciter;
                                                                                context.read<AudioControlCubit>().playPreviousVerse(context);
                                                                              },
                                                                            ),
                                                                            IconButton(
                                                                              icon: BlocBuilder<AudioControlCubit, AudioControlState>(
                                                                                builder: (context, state) {
                                                                                  return Icon(  color: Colors.white,
                                                                                    state.isPlaying ? Icons.pause : Icons.play_arrow,
                                                                                  );
                                                                                },
                                                                              ),
                                                                              onPressed: () {
                                                                                context.read<AudioControlCubit>().togglePlayPause(context);
                                                                              },
                                                                            ),
                                                                              IconButton(
                                                                              icon: const Icon(Icons.stop,  color: Colors.white,),
                                                                              onPressed: () {
                                                                                // final selectedReciter = context.read<AudioControlCubit>().state.selectedReciter;
                                                                                context.read<AudioControlCubit>().stop();
                                                                              },
                                                                            ),
                                                                            IconButton(
                                                                              icon: const Icon(Icons.skip_previous,  color: Colors.white,),
                                                                              onPressed: () {
                                                                                // final selectedReciter = context.read<AudioControlCubit>().state.selectedReciter;
                                                                                context.read<AudioControlCubit>().playNextVerse(context);
                                                                              },
                                                                            ),
                                                                          ],
                                                                        ),
                                                    ),
                                                  ),
                                                );
                                                  }

 if (verseBarStatus.playVerseBarStatus==PlayVerseBarStatus.loading) {
                                                    return   Expanded(
                                                      
                                                      child: Padding(
                                                        padding: EdgeInsets.only(right: 14.w,left: 6.w,top: 14.h,bottom: 3.h),
                                                        child:  Column(crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            SizedBox(height:2.6.h,
                                                              child: LinearProgressIndicator(color:AppColor.yellow1,backgroundColor: AppColor.bluishGray,)),
                                                              SizedBox(height: 3.4.h,),
                                                              Text("تحميل...",style: TextStyle(color: Colors.white70,fontSize: 19.r),)
                                                          ],
                                                        ),
                                                      ));

                                                  }


                                                  return Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      // TODO: play sound verse
                                                      IconButton(
                                                          onPressed: () {
                                                            //verse
                                                            AudioControlCubit
                                                                    .get(
                                                                        context)
                                                                .togglePlayPause(
                                                                    context);
                                                            QuranCubit.get(
                                                                    context)
                                                                .searchAya(
                                                                    verseSoundstate
                                                                        .currentVerse);
                                                          },
                                                          icon: Icon(
                                                            verseSoundstate
                                                                    .isPlaying
                                                                ? Icons.pause
                                                                : Icons
                                                                    .play_arrow,
                                                            color: Colors.white,
                                                          )),
                                                      Container(
                                                        color: Colors.white,
                                                        width: 1.2,
                                                        height: 45,
                                                      ),
                                                      SizedBox(
                                                        width: 13.w,
                                                      ),
                                                      Text(
                                                        verseSoundstate
                                                            .selectedReciter
                                                            .arabicName,
                                                        style: TextStyle(
                                                            fontSize: 21.sp,
                                                            fontFamily: 'naskh',
                                                            color:
                                                                Colors.white),
                                                      )
                                                    ],
                                                  );
                                                },
                                              ),
                                              IconButton(
                                                  onPressed: () {
                                                    AudioControlCubit.get(
                                                            context)
                                                        .showReciters(context);
                                                  },
                                                  icon: const Icon(
                                                    Icons.keyboard_arrow_up,
                                                    color: Colors.white,
                                                  ))
                                            ],
                                          ),
                                        ))
                                    : const SizedBox()
                              ],
                            );
                          },
                        ),

                        BlocBuilder<SearchOnAyaCubit, List<SearchAyahEntity>>(
                          builder: (context, searchAyahState) {
                            String searchText = SearchOnAyaCubit.get(context)
                                .searchController
                                .text;
                            return searchText.isNotEmpty
                                ? Positioned(
                                    width: Get.width - 14,
                                    child: CompositedTransformFollower(
                                      link: cubit.layerLink,
                                      offset: Offset(-1.5, 55.h),
                                      showWhenUnlinked: false,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: AppColor.blueColor
                                              .withOpacity(0.86),
                                        ),
                                        height: searchAyahState.isEmpty
                                            ? 118.h * 3
                                            : searchAyahState.length < 6
                                                ? searchAyahState.length * 118.h
                                                : Get.height - 175,
                                        width: Get.width - 20,
                                        child: searchAyahState.isEmpty
                                            ? const Center(
                                                child: Text(
                                                  "لا توجد نتائج ...",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 23,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              )
                                            : ListView.separated(
                                                itemBuilder: (context, index) {
                                                  return SearchItemComponent(
                                                    ayaInfo:
                                                        searchAyahState[index],
                                                    searchWordLength:
                                                        searchText.length,
                                                  );
                                                },
                                                separatorBuilder:
                                                    (context, index) =>
                                                        Container(
                                                          width: Get.width,
                                                          height: 0.9.h,
                                                          color: Colors.white,
                                                        ),
                                                itemCount:
                                                    searchAyahState.length),
                                      ),
                                    ))
                                : const SizedBox();
                          },
                        ),
                        //TODO: widget component here for menu and improve to

                        BlocBuilder<ScreenOverlayCubit, int>(
                          builder: (context, state) {
                            return state == 2
                                ? Positioned(
                                    width: 198,
                                    child: CompositedTransformFollower(
                                        link: cubit.layerLink,
                                        offset: Offset(-7, -7.h),
                                        showWhenUnlinked: false,
                                        child: Container(
                                          // width:  170,
                                          height: 239,
                                          decoration: BoxDecoration(
                                              color: AppColor.blueColor,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: ListView.separated(
                                              itemBuilder: (context, index) =>
                                                  GestureDetector(
                                                    onTap: ScreenOverlayCubit
                                                                .get(context)
                                                            .menuItems(
                                                                context)[index]
                                                        ['onTap'],
                                                    child: SizedBox(
                                                      width: Get.width,
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.fromLTRB(
                                                                0,
                                                                16.h,
                                                                15.h,
                                                                16.h),
                                                        child: Text(
                                                          ScreenOverlayCubit.get(
                                                                      context)
                                                                  .menuItems(
                                                                      context)[
                                                              index]['text'],
                                                          style: TextStyle(
                                                              fontSize: 18.sp,
                                                              fontFamily:
                                                                  'naskh',
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                              separatorBuilder:
                                                  (context, index) => Container(
                                                        width: Get.width,
                                                        height: 0.34,
                                                        color: Colors.white,
                                                      ),
                                              itemCount: 4),
                                        )))
                                : const SizedBox();
                          },
                        ),
                      ],
                    );
                  }),
            );
          },
        ),
      )),
    );
  }
}

class MoshafPage extends StatefulWidget {
  const MoshafPage(
      {super.key, required this.pageIndex, required this.verseSoundstate});
  final AudioControlState verseSoundstate;
  final int pageIndex;

  @override
  State<MoshafPage> createState() => _MoshafPageState();
}

class _MoshafPageState extends State<MoshafPage> {
  final screenShotController = ScreenshotController();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuranCubit, SelectAyaModel>(
      builder: (context, moshafPageState) {
        var cubit = QuranCubit.get(context);
        var pageAyahs =
            cubit.getCurrentPageAyahsSeparatedForBasmalah(widget.pageIndex);
        return SizedBox(
          height: Get.height,
          child: Stack(
            children: [
              Positioned(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 8.h,
                    ),
                    QuranPageInfoBanner(index: widget.pageIndex),
                    SizedBox(height: 3.h),
                    ...List.generate(pageAyahs.length, (i) {
                      final ayahs = pageAyahs[i];
                      return Column(
                        children: [
                          SurahBanner(
                              pageIndex: widget.pageIndex,
                              ayaIndex: i,
                              firstPlace: true),
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
                                    var bookmarks =
                                        BlocProvider.of<BookmarkCubit>(context)
                                            .bookmarks;
                                    var bookmarkedAyah = bookmarks?.firstWhere(
                                      (bookmark) =>
                                          bookmark.ayah ==
                                          ayahs[ayahIndex].text,
                                      orElse: () => BookmarkModel(
                                          ayah: "",
                                          ayahNum: 0,
                                          color: 0,
                                          name: "",
                                          pageNum: ""),
                                    );

                                    if (bookmarkedAyah != null &&
                                        bookmarkedAyah.ayah ==
                                            ayahs[ayahIndex].text) {
                                      return span(
                                        backgroundColor:
                                            Color(bookmarkedAyah.color)
                                                .withOpacity(0.3),
                                        onLongPressStart:
                                            (LongPressStartDetails details) {
                                          print(moshafPageState);
                                          if (!widget
                                              .verseSoundstate.isPlaying) {
                                            cubit.toggleAyahSelection(
                                              selectAya: SelectAyaModel(
                                                ayaNumber: ayahs[ayahIndex]
                                                    .ayahUQNumber,
                                                offset: details.globalPosition,
                                              ),
                                            );
                                          }
                                          AudioControlCubit.get(context)
                                              .changeAyaIndex(ayahs[ayahIndex]
                                                  .ayahUQNumber);
                                        },
                                        isFirstAyah:
                                            ayahIndex == 0 ? true : false,
                                        text: ayahIndex == 0
                                            ? "${ayahs[ayahIndex].codeV2[0]}${ayahs[ayahIndex].codeV2.substring(1)}"
                                            : ayahs[ayahIndex].codeV2,
                                        pageIndex: widget.pageIndex,
                                        fontSize: 100.sp,
                                        surahNum: cubit.getSurahNumberFromPage(
                                            widget.pageIndex),
                                        ayahNum: ayahs[ayahIndex].ayahUQNumber,
                                      );
                                    }

                                    return span(
                                      backgroundColor:
                                          moshafPageState.ayaNumber ==
                                                  ayahs[ayahIndex].ayahUQNumber
                                              ? const Color.fromARGB(
                                                  255, 150, 126, 68)
                                              : Colors.transparent,
                                      onLongPressStart:
                                          (LongPressStartDetails details) {
                                        print(moshafPageState);

                                        print(ayahs[ayahIndex].ayahUQNumber);
                                        TafseerCubit.get(context).getayanumber(
                                            ayahs[ayahIndex].ayahUQNumber);

                                        if (!widget.verseSoundstate.isPlaying) {
                                          cubit.toggleAyahSelection(
                                              selectAya: SelectAyaModel(
                                                  ayaNumber: ayahs[ayahIndex]
                                                      .ayahUQNumber,
                                                  offset:
                                                      details.globalPosition));
                                        }
                                        AudioControlCubit.get(context)
                                            .changeAyaIndex(
                                                ayahs[ayahIndex].ayahUQNumber);
                                      },
                                      isFirstAyah:
                                          ayahIndex == 0 ? true : false,
                                      text: ayahIndex == 0
                                          ? "${ayahs[ayahIndex].codeV2[0]}${ayahs[ayahIndex].codeV2.substring(1)}"
                                          : ayahs[ayahIndex].codeV2,
                                      pageIndex: widget.pageIndex,
                                      fontSize: 100.sp,
                                      surahNum: cubit.getSurahNumberFromPage(
                                          widget.pageIndex),
                                      ayahNum: ayahs[ayahIndex].ayahUQNumber,
                                    );
                                  })),
                            ),
                          ),
                          SurahBanner(
                              pageIndex: widget.pageIndex,
                              ayaIndex: i,
                              firstPlace: false),
                        ],
                      );
                    }),
                  ],
                ),
              ),
              moshafPageState.ayaNumber != -1
                  ? Positioned(
                      right: Get.width - moshafPageState.offset.dx.w <
                              Get.width / 4
                          ? 1.w
                          : (Get.width - moshafPageState.offset.dx.w >
                                  (Get.width / 4) * 3
                              ? 68.w
                              : 37.w),
                      top: moshafPageState.offset.dy - 104.h,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 6.w, vertical: 4.h),
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
                                const TafseerScreen(),
                                Container(
                                  width: 1.5.w,
                                  height: 19.h,
                                  color:
                                      const Color.fromARGB(255, 150, 126, 68),
                                ),
                                IconButton(
                                        onPressed: () {
                                          // clear all tabs than open 1 tap
                                          //play specific verse
                                          //  if(!widget.verseSoundstate.isPlaying)  { QuranCubit.get(context)
                                          //         .clearMenuOverlayEvent();}
                                          QuranCubit.get(context).searchAya(
                                             widget.verseSoundstate.currentVerse);
                                          ScreenOverlayCubit.get(context)
                                              .overlaysVisability();

// final verses= pageAyahs[pageChangeState.pageNum];
                                          if (widget
                                              .verseSoundstate.isPlaying) {
                                            AudioControlCubit.get(context)
                                                .stop();
                                          } else {
                                            AudioControlCubit.get(context)
                                                .togglePlayPause(context,
                                                    verseNumber:   widget.verseSoundstate.
                                                        currentVerse);
                                          }
                                        },
                                        icon: Icon(
                                          widget.verseSoundstate.isPlaying
                                              ? Icons.stop
                                              : Icons.play_arrow_rounded,
                                          color: const Color.fromARGB(
                                              255, 150, 126, 68),
                                          size: 32,
                                        )),
                                
                                Container(
                                  width: 1.5.w,
                                  height: 19.h,
                                  color:
                                      const Color.fromARGB(255, 150, 126, 68),
                                ),
                                IconButton(
                                    onPressed: () {
                                      showBookmarkBottomSheet(
                                          context, pageAyahs, moshafPageState);
                                    },
                                    icon: Icon(
                                      Icons.bookmark_border,
                                      color: "#404c6e".toColor,
                                    )),
                                Container(
                                  width: 1.5.w,
                                  height: 19.h,
                                  color:
                                      const Color.fromARGB(255, 150, 126, 68),
                                ),
                                IconButton(
                                    onPressed: () {
                                      if (moshafPageState.ayaNumber != -1) {
                                        final selectedAyah = pageAyahs
                                            .expand((ayahList) => ayahList)
                                            .firstWhere((ayah) =>
                                                ayah.ayahUQNumber ==
                                                moshafPageState.ayaNumber);
                                        // print(selectedAyah.page);
                                        // print(selectedAyah.ayahNumber);

                                        Clipboard.setData(ClipboardData(
                                                text: selectedAyah.text))
                                            .then((_) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                                content: Center(
                                                    child: Text(
                                                        'تم النسخ إلى الحافظه'))),
                                          );
                                        });
                                      }
                                    },
                                    icon: Icon(
                                      Icons.content_copy_sharp,
                                      color: "#404c6e".toColor,
                                    )),
                                Container(
                                  width: 1.5.w,
                                  height: 19.h,
                                  color:
                                      const Color.fromARGB(255, 150, 126, 68),
                                ),
                                IconButton(
                                    onPressed: () async {
                                      if (moshafPageState.ayaNumber != -1) {
                                        final selectedAyah = pageAyahs
                                            .expand((ayahList) => ayahList)
                                            .firstWhere((ayah) =>
                                                ayah.ayahUQNumber ==
                                                moshafPageState.ayaNumber);
                                        showShareBottomSheet(
                                            context,
                                            ShareAyahCheckBox(
                                              ayahNumber: selectedAyah
                                                  .ayahNumber
                                                  .toString(),
                                              selectedAyah: selectedAyah,
                                            ));
                                      }
                                    },
                                    icon: Icon(
                                      Icons.share_outlined,
                                      color: "#404c6e".toColor,
                                    )),
                                Container(
                                  width: 1.5.w,
                                  height: 19.h,
                                  color:
                                      const Color.fromARGB(255, 150, 126, 68),
                                ),
                                IconButton(
                                    onPressed: () {
                                      if (moshafPageState.ayaNumber != -1) {
                                        final selectedAyah = pageAyahs
                                            .expand((ayahList) => ayahList)
                                            .firstWhere((ayah) =>
                                                ayah.ayahUQNumber ==
                                                moshafPageState.ayaNumber);
                                        showNoteBottomSheet(
                                            context, selectedAyah);
                                      }
                                    },
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
                bottom: 8.h,
                child: Center(
                  child: Text(
                    (widget.pageIndex + 1).toString().toArabic,
                    style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w900,
                        fontFamily: 'naskh',
                        color: const Color.fromARGB(255, 150, 126, 68)),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
