import 'package:hijri/hijri_calendar.dart';

class HijriUtils {
  static HijriCalendar createHijriDate({
    required int year,
    required int month,
    required int day,
  }) {
    final hijri = HijriCalendar();
    hijri.hYear = year;
    hijri.hMonth = month;
    hijri.hDay = day;
    return hijri;
  }

  static int getDaysInMonth(int year, int month, int day) {
    final hijri = createHijriDate(year: year, month: month, day: day);
    return hijri.getDaysInMonth(year, month);
  }

  static int getWeekDay(int year, int month, int day) {
    final hijri = createHijriDate(year: year, month: month, day: day);
    return hijri.weekDay();
  }
}