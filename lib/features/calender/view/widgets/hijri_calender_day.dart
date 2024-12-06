import 'package:flutter/material.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:lnastaqim/core/constants/colors.dart';

class HijriCalendarDay extends StatelessWidget {
  final HijriCalendar day;
  final bool isSelected;
  final bool isToday;
  final VoidCallback onTap;

  const HijriCalendarDay({
    super.key,
    required this.day,
    required this.isSelected,
    required this.isToday,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isToday ? AppColor.primary : Colors.transparent,
        ),
        child: Center(
          child: Text(
            '${day.hDay}',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: isToday ? AppColor.white : AppColor.black,
            ),
          ),
        ),
      ),
    );
  }
}
