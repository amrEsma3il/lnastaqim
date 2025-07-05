import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lnastaqim/core/utilits/extensions/arabic_numbers.dart';

import '../../../../../core/constants/colors.dart';
import '../../../paryer_times/bussniess_logic/prayers_times_cubit.dart';
import '../../../paryer_times/data/models/prayers_time_model.dart';
import '../../bussiness_logic/notification_cubit.dart';
import '../../bussiness_logic/notification_state.dart';
import '../../data/repo/notification_repo.dart';

class ParyerTimeNotificationComponent extends StatelessWidget {
  final String prayerName;
  final Future<void> Function() submitMethod;
  const ParyerTimeNotificationComponent({
    super.key,
    required this.prayerName,
    required this.submitMethod,
  });

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
                  "صلاة $prayerName",
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w800,
                    color: AppColor.primary,
                  ),
                ),
                SizedBox(width: 4.w),
                // GestureDetector(
                  // onTap: () {
                  //   // context.read<NotificationCubit>().changeSoundSalahNabi(sound: "azan2");

                  //   showDialog(
                  //     context: context,
                  //     builder:
                  //         (context) => RadioDialog(
                  //           prayerName: prayerName,
                  //           submitMethod: submitMethod,
                  //         ),
                  //   );
                  // },
                  // child: 
                  BlocBuilder<NotificationCubit, NotificationState>(
                    builder: (context, state) {
                      // late String prayerSound;
                      // late bool prayerStatus;

                      // switch (prayerName) {
                      //   case "الفجر":
                      //     prayerSound = state.fajarAlarmSound;
                      //     prayerStatus = state.fajarAlarmStatus;
                      //     break;
                      //   case "الظهر":
                      //     prayerSound = state.duharAlarmSound;
                      //     prayerStatus = state.duharAlarmStatus;

                      //     break;
                      //   case "العصر":
                      //     prayerSound = state.asrAlarmSound;
                      //     prayerStatus = state.asrAlarmStatus;

                      //     break;
                      //   case "المغرب":
                      //     prayerSound = state.maghribAlarmSound;
                      //     prayerStatus = state.maghribAlarmStatus;

                      //     break;
                      //   case "العشاء":
                      //     prayerSound = state.ishaAlarmSound;
                      //     prayerStatus = state.ishaAlarmStatus;

                      //     break;
                      // }

                      return (prayerName == "الفجر"
                              ? state.fajarAlarmStatus
                              : prayerName == "الظهر"
                              ? state.duharAlarmStatus
                              : prayerName == "العصر"
                              ? state.asrAlarmStatus
                              : prayerName == "المغرب"
                              ? state.maghribAlarmStatus
                              : prayerName == "العشاء"
                              ? state.ishaAlarmStatus
                              : false)
                          ? Text(
                            "( ${prayerName == "الفجر"
                                ? state.fajarAlarmSound
                                : prayerName == "الظهر"
                                ? state.duharAlarmSound
                                : prayerName == "العصر"
                                ? state.asrAlarmSound
                                : prayerName == "المغرب"
                                ? state.maghribAlarmSound
                                : prayerName == "العشاء"
                                ? state.ishaAlarmSound
                                : ""} )",
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColor.gray,
                            ),
                          )
                          : const SizedBox.shrink();
                    },
                  ),
                // ),
              ],
            ),
            const Spacer(),
            Row(
              children: [
                BlocBuilder<PrayersTimesCubit, PrayersTimeModel>(
                  builder: (context, state) {
                    // late String prayerTime;

                    // switch (prayerName) {
                    //   case "الفجر":
                    //     prayerTime = state.fajr.toArabic;
                    //     break;
                    //   case "الظهر":
                    //     prayerTime = state.dhuhr.toArabic;

                    //     break;
                    //   case "العصر":
                    //     prayerTime = state.asr.toArabic;

                    //     break;
                    //   case "المغرب":
                    //     prayerTime = state.maghrib.toArabic;

                    //     break;
                    //   case "العشاء":
                    //     prayerTime = state.isha.toArabic;

                    //     break;

                    // }

                    return Text(
                      prayerName == "الفجر"
                          ? state.fajr.toArabic
                          : prayerName == "الظهر"
                          ? state.dhuhr.toArabic
                          : prayerName == "العصر"
                          ? state.asr.toArabic
                          : prayerName == "المغرب"
                          ? state.maghrib.toArabic
                          : prayerName == "العشاء"
                          ? state.isha.toArabic
                          : "",
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColor.gray,
                      ),
                    );
                  },
                ),
                SizedBox(width: 8.w),
                BlocBuilder<NotificationCubit, NotificationState>(
                  builder: (context, state) {
                    // late bool prayerStatus;

                    // switch (prayerName) {
                    //   case "الفجر":
                    //     prayerStatus = state.fajarAlarmStatus;
                    //     break;
                    //   case "الظهر":
                    //     prayerStatus = state.duharAlarmStatus;

                    //     break;
                    //   case "العصر":
                    //     prayerStatus = state.asrAlarmStatus;

                    //     break;
                    //   case "المغرب":
                    //     prayerStatus = state.maghribAlarmStatus;

                    //     break;
                    //   case "العشاء":
                    //     prayerStatus = state.ishaAlarmStatus;

                    //     break;

                    // }

                    return Transform.scale(
                      scale: 0.8,
                      child: Switch(
                        value:
                            prayerName == "الفجر"
                                ? state.fajarAlarmStatus
                                : prayerName == "الظهر"
                                ? state.duharAlarmStatus
                                : prayerName == "العصر"
                                ? state.asrAlarmStatus
                                : prayerName == "المغرب"
                                ? state.maghribAlarmStatus
                                : prayerName == "العشاء"
                                ? state.ishaAlarmStatus
                                : false,
                        onChanged: (value) async {
                          switch (prayerName) {
                            case "الفجر":
                              await context
                                  .read<NotificationCubit>()
                                  .changeFajrParyerNotificationStatus();
                              break;
                            case "الظهر":
                              await context
                                  .read<NotificationCubit>()
                                  .changeDuharParyerNotificationStatus();
                              break;
                            case "العصر":
                              await context
                                  .read<NotificationCubit>()
                                  .changeAsrParyerNotificationStatus();
                              break;
                            case "المغرب":
                              await context
                                  .read<NotificationCubit>()
                                  .changeMaghribParyerNotificationStatus();
                              break;
                            case "العشاء":
                              await context
                                  .read<NotificationCubit>()
                                  .changeIshaParyerNotificationStatus();
                              break;
                          }
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
          ],
        ),
      ],
    );
  }
}

