import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
        return SizedBox(width: Get.width-27,
          child: Slider(activeColor:  AppColor.lightBlue,
            thumbColor: AppColor.lightBlue,inactiveColor: "#6a738a".toColor,
            
            value: state.currentPosition,
            max: state.surahDuration,
            onChanged: (value) {
              context.read<SurahPlayerCubit>().seek(value);
            },
          ),
        );
      },
    );
  }
}
