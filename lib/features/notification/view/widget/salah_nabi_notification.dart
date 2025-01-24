import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../core/constants/colors.dart';
import '../../bussiness_logic/notification_cubit.dart';
import '../../bussiness_logic/notification_state.dart';

class SalahNabiNotification extends StatelessWidget {
  const SalahNabiNotification({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'صلي علي محمد',
                  style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w800,
                      color: AppColor.primary),
                ),
                SizedBox(
                  width: 4.w,
                ),
               GestureDetector(
                      onTap: () {
                        // context.read<NotificationCubit>().changeSoundSalahNabi(sound: "azan2");

                        showDialog(
                          context: context,
                          builder: (context) => const RadioDialog(),
                        );
                      },
                      child: BlocBuilder<NotificationCubit, NotificationState>(
                        builder: (context, state) {
                          return state.salahNabiNotificationStatus? Text(
                            "( ${state.salahNabiNotificationSound} )",
                            style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                                color: AppColor.gray),
                          ):const SizedBox.shrink();
                        },
                      ),
                    ),
              ],
            ),
            const Spacer(),
            BlocBuilder<NotificationCubit, NotificationState>(
              builder: (context, state) {
                return Transform.scale(
                  scale: 0.8,
                  child: Switch(
                    value: state.salahNabiNotificationStatus,
                    onChanged: (value) async {
                      await context
                          .read<NotificationCubit>()
                          .changeSalahNabiNotificationStatus();
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
            int? time = state.salahNabiNotificationFrequancy;
            return state.salahNabiNotificationStatus
                ? Column(
                    children: [
                      Text(
                        'مدة التكرار: ${time.toString()} دقائق',
                        style:
                            const TextStyle(fontSize: 16, color: Colors.black),
                      ),
                      Slider(
                        min: 15,
                        max: 6 * 60,
                        divisions: 12,
                        activeColor: AppColor.blueTint2,
                        label: time.toString(),
                        value: (time.toDouble()),
                        onChanged: (double value) {
                          context.read<NotificationCubit>().onChangeSliderEvent(
                              salahNabiNotificationFrequancy: value.toInt());
                        },
                        onChangeEnd: (double value) {
                          if (state.salahNabiNotificationStatus) {
                            context
                                .read<NotificationCubit>()
                                .changeSalahNabiNotificationFrequancy(
                                    value.toInt());
                          }
                        },
                      ),
                    ],
                  )
                : const SizedBox.shrink();
          },
        ),
      ],
    );
  }
}

class RadioDialog extends StatelessWidget {
  const RadioDialog({super.key});

  // Stores the selected value

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20), // Rounded corners
      ),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        padding: const EdgeInsets.all(20),
        // decoration: BoxDecoration(
        //   color: Colors.blue.shade50, // Light blue background
        //   borderRadius: BorderRadius.circular(20),
        // ),
        child: BlocBuilder<NotificationCubit, NotificationState>(
          builder: (context, state) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Title
                Text(
                  "اختر الصوت",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColor.primary,
                  ),
                ),
                const SizedBox(height: 20),

                // Radio buttons
                RadioListTile<String>(
                  title: const Text("صلي علي محمد"),
                  value: "صلي علي محمد",
                  groupValue: state.salahNabiNotificationSound,
                  onChanged: (value) async {
                    context
                        .read<NotificationCubit>()
                        .changeSoundState(salahNabiNotificationSound: value);

                          await context
                        .read<NotificationCubit>().playAlarmSound("salah_mohamed");
                  },
                ),
                RadioListTile<String>(
                  title: const Text("صلي علي النبي"),
                  value: "صلي علي النبي",
                  groupValue: state.salahNabiNotificationSound,
                  onChanged: (value) async {
                    context
                        .read<NotificationCubit>()
                        .changeSoundState(salahNabiNotificationSound: value);

                          await context
                        .read<NotificationCubit>().playAlarmSound("salah_nabi");
                  },
                ),

                const SizedBox(height: 20),

                // Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () async{
                          if (context.mounted) {await    context
                        .read<NotificationCubit>().stopAlarmSound();}
                        Get.back(); // Close dialog
                      },
                      child: Text(
                        'الغاء',
                        style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColor.white),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () async {
                        await context
                            .read<NotificationCubit>()
                            .changeSoundSalahNabi();
                     if (context.mounted) {await    context
                        .read<NotificationCubit>().stopAlarmSound();}
                        Get.back(); // Return selected value
                      },
                      child: Text(
                        'موافق',
                        style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColor.white),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
