import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:lnastaqim/core/constants/colors.dart';
import 'package:lnastaqim/features/calender/view/widgets/calender_days_name.dart';
import 'package:lnastaqim/features/calender/view/widgets/hijri_calender_day.dart';
import 'package:lnastaqim/features/calender/view/widgets/hijri_month_year.dart';
import 'package:lnastaqim/features/calender/view/widgets/hijri_utils.dart';

class CustomHijriCalendar extends StatefulWidget {
  const CustomHijriCalendar({
    super.key,
    this.onDaySelected,
  });

  final Function(HijriCalendar)? onDaySelected;

  @override
  State<CustomHijriCalendar> createState() => _CustomHijriCalendarState();
}

class _CustomHijriCalendarState extends State<CustomHijriCalendar> {
  late HijriCalendar _selectedDay;
  late HijriCalendar _displayedMonth;

  @override
  void initState() {
    super.initState();
    _selectedDay = HijriCalendar.now();
    _displayedMonth = HijriUtils.createHijriDate(
      year: _selectedDay.hYear,
      month: _selectedDay.hMonth,
      day: 1,
    );
  }

  void _onDaySelected(HijriCalendar date) {
    setState(() {
      _selectedDay = date;
    });
    if (widget.onDaySelected != null) {
      widget.onDaySelected!(date);
    }
  }

  List<HijriCalendar> _getDaysInMonth() {
    List<HijriCalendar> days = [];
    int daysInMonth = HijriUtils.getDaysInMonth(
        _displayedMonth.hYear, _displayedMonth.hMonth, _displayedMonth.hDay);

    for (int i = 1; i <= daysInMonth; i++) {
      days.add(HijriUtils.createHijriDate(
        year: _displayedMonth.hYear,
        month: _displayedMonth.hMonth,
        day: i,
      ));
    }

    return days;
  }

  void _previousMonth() {
    setState(() {
      if (_displayedMonth.hMonth == 1) {
        _displayedMonth = HijriUtils.createHijriDate(
          year: _displayedMonth.hYear - 1,
          month: 12,
          day: 1,
        );
      } else {
        _displayedMonth = HijriUtils.createHijriDate(
          year: _displayedMonth.hYear,
          month: _displayedMonth.hMonth - 1,
          day: 1,
        );
      }
    });
  }

  void _nextMonth() {
    setState(() {
      if (_displayedMonth.hMonth == 12) {
        _displayedMonth = HijriUtils.createHijriDate(
          year: _displayedMonth.hYear + 1,
          month: 1,
          day: 1,
        );
      } else {
        _displayedMonth = HijriUtils.createHijriDate(
          year: _displayedMonth.hYear,
          month: _displayedMonth.hMonth + 1,
          day: 1,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final days = _getDaysInMonth();
    final firstDayWeekday = HijriUtils.getWeekDay(
      _displayedMonth.hYear,
      _displayedMonth.hMonth,
      1,
    );
    final now = HijriCalendar.now();

    return Container(
      height: 342.h,
      margin: const EdgeInsets.all(15),
      decoration: ShapeDecoration(
        color: AppColor.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      clipBehavior: Clip.none,
      child: Column(
        children: [
          HijriMonthYear(
            displayedMonth: _displayedMonth,
            onPreviousMonth: _previousMonth,
            onNextMonth: _nextMonth,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(7, (index) {
                final date = DateTime(
                    DateTime.now().year, DateTime.now().month, index + 1);
                return SizedBox(
                  width: 40,
                  child: Text(
                    calenderDaysName(date, 'ar'),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                );
              }),
            ),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 7,
                  childAspectRatio: 3 / 2.5,
                  crossAxisSpacing: 6,
                  mainAxisSpacing: 0),
              itemCount: days.length + firstDayWeekday - 1,
              itemBuilder: (context, index) {
                if (index < firstDayWeekday - 1) {
                  return const SizedBox();
                }

                final dayIndex = index - (firstDayWeekday - 1);
                if (dayIndex >= days.length) {
                  return const SizedBox();
                }

                final day = days[dayIndex];
                final isSelected = day.hDay == _selectedDay.hDay &&
                    day.hMonth == _selectedDay.hMonth &&
                    day.hYear == _selectedDay.hYear;
                final isToday = day.hDay == now.hDay + 1 &&
                    day.hMonth == now.hMonth &&
                    day.hYear == now.hYear;

                return HijriCalendarDay(
                  day: day,
                  isSelected: isSelected,
                  isToday: isToday,
                  onTap: () => _onDaySelected(day),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