class RadioDialog extends StatelessWidget {
  const RadioDialog({
    super.key,
    required this.submitMethod,
    required this.prayerName,
  });
  final Future<void> Function() submitMethod;
  final String prayerName;
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
                SizedBox(
                  height: prayerName == "الفجر" ? 160.h : 400.h,
                  child: ListView.builder(
                    itemCount: prayerName == "الفجر" ? 3 : 7,
                    itemBuilder: (context, index) {
                      // late String groupKey;
                      // switch (prayerName) {
                      //   case "الفجر":
                      //     groupKey = state.fajarAlarmSound;
                      //     break;
                      //   case "الظهر":
                      //     groupKey = state.duharAlarmSound;
                      //     break;
                      //   case "العصر":
                      //     groupKey = state.asrAlarmSound;
                      //     break;
                      //   case "المغرب":
                      //     groupKey = state.maghribAlarmSound;
                      //     break;
                      //   case "العشاء":
                      //     groupKey = state.ishaAlarmSound;
                      //     break;
                      // }

                      List<Map<String, dynamic>> radioTileList =
                          NotificationRepo.radioTileList(prayerName);

                      Map<String, dynamic> radioTile = radioTileList[index];

                      return RadioListTile<String>(
                        title: Text(radioTile['title'] as String),
                        value: radioTile["value"] as String,
                        groupValue:
                            prayerName == "الفجر"
                                ? state.fajarAlarmSound
                                : prayerName == "الظهر"
                                ? state.duharAlarmSound
                                : prayerName == "العصر"
                                ? state.asrAlarmSound
                                : prayerName == "المغرب"
                                ? state.maghribAlarmSound
                                : prayerName == "العشاء"
                                ? state.ishaAlarmSound
                                : "",
                        onChanged: radioTile["onChanged"],
                      );
                    },
                  ),
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
                      onPressed: () async {
                        if (context.mounted) {
                          await context
                              .read<NotificationCubit>()
                              .stopAlarmSound();
                        }
                        Get.back(); // Close dialog
                      },
                      child: Text(
                        'الغاء',
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColor.white,
                        ),
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
                        await submitMethod();
                        if (context.mounted) {
                          await context
                              .read<NotificationCubit>()
                              .stopAlarmSound();
                        }
                        Get.back(); // Return selected value
                      },
                      child: Text(
                        'موافق',
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColor.white,
                        ),
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

class RadioTileComponent extends StatelessWidget {
  final String title;
  final String value;
  final String groupValue;
  final ValueChanged<String?> onChanged;

  const RadioTileComponent({
    super.key,
    required this.title,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return RadioListTile<String>(
      title: Text(title),
      value: value,
      groupValue: groupValue,
      onChanged: onChanged,
    );
  }
}

// String soundSelect(String paryerName){

// late String sound;

// switch (paryerName) {
//   case "الفجر":
//     sound=
//     break;
//   default:
// }
// return sound;
// }
