import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lnastaqim/core/utilits/extensions/color_from_hex.dart';

import '../../../../core/constants/colors.dart';
import '../../logic/surah_player_cubit/surah_player_cubit.dart';
import '../../logic/surah_player_cubit/surah_player_state.dart';

class SurahSliderWidget extends StatelessWidget {
  const SurahSliderWidget({super.key});

  @override
  Widget build(BuildContext context) {


    return BlocBuilder<SurahPlayerCubit, SurahPlayerState>(
      builder: (context, state) {
        // if (state.surahDuration <= 0) {
        //   return const Text(
        //     "Loading audio duration...",
        //     style: TextStyle(color: Colors.grey),
        //   );
        // }

        return SizedBox(
          width: Get.width - 27,
          child: Column(
            children: [
              Slider(
                  activeColor: AppColor.lightBlue,
                thumbColor: AppColor.lightBlue,
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
              padding:  EdgeInsets.only(left: 8.6.w,right: 4.5.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // الوقت الذي مضى
                  Text(
                    SurahPlayerCubit.formatDuration(state.currentPosition.toInt()),
                    style: const TextStyle(color: Colors.grey),
                  ),
                  // الوقت الكلي
                  Text(
                    SurahPlayerCubit.formatDuration(state.surahDuration.toInt()),
                    style: const TextStyle(color: Colors.grey),
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
