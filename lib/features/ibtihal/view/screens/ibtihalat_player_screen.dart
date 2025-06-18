
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lnastaqim/core/utilits/extensions/color_from_hex.dart';
import 'package:lnastaqim/core/utilits/extensions/double_int_parser_extension.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/animations.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/images.dart';
import '../../bussnies_logic/ibtihal_player_cubit.dart';

class IbtihalatPlayerScreen extends StatelessWidget {
  const IbtihalatPlayerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            height: Get.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColor.lightBlue2,
                  AppColor.blueColor,
                  AppColor.blueBlack2,
                ],
                stops: const [0.0, 0.5, 1.0],
              ),
            ),
            padding: const EdgeInsets.fromLTRB(2, 9, 6, 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: Get.width),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 4.0),
                      child: IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: Icon(
                          Icons.arrow_back,
                          color: AppColor.white,
                          size: 28,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 8.w),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                enableDrag: false,
                                context: context,
                                backgroundColor: AppColor.blueColor,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
                                ),
                                builder: (bottomSheetContext) {
                                  return RecitersBottomSheetComponent(cubit: IbtihalatPlayerCubit.get(context));
                                },
                              );
                            },
                            child: BlocBuilder<IbtihalatPlayerCubit, IbtihalatPlayerState>(
                              builder: (context, state) {
                                return Text(
                                  state.reciter.nameArabic.isNotEmpty ? state.reciter.nameArabic : 'غير معروف',
                                  style: TextStyle(
                                      wordSpacing: 0.1,
                                      fontSize: 16.sp,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400),
                                );
                              },
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              IbtihalatPlayerCubit.get(context).clearIbtihalSearch(); // Reset search results
                              showModalBottomSheet(
                                enableDrag: false,
                                context: context,
                                backgroundColor: AppColor.blueColor,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
                                ),
                                builder: (bottomSheetContext) {
                                  return IbtihalatBottomSheetComponent(cubit: IbtihalatPlayerCubit.get(context));
                                },
                              );
                            },
                            child: Padding(
                              padding: EdgeInsets.only(right: 4.w),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  BlocBuilder<IbtihalatPlayerCubit, IbtihalatPlayerState>(
                                    builder: (context, state) {
                                      final ibtihalName = state.reciter.info.isNotEmpty &&
                                              state.ibtihalNumber < state.reciter.info.length
                                          ? state.reciter.info[state.ibtihalNumber].name
                                          : 'غير معروف';
                                      return Text(
                                        ibtihalName,
                                        style: TextStyle(
                                            fontSize: 14.sp,
                                            color: Colors.white70,
                                            fontWeight: FontWeight.w600),
                                      );
                                    },
                                  ),
                                  SizedBox(width: 4.w),
                                  const Icon(Icons.keyboard_arrow_down_sharp, size: 21, color: Colors.white70),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    BlocBuilder<IbtihalatPlayerCubit, IbtihalatPlayerState>(
                      builder: (context, state) {
                        return IconButton(
                          onPressed: () async {
                            try {
                              await IbtihalatPlayerCubit.get(context).updateFavoriteList();
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('خطأ: $e')));
                            }
                          },
                          icon: Icon(
                            state.isIbtihalFavorite ? Icons.favorite : Icons.favorite_border_outlined,
                            color: AppColor.white,
                            size: 26,
                          ),
                        );
                      },
                    ),
                  ],
                ),
                SizedBox(height: 47.h),
                const IbtihalatInfoWidget(),
                SizedBox(height: 80.h),
                const IbtihalatSliderWidget(),
                SizedBox(height: 11.h),
                const IbtihalatControlsWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RecitersBottomSheetComponent extends StatelessWidget {
  const RecitersBottomSheetComponent({super.key, required this.cubit});

  final IbtihalatPlayerCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.transparent),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          onChanged: (value) => cubit.searchReciters(query: value),
                          decoration: const InputDecoration(
                            hintText: 'ابحث عن قارئ...',
                            hintStyle: TextStyle(color: Colors.white70),
                            prefixIcon: Icon(Icons.search, color: Colors.white),
                            border: InputBorder.none,
                          ),
                          style: const TextStyle(color: Colors.white),
                          cursorColor: AppColor.lightBlue,
                          cursorRadius: const Radius.circular(10),
                        ),
                      ),
                      SizedBox(width: 14.w),
                      CountryFilterComponent(cubit: cubit),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 14.w),
              GestureDetector(
                onTap: () {
                  Get.back();
                  cubit.clearReciterSearch();
                },
                child: Container(
                  padding: const EdgeInsets.all(7),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.close, color: Colors.white, size: 19),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Expanded(
            child: BlocBuilder<IbtihalatPlayerCubit, IbtihalatPlayerState>(
              builder: (context, state) {
                final results = state.searchReciterResults;
                return Visibility(
                  visible: results.isNotEmpty,
                  replacement: Container(
                    decoration: const BoxDecoration(color: Colors.transparent),
                    child: Center(
                      child: Text(
                        "لا يوجد قراء",
                        style: TextStyle(
                            color: AppColor.lightBlue, fontSize: 20.sp, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  child: ListView.builder(
                    itemCount: results.length,
                    itemBuilder: (context, index) {
                      final reciter = results[index];
                      return ListTile(
                        selected: reciter.id == state.reciter.id,
                        selectedTileColor: Colors.white.withOpacity(0.1),
                        title: Text(
                          reciter.nameArabic.isNotEmpty ? reciter.nameArabic : 'غير معروف',
                          style: const TextStyle(color: Colors.white),
                        ),
                        trailing: SvgPicture.asset(
                          IbtihalatPlayerCubit.getCountryFlag(reciter.nationality),
                          width: 17,
                          height: 17,
                        ),
                        onTap: () async {
                          Get.back();
                          await Future.delayed(const Duration(milliseconds: 200));
                          cubit.changeReciter(reciter);
                          cubit.clearReciterSearch();
                        },
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CountryFilterComponent extends StatelessWidget {
  const CountryFilterComponent({super.key, required this.cubit});
  final IbtihalatPlayerCubit cubit;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        await showCountryMenu(context, cubit);
      },
      child: IntrinsicWidth(
        child: Container(
          padding: EdgeInsets.only(right: 7.8.w, bottom: 4.h, top: 4.h, left: 3.w),
          margin: const EdgeInsets.only(left: 5),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.25),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: AppColor.lightBlue, width: 1),
          ),
          child: BlocBuilder<IbtihalatPlayerCubit, IbtihalatPlayerState>(
            builder: (context, state) {
              return Row(
                children: [
                  SvgPicture.asset(
                    IbtihalatPlayerCubit.recitersCountries[state.reciterCountry] ??
                        AppImages.earthFlag,
                    height: 22,
                    width: 22,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    state.reciterCountry.isNotEmpty ? state.reciterCountry : 'كل الدول',
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  const SizedBox(width: 4),
                  const Icon(Icons.keyboard_arrow_down, color: Colors.white, size: 13.5),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Future showCountryMenu(BuildContext context, IbtihalatPlayerCubit cubit) async {
    return await showMenu(
      shadowColor: Colors.black,
      context: context,
      position: const RelativeRect.fromLTRB(290, 290, 187, 822),
      items: IbtihalatPlayerCubit.recitersCountries.entries.map((entry) {
        return PopupMenuItem(
          value: entry.key,
          child: Row(
            children: [
              SvgPicture.asset(entry.value, height: 30, width: 30),
              const SizedBox(width: 12),
              Text(
                entry.key,
                style: const TextStyle(fontSize: 16, color: Colors.white),
              ),
            ],
          ),
        );
      }).toList(),
      elevation: 8.0,
      color: AppColor.blueColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
    ).then((selectedValue) {
      if (selectedValue != null && context.mounted) {
        debugPrint("from menu $selectedValue");
        cubit.searchReciters(country: selectedValue);
      }
    });
  }
}

class IbtihalatInfoWidget extends StatelessWidget {
  const IbtihalatInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 40),
      width: Get.width - 50,
      height: 350.h,
      decoration: const BoxDecoration(
        image: DecorationImage(
          alignment: Alignment.center,
          image: AssetImage(AppImages.ibtihalImage),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class IbtihalatSliderWidget extends StatelessWidget {
  const IbtihalatSliderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = IbtihalatPlayerCubit.get(context);

    return BlocBuilder<IbtihalatPlayerCubit, IbtihalatPlayerState>(
      builder: (context, state) {
        final ibtihalName = state.reciter.info.isNotEmpty && state.ibtihalNumber < state.reciter.info.length
            ? state.reciter.info[state.ibtihalNumber].name
            : 'غير معروف';
        return SizedBox(
          width: Get.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 20.w, right: 21.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () async {
                        await showAudioSpeedMenu(context, cubit);
                      },
                      child: RichText(
                        text: TextSpan(
                          text: state.audioSpeed.parseInt,
                          style: TextStyle(fontSize: 23.sp, color: Colors.white, fontWeight: FontWeight.w400),
                          children: [
                            TextSpan(
                              text: "x",
                              style: TextStyle(
                                  fontSize: 17.5.sp, color: Colors.white, fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          ibtihalName,
                          style: TextStyle(
                              fontSize: 17.sp, color: AppColor.white, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          state.reciter.nameArabic.isNotEmpty ? state.reciter.nameArabic : 'غير معروف',
                          style: TextStyle(
                              fontSize: 14.sp, color: Colors.white70, fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Slider(
                activeColor: AppColor.white,
                thumbColor: AppColor.white,
                inactiveColor: "#6a738a".toColor,
                value: state.currentPosition,
                max: state.ibtihalDuration <= 0 ? 149.0 : state.ibtihalDuration,
                onChangeStart: (_) {
                  context.read<IbtihalatPlayerCubit>().sliderSeekToggle(isSeeking: true);
                },
                onChanged: (value) {
                  context.read<IbtihalatPlayerCubit>().changeAudioPosition(value);
                },
                onChangeEnd: (value) {
                  context.read<IbtihalatPlayerCubit>().seek(value);
                },
              ),
              Padding(
                padding: EdgeInsets.only(left: 23.w, right: 20.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      IbtihalatPlayerCubit.formatDuration(state.currentPosition.toInt()),
                      style: const TextStyle(color: Colors.white60),
                    ),
                    Text(
                      IbtihalatPlayerCubit.formatDuration(state.ibtihalDuration.toInt()),
                      style: const TextStyle(color: Colors.white60),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future showAudioSpeedMenu(BuildContext context, IbtihalatPlayerCubit cubit) async {
    return await showMenu(
      shadowColor: Colors.black,
      context: context,
      position: const RelativeRect.fromLTRB(300, 425, 20, 10),
      items: IbtihalatPlayerCubit.audioSpeedRates.map((rate) {
        return PopupMenuItem(
          value: rate,
          child: RichText(
            text: TextSpan(
              text: rate.parseInt,
              style: TextStyle(fontSize: 23.sp, color: Colors.white, fontWeight: FontWeight.w400),
              children: [
                TextSpan(
                  text: "x",
                  style: TextStyle(
                      fontSize: 17.5.sp, color: Colors.white, fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
        );
      }).toList(),
      elevation: 1.2,
      color: AppColor.blueColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
    ).then((selectedValue) {
      if (selectedValue != null && context.mounted) {
        debugPrint("from menu $selectedValue");
        cubit.setPlaybackRate(selectedValue);
      }
    });
  }
}

class IbtihalatControlsWidget extends StatelessWidget {
  const IbtihalatControlsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(size: 25, Icons.shuffle, color: AppColor.white),
              onPressed: () {
                context.read<IbtihalatPlayerCubit>().playRandomIbtihal();
              },
            ),
            SizedBox(width: 23.w),
            Container(
              decoration:
                  BoxDecoration(shape: BoxShape.circle, border: Border.all(width: 0.9, color: AppColor.white)),
              child: IconButton(
                icon: Icon(Icons.skip_next, color: AppColor.white),
                onPressed: () {
                  context.read<IbtihalatPlayerCubit>().previousIbtihal();
                },
              ),
            ),
            SizedBox(width: 25.w),
            BlocBuilder<IbtihalatPlayerCubit, IbtihalatPlayerState>(
              builder: (context, state) {
                return CircleAvatar(
                  radius: 35,
                  backgroundColor: AppColor.white,
                  child: state.audioState is AudioFetchLoading
                      ? Lottie.asset(
                          AppAnimation.typeLoading,
                          width: 41.w,
                          height: 50.h,
                          fit: BoxFit.contain,
                          repeat: true,
                          animate: true,
                        )
                      : IconButton(
                          color: AppColor.blueColor,
                          icon: state.isPlaying
                              ? const Icon(Icons.pause, size: 35)
                              : const Icon(Icons.play_arrow, size: 37),
                          onPressed: () {
                            context.read<IbtihalatPlayerCubit>().togglePlayPause();
                          },
                        ),
                );
              },
            ),
            SizedBox(width: 25.w),
            Container(
              decoration:
                  BoxDecoration(shape: BoxShape.circle, border: Border.all(width: 0.9, color: AppColor.white)),
              child: IconButton(
                icon: Icon(Icons.skip_previous, color: AppColor.white),
                onPressed: () {
                  context.read<IbtihalatPlayerCubit>().nextIbtihal();
                },
              ),
            ),
            SizedBox(width: 24.w),
            BlocBuilder<IbtihalatPlayerCubit, IbtihalatPlayerState>(
              builder: (context, state) {
                return IconButton(
                  icon: Icon(
                    size: 27,
                    Icons.repeat,
                    color: state.onRepeat ? Colors.teal : AppColor.white,
                  ),
                  onPressed: () {
                    context.read<IbtihalatPlayerCubit>().toggleRepeat();
                  },
                );
              },
            ),
          ],
        ),
        SizedBox(height: 11.h),
        Padding(
          padding: EdgeInsets.only(left: 19.w, right: 12.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(size: 20, Icons.download_outlined, color: Colors.white54),
                onPressed: () {
                  context.read<IbtihalatPlayerCubit>().downloadIbtihal();
                },
              ),
              IconButton(
                icon: const Icon(size: 20, Icons.share_outlined, color: Colors.white54),
                onPressed: () {
                  context.read<IbtihalatPlayerCubit>().shareIbtihal();
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class IbtihalatBottomSheetComponent extends StatelessWidget {
  const IbtihalatBottomSheetComponent({super.key, required this.cubit});

  final IbtihalatPlayerCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  onChanged: (value) => cubit.searchIbtihalat(value),
                  decoration: InputDecoration(
                    hintText: 'ابحث عن ابتهال...',
                    hintStyle: const TextStyle(color: Colors.white70),
                    prefixIcon: const Icon(Icons.search, color: Colors.white),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.1),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(color: Colors.transparent),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(color: Colors.transparent),
                    ),
                  ),
                  style: const TextStyle(color: Colors.white),
                  cursorColor: AppColor.lightBlue,
                  cursorRadius: const Radius.circular(10),
                ),
              ),
              SizedBox(width: 14.w),
              GestureDetector(
                onTap: () {
                  Get.back();
                  cubit.clearIbtihalSearch();
                },
                child: Container(
                  padding: const EdgeInsets.all(7),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.close, color: Colors.white, size: 19),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Expanded(
            child: BlocBuilder<IbtihalatPlayerCubit, IbtihalatPlayerState>(
              builder: (context, state) {
                final results = state.searchIbtihalResults;
                return Visibility(
                  visible: results.isNotEmpty,
                  replacement: Container(
                    decoration: const BoxDecoration(color: Color.fromARGB(0, 3, 2, 2)),
                    child: Center(
                      child: Text(
                        "لا توجد ابتهالات",
                        style: TextStyle(
                            color: AppColor.lightBlue, fontSize: 20.sp, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  child: ListView.builder(
                    itemCount: results.length,
                    itemBuilder: (context, index) {
                      final ibtihalNumber = results[index];
                      final ibtihalName = state.reciter.info.isNotEmpty &&
                              ibtihalNumber < state.reciter.info.length
                          ? state.reciter.info[ibtihalNumber].name
                          : 'غير معروف';
                      return ListTile(
                        selected: ibtihalNumber == state.ibtihalNumber,
                        selectedTileColor: Colors.white.withOpacity(0.1),
                        title: Text(
                          ibtihalName,
                          style: const TextStyle(color: Colors.white),
                        ),
                        trailing: const Icon(Icons.music_note_outlined, color: Colors.white, size: 18),
                        onTap: () async {
                          Get.back();
                          await Future.delayed(const Duration(milliseconds: 200));
                          cubit.changeIbtihalNum(ibtihalNumber);
                          cubit.clearIbtihalSearch();
                        },
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}


