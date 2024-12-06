import 'package:flutter/material.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:lnastaqim/core/constants/colors.dart';

class HijriMonthYear extends StatelessWidget {
  final HijriCalendar displayedMonth;
  final VoidCallback onPreviousMonth;
  final VoidCallback onNextMonth;

  const HijriMonthYear({
    super.key,
    required this.displayedMonth,
    required this.onPreviousMonth,
    required this.onNextMonth,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, bottom: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.chevron_left, color: AppColor.gray),
            onPressed: onPreviousMonth,
          ),
          Text(
            '${HijriMonths.getMonthName(displayedMonth.hMonth)} ${displayedMonth.hYear}',
            textDirection: TextDirection.rtl,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w400,
              color: AppColor.primary,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.chevron_right, color: AppColor.gray),
            onPressed: onNextMonth,
          ),
        ],
      ),
    );
  }
}

class HijriMonths {
  static const Map<int, String> names = {
    1: 'محرم',
    2: 'صفر',
    3: 'ربيع الأول',
    4: 'ربيع الثاني',
    5: 'جمادى الأولى',
    6: 'جمادى الآخرة',
    7: 'رجب',
    8: 'شعبان',
    9: 'رمضان',
    10: 'شوال',
    11: 'ذو القعدة',
    12: 'ذو الحجة',
  };

  static String getMonthName(int month) {
    return names[month] ?? '';
  }
}