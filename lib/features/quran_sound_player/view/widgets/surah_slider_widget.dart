import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lnastaqim/core/utilits/extensions/color_from_hex.dart';
import 'package:lnastaqim/core/utilits/extensions/double_int_parser_extension.dart';

import '../../../../core/constants/colors.dart';
import '../../logic/surah_player_cubit/surah_player_cubit.dart';
import '../../logic/surah_player_cubit/surah_player_state.dart';

class SurahSliderWidget extends StatelessWidget {
  const SurahSliderWidget({super.key});

  @override
  Widget build(BuildContext context) {

    final cubit = SurahPlayerCubit.get(context);

    return BlocBuilder<SurahPlayerCubit, SurahPlayerState>(
      builder: (context, state) {
        // if (state.surahDuration <= 0) {
        //   return const Text(
        //     "Loading audio duration...",
        //     style: TextStyle(color: Colors.grey),
        //   );
        // }

        return SizedBox(
          width: Get.width ,
          child: Column(crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding:  EdgeInsets.only(left: 20.w,right: 21.w),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                        InkWell(
      onTap: ()async {
        await showAudioSpeedMenu(context,cubit);
      },
      child: BlocBuilder<SurahPlayerCubit, SurahPlayerState>(
                              builder: (context, state) {
                                return RichText(
  text: TextSpan(
    text: state.audioSpeed.parseInt, // The larger number
    style: TextStyle(
      fontSize: 23.sp, // Larger font size for the number
      color: Colors.white,
      fontWeight: FontWeight.w400,
    ),
    children: [
      TextSpan(
        text: "x", // The smaller "x"
        style: TextStyle(
          fontSize: 17.5.sp, // Smaller font size for "x"
          color: Colors.white,
          fontWeight: FontWeight.w400,
        ),
      ),
    ],
  ),
);
                              },
                            ),
    ),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                              
                              
                              //////////
                                BlocBuilder<SurahPlayerCubit, SurahPlayerState>(
                                builder: (context, state) {
                    return Text(
                      SurahPlayerCubit.quranSurahs[state.surahNumber]
                          .toString(),
                      style: TextStyle(
                          fontSize: 17.sp,
                          color: AppColor.white,
                          fontWeight: FontWeight.bold),
                    );
                                },
                              ),
                              //  SizedBox(height: 2.h),
                              
                          BlocBuilder<SurahPlayerCubit, SurahPlayerState>(
                            builder: (context, state) {
                              return Text(
                                state.reciter.nameArabic,
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    color: Colors.white70,
                                    fontWeight: FontWeight.w400),
                              );
                            },
                          ),
                          
                    ],),


                  ],
                ),
              ),
              Slider(
                  activeColor: AppColor.white,
                thumbColor: AppColor.white,
                inactiveColor: "#6a738a".toColor,
                value: state.currentPosition,
                max: state.surahDuration <= 0 ? 149.0 : state.surahDuration,
                onChangeStart: (_) {
                       context.read<SurahPlayerCubit>().sliderSeekToggle(isSeeking: true);
              
                },
                onChanged: (value) {
                  context.read<SurahPlayerCubit>().changeAudioPosition(value);
                },
                onChangeEnd: (value) {
                  print("end");
                  context.read<SurahPlayerCubit>().seek(value);
                },
              ),
          
            Padding(
              padding:  EdgeInsets.only(left:23.w,right: 20.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // الوقت الذي مضى
                  Text(
                    SurahPlayerCubit.formatDuration(state.currentPosition.toInt()),
                    style: const TextStyle(color: Colors.white60),
                  ),
                  // الوقت الكلي
                  Text(
                    SurahPlayerCubit.formatDuration(state.surahDuration.toInt()),
                    style: const TextStyle(color: Colors.white60),
                  ),
                ],
              ),
            )
            ],
          )
,
        );
      },
    );
  }
}















  Future showAudioSpeedMenu(BuildContext context, SurahPlayerCubit cubit) async {
    return await showMenu(
      shadowColor: Colors.black,
      context: context,
      position: const RelativeRect.fromLTRB(300, 425, 20, 10),
      items: SurahPlayerCubit.audioSpeedRates.map((rate) {
        return PopupMenuItem(
          value:rate ,
          child: RichText(
  text: TextSpan(
    text: rate.parseInt, // The larger number
    style: TextStyle(
      fontSize: 23.sp, // Larger font size for the number
      color: Colors.white,
      fontWeight: FontWeight.w400,
    ),
    children: [
      TextSpan(
        text: "x", // The smaller "x"
        style: TextStyle(
          fontSize: 17.5.sp, // Smaller font size for "x"
          color: Colors.white,
          fontWeight: FontWeight.w400,
        ),
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
        log("from menu$selectedValue");
        cubit.setPlaybackRate(selectedValue);
      }
    });
  }
