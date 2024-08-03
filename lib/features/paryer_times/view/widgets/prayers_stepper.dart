import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lnastaqim/features/paryer_times/bussniess_logic/prayers_times_cubit.dart';
import 'package:lnastaqim/features/paryer_times/data/models/prayers_time_model.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class PrayersStepper extends StatelessWidget {
  final PrayersTimeModel prayerTimesModel;
  const PrayersStepper({super.key, required this.prayerTimesModel});

  static TimeOfDay parseTime(String time) {
    final period = time.endsWith('AM') ? 'AM' : 'PM';
    final timeWithoutPeriod = time.replaceAll(period, '');
    final timeParts = timeWithoutPeriod.split(':');

    int hour = int.parse(timeParts[0].trim());
    final int minute = int.parse(timeParts[1].trim());

    if (period == 'PM' && hour != 12) {
      hour += 12;
    } else if (period == 'AM' && hour == 12) {
      hour = 0;
    }

    return TimeOfDay(hour: hour, minute: minute);
  }

  static bool isTimeEqual(TimeOfDay time1, TimeOfDay time2) {
    return time1.hour == time2.hour && time1.minute == time2.minute;
  }

  @override
  Widget build(BuildContext context) {
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Africa/Cairo'));
    var currentTimeZone = tz.TZDateTime.now(tz.local);
    var currentTimeOfDay =
        TimeOfDay(hour: currentTimeZone.hour, minute: currentTimeZone.minute);
    var fajrTime = parseTime(prayerTimesModel.fajr);
    var dhuhrTime = parseTime(prayerTimesModel.dhuhr);
    var asrTime = parseTime(prayerTimesModel.asr);
    var maghribTime = parseTime(prayerTimesModel.maghrib);
    var ishaTime = parseTime(prayerTimesModel.isha);
    return Row(
      children: [
        IconButton(
            onPressed: () {
              log(dhuhrTime.minute.toString());
            },
            icon: const Icon(Icons.chevron_left)),

        // StepperItem(
        //   isFirst: true,
        //   title: 'الفجر',
        //   time: prayerTimesModel.fajr,
        //   myIndex: 1,
        // ),
        // StepperItem(
        //   title: 'الظهر',
        //   time: prayerTimesModel.dhuhr,
        //   myIndex: 3,
        // ),
        // StepperItem(
        //   title: 'العصر',
        //   time: prayerTimesModel.asr,
        //   myIndex: 4,
        // ),
        // StepperItem(
        //   title: 'المغرب',
        //   time: prayerTimesModel.maghrib,
        //   myIndex: 5,
        // ),
        // StepperItem(
        //   isLast: true,
        //   title: 'العشاء',
        //   time: prayerTimesModel.isha,
        //   myIndex: 6,
        // ),
      ],
    );
  }
}

class StepperItem extends StatelessWidget {
  final String title;
  final String time;
  final bool isFirst;
  final bool isLast;
  final int myIndex;
  const StepperItem(
      {super.key,
      required this.title,
      required this.time,
      this.isFirst = false,
      this.isLast = false,
      required this.myIndex});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(title),
          Text(time),
          const SizedBox(height: 10),
          Row(
            children: [
              isFirst
                  ? const Expanded(child: SizedBox())
                  : Line(
                      isChecked: BlocProvider.of<PrayersTimesCubit>(context)
                              .prayerTimesModel
                              .currentPrayer!
                              .index! >=
                          myIndex),
              Step(
                  isChecked: BlocProvider.of<PrayersTimesCubit>(context)
                          .prayerTimesModel
                          .currentPrayer!
                          .index! >=
                      myIndex),
              isLast
                  ? const Expanded(child: SizedBox())
                  : Line(
                      isChecked: BlocProvider.of<PrayersTimesCubit>(context)
                              .prayerTimesModel
                              .currentPrayer!
                              .index! >=
                          myIndex + 1),
            ],
          ),
          const SizedBox(height: 10),
          const Icon(Icons.wb_sunny_outlined)
        ],
      ),
    );
  }
}

class Line extends StatelessWidget {
  final bool isChecked;
  const Line({super.key, this.isChecked = false});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
      height: 2,
      color: isChecked ? Colors.orange : Colors.grey,
    ));
  }
}

class Step extends StatelessWidget {
  final bool isChecked;
  const Step({super.key, this.isChecked = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: isChecked ? Colors.orange : null,
          border: Border.all(
            color: Colors.orange,
            width: 2,
          )),
      child: isChecked
          ? const Icon(
              Icons.check,
              color: Colors.white,
            )
          : null,
    );
  }
}
