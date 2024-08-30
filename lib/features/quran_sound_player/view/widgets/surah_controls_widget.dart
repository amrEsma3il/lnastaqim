import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/colors.dart';
import '../../logic/surah_player_cubit/surah_player_cubit.dart';
import '../../logic/surah_player_cubit/surah_player_state.dart';

class SurahControlsWidget extends StatelessWidget {
  const SurahControlsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
               IconButton(
              icon:  Icon(size: 25,
                Icons.shuffle,color: AppColor.lightBlue,),
              onPressed: () {
                context.read<SurahPlayerCubit>().playRandomSurah();
              },
            ),
            SizedBox(width: 11.w,),
            Container(decoration: BoxDecoration(shape: BoxShape.circle,border: Border.all(width: 0.9,color: AppColor.lightBlue)),
              child: IconButton(
                icon:  Icon(Icons.skip_next,color: AppColor.lightBlue,),
                onPressed: () {
                  context.read<SurahPlayerCubit>().previousSurah();
                },
              ),
            ),
                        SizedBox(width: 16.w,),

            BlocBuilder<SurahPlayerCubit, SurahPlayerState>(
              builder: (context, state) {
                return CircleAvatar(
                  radius: 27,
                  backgroundColor: AppColor.lightBlue,
                  child: IconButton(color: AppColor.blueColor,
                    icon: state.isPlaying
                        ? const Icon(Icons.pause_circle_outline)
                        : const Icon(Icons.play_arrow_outlined),
                    onPressed: () {
                      context.read<SurahPlayerCubit>().togglePlayPause();
                    },
                  ),
                );
              },
            ),
                        SizedBox(width: 16.w,),

            Container(decoration: BoxDecoration(shape: BoxShape.circle,border: Border.all(width: 0.9,color: AppColor.lightBlue)),
              child: IconButton(
                icon:  Icon(Icons.skip_previous,color: AppColor.lightBlue,),
                onPressed: () {
                  context.read<SurahPlayerCubit>().nextSurah();
                },
              ),
            ),
                        SizedBox(width: 12.w,),

             BlocBuilder<SurahPlayerCubit, SurahPlayerState>(
              builder: (context, state) {
                return IconButton(
                  icon: Icon(size: 27,
                    Icons.repeat,
                    color: state.maxRepeats > 0 ? Colors.teal :AppColor.lightBlue,
                  ),
                  onPressed: () {
                    context.read<SurahPlayerCubit>().toggleRepeat();
                  },
                );
              },
            ),
          ],
        ),
        // const SizedBox(height: 10),    const SizedBox(height: 10),
        // BlocBuilder<SurahPlayerCubit, SurahPlayerState>(
        //   builder: (context, state) {
        //     return Text(
        //       'Repeat: ${state.maxRepeats} time${state.maxRepeats > 1 ? 's' : ''}',
        //     );
        //   },
        // ),
      ],
    );
  }
}
