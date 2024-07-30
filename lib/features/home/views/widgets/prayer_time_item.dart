import 'package:flutter/material.dart';
import 'package:lnastaqim/core/constants/colors.dart';
import 'package:lnastaqim/features/home/data/models/prayer_time_model.dart';

class PrayerTimeItem extends StatelessWidget {
  const PrayerTimeItem({super.key, required this.prayerTimeModel});

  final PrayerTimeModel prayerTimeModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0),
      child: Column(
        children: [
          Text(prayerTimeModel.text),
          Text(prayerTimeModel.time),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Icon(
              Icons.check_circle,
              color: AppColor.primary,
              size: 17,
            ),
          ),
          Icon(
            prayerTimeModel.icon,
            color: AppColor.primary,
            size: 20,
          )
        ],
      ),
    );
  }
}
