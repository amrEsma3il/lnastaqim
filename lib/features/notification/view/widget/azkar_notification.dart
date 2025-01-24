import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/colors.dart';
import '../../bussiness_logic/notification_cubit.dart';
import '../../bussiness_logic/notification_state.dart';
class AzkarNotification extends StatelessWidget {
  const AzkarNotification({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'الاذكار',
              style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.w800, color: AppColor.primary),
            ),
            const Spacer(),
            BlocBuilder<NotificationCubit, NotificationState>(
              builder: (context, state) {
                return Transform.scale(
                  scale: 0.8,
                  child: Switch(
                    value: state.morningAndEviningNotificationStatus,
                    onChanged: (value) async {
                  await    context.read<NotificationCubit>().changeAzkarNotificationStatus();
                    },
                    activeColor: AppColor.white,
                    activeTrackColor: AppColor.primary,
                    inactiveThumbColor: AppColor.white,
                    inactiveTrackColor: AppColor.gray,
                  ),
                );
              },
            ),
          ],
        ),
         SizedBox(height: 4.h),
      
          BlocBuilder<NotificationCubit, NotificationState>(
            builder: (context, state) {
              
              int? time = state.morningAndEviningNotificationFrequancy;
              return state.morningAndEviningNotificationStatus? Column(
                children: [
                  Text(
                    'مدة التكرار: ${time.toString()} دقائق',
                    style: const TextStyle(fontSize: 16, color: Colors.black),
                  ),
                  Slider(
                    min: 15,
                    max: 120,
                    divisions: 8,
                    activeColor: AppColor.blueTint2,
                    label: time.toString(),
                    value: (time.toDouble()),
                    onChanged: (double value) {
                    context.read<NotificationCubit>().onChangeSliderEvent(azkarNotificationFrequancy: value.toInt());
                    },
                    onChangeEnd: (double value) {
                      if (state.morningAndEviningNotificationStatus) {
     context.read<NotificationCubit>().changeAzkarNotificationFrequancy(value.toInt());
                      }
                    },
                  ),
                ],
              ):const SizedBox.shrink();
            },
          ),
        
      ],
    );
  }
}
