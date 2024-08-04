import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lnastaqim/core/utilits/extensions/arabic_numbers.dart';
import 'package:lnastaqim/features/paryer_times/bussniess_logic/prayers_times_cubit.dart';

import '../../../../core/constants/colors.dart';
import '../../data/models/prayers_time_model.dart';

class PrayersStepper extends StatelessWidget {
  const PrayersStepper({super.key});

  @override
  Widget build(BuildContext context) {
    // final cubit=BlocProvider.of<PrayersTimesCubit>(context);
    return BlocBuilder<PrayersTimesCubit, PrayersTimeModel>(
      builder: (context, paryerState) {
        return Row(
          children: [
            StepperItem(
              isFirst: true,
              title: 'الفجر',
              time: paryerState.fajr.toArabic,
              myIndex: 1,
            ),
            StepperItem(
              title: 'الظهر',
              time: paryerState.dhuhr.toArabic,
              myIndex: 3,
            ),
            StepperItem(
              title: 'العصر',
              time: paryerState.asr.toArabic,
              myIndex: 4,
            ),
            StepperItem(
              title: 'المغرب',
              time: paryerState.maghrib.toArabic,
              myIndex: 5,
            ),
            StepperItem(
              isLast: true,
              title: 'العشاء',
              time: paryerState.isha.toArabic,
              myIndex: 6,
            ),
          ],
        );
      },
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
        BlocBuilder<PrayersTimesCubit, PrayersTimeModel>(
            builder: (context, paryerState) {
              return Row(
                children: [
                  isFirst
                      ? const Expanded(child: SizedBox())
                      : Line(
                          isChecked:
                              paryerState.currentPrayer!.index! >= myIndex),
                  Step(isChecked: paryerState.currentPrayer!.index! >= myIndex),
                  isLast
                      ? const Expanded(child: SizedBox())
                      : Line(
                          isChecked:
                              paryerState.currentPrayer!.index! >= myIndex + 1),
                ],
              );
            },
          ),
          const SizedBox(height: 10),
           Icon(paryerIcon(myIndex==1?0:myIndex-2))
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
      height: 1.1,
      color: isChecked ? AppColor.blueColor : Colors.grey,
    ));
  }
}

class Step extends StatelessWidget {
  final bool isChecked;
  const Step({super.key, this.isChecked = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 17,
      height: 17,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: isChecked ? AppColor.blueColor : null,
          border: Border.all(
            color: AppColor.blueColor,
            width: 2,
          )),
      child: isChecked
          ? const Icon(
              Icons.check,
              color: Colors.white,
              size: 11,
            )
          : null,
    );
  }
}


IconData paryerIcon(int index){
  List<IconData> icons=[Icons.sunny_snowing, Icons.sunny,Icons.sunny,Icons.nights_stay_outlined,Icons.nightlight_outlined];

  return icons[index];

}