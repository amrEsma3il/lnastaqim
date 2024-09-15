import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: AppColor.primary),
            ),
            const Spacer(),
            BlocBuilder<NotificationCubit, NotificationState>(
              builder: (context, state) {
                return Transform.scale(
                  scale: 0.8,
                  child: Switch(
                    value:
                        context.read<NotificationCubit>().isAzkarNotification,
                    onChanged: (value) {
                      context
                          .read<NotificationCubit>()
                          .changeAzkarNotification();
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
        const SizedBox(
          height: 10,
        ),

        if( context.read<NotificationCubit>().isAzkarNotification)...
    {    BlocBuilder<NotificationCubit, NotificationState>(
          builder: (context, state) {
          int?  time= state is ChangeNotificationTime? state.durationInMinutes:null; 
            return Slider(
              min: 15,
              max: 240,
              divisions: 12,
              label: time.toString(),
              value:(time??15).toDouble(),
              onChanged: (double value) {
           NotificationCubit.get(context).changeNotificationTime(value.toInt());
              },
              onChangeEnd: (double value) {
                // Reschedule the task with the updated duration
                if ( context.read<NotificationCubit>().isAzkarNotification) {
                  NotificationCubit.get(context).reScheduleNotification(value.toInt());
                }
              },
            );
          },
        ),}
        // Text("Task will run every ${state.} minutes."),
      ],
    );
  }
}
