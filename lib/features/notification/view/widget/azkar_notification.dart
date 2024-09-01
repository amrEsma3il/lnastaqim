import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/colors.dart';
import '../../bussiness_logic/notification_cubit.dart';
import '../../bussiness_logic/notification_state.dart';

class AzkarNotification extends StatelessWidget {
  const AzkarNotification({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
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
                value: context.read<NotificationCubit>().isAzkarNotification,
                onChanged: (value) {
                  context.read<NotificationCubit>().changeAzkarNotification();
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
    );
  }
}
