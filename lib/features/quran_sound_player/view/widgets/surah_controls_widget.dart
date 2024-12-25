import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/constants/animations.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/utilits/services/local_notification_service.dart';
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
                Icons.shuffle,color: AppColor.white,),
              onPressed: () {
                context.read<SurahPlayerCubit>().playRandomSurah();
              },
            ),
            SizedBox(width: 23.w,),
            Container(decoration: BoxDecoration(shape: BoxShape.circle,border: Border.all(width: 0.9,color: AppColor.white)),
              child: IconButton(
                icon:  Icon(Icons.skip_next,color: AppColor.white,),
                onPressed: () {
                  context.read<SurahPlayerCubit>().previousSurah();
                },
              ),
            ),
                        SizedBox(width: 25.w,),
    
            BlocBuilder<SurahPlayerCubit, SurahPlayerState>(
              builder: (context, state) {
                return CircleAvatar(
                  radius: 35,
                  backgroundColor: AppColor.white,
                  child:state.audioState is AudioFetchLoading
                                            ? Lottie.asset(
         AppAnimation.typeLoading, // مسار ملف Lottie الخاص بك
          width: 41.w, // حجم الرسوم المتحركة
          height: 50.h,
          fit: BoxFit.contain,
          repeat: true,
          animate: true,
    
        )
                                            :  IconButton(color: AppColor.blueColor,
                    icon: state.isPlaying
                        ? const Icon(Icons.pause,size: 35,)
                        : const Icon(Icons.play_arrow,size: 37,),
                    onPressed: () {
                      context.read<SurahPlayerCubit>().togglePlayPause();
                      LocalNotificationService.showMediaNotification();
                    },
                  ),
                );
              },
            ),
                        SizedBox(width: 25.w,),
    
            Container(decoration: BoxDecoration(shape: BoxShape.circle,border: Border.all(width: 0.9,color: AppColor.white)),
              child: IconButton(
                icon:  Icon(Icons.skip_previous,color: AppColor.white,),
                onPressed: () {
                  context.read<SurahPlayerCubit>().nextSurah();
                },
              ),
            ),
                        SizedBox(width: 24.w,),
    
             BlocBuilder<SurahPlayerCubit, SurahPlayerState>(
              builder: (context, state) {
                return IconButton(
                  icon: Icon(size: 27,
                    Icons.repeat,
                    color: state.onRepeat ? Colors.teal :AppColor.white,
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
    SizedBox(height: 11.h,),
    
        Padding(
                padding:  EdgeInsets.only(left: 19.w,right: 12.w),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            
            children: [
              IconButton(
                icon:  const Icon(size: 20,
                  Icons.download_outlined,color:  Colors.white54,),
                onPressed: () {
                  context.read<SurahPlayerCubit>().downloadSurah();
                },
              ),IconButton(
                icon:  const Icon(size: 20,
                  Icons.share_outlined,color: Colors.white54,),
                onPressed: () {
                  context.read<SurahPlayerCubit>().shareSurah();
                },
              ),
            ],),
        )
      ],
    );
  }
}
