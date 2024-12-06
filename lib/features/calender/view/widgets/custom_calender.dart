import 'package:flutter/material.dart';
import 'package:lnastaqim/core/constants/colors.dart';
import 'package:table_calendar/table_calendar.dart';

import 'calender_days_name.dart';

class CustomCalender extends StatefulWidget {
  const CustomCalender({
    super.key,
    this.onDaySelected,
  });

  final Function(DateTime)? onDaySelected;

  @override
  State<CustomCalender> createState() => _CustomCalenderState();
}

class _CustomCalenderState extends State<CustomCalender> {
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 330,
        margin: const EdgeInsets.all(15),
        decoration: ShapeDecoration(
            color: AppColor.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16))),
        clipBehavior: Clip.none,
        padding: const EdgeInsets.symmetric(
          vertical: 25,
        ),
        child: TableCalendar(
          firstDay: DateTime.now(),
          lastDay: DateTime.utc(2050, 1, 1),
          focusedDay: _focusedDay,
          locale: "ar_EG",
          onPageChanged: (focusedDay) {
            setState(() {
              _focusedDay = focusedDay;
            });
          },
          headerStyle: HeaderStyle(
              leftChevronIcon: const Icon(
                Icons.chevron_left,
                color: AppColor.gray,
              ),
              leftChevronMargin: const EdgeInsets.only(right: 0),
              rightChevronIcon: const Icon(
                Icons.chevron_right,
                color: AppColor.gray,
              ),
              rightChevronMargin: const EdgeInsets.only(left: 0),
              headerPadding: const EdgeInsets.only(bottom: 30),
              titleTextStyle: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.w400,
                  color: AppColor.primary),
              formatButtonVisible: false,
              titleCentered: true),
          availableGestures: AvailableGestures.all,
          calendarFormat: CalendarFormat.month,
          daysOfWeekStyle: const DaysOfWeekStyle(
            dowTextFormatter: calenderDaysName,
            weekdayStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
            weekendStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
          ),
          rowHeight: 30,
          daysOfWeekHeight: 20,
          calendarStyle: CalendarStyle(
            cellMargin: const EdgeInsets.all(2.0),
            outsideTextStyle: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: AppColor.primary),
            isTodayHighlighted: true,
            selectedTextStyle: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: AppColor.black),
            todayTextStyle: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: AppColor.white),
            todayDecoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColor.primary,
            ),
          ),
          currentDay: _selectedDay,
          onDaySelected: (selectedDay, focusedDay) {
            setState(() {
              _selectedDay = selectedDay;
            });
            widget.onDaySelected!(selectedDay);
          },
        ));
  }
}
