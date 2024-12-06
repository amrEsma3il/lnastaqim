import 'package:intl/intl.dart';

String calenderDaysName(date, locale) {
  if (date.weekday == DateTime.sunday) {
    return 'الاحد';
  } else if (date.weekday == DateTime.monday) {
    return 'الاثنين';
  } else if (date.weekday == DateTime.tuesday) {
    return 'الثلاثاء';
  } else if (date.weekday == DateTime.wednesday) {
    return 'الأربعاء';
  } else if (date.weekday == DateTime.thursday) {
    return 'الخميس';
  } else if (date.weekday == DateTime.friday) {
    return 'الجمعة';
  } else if (date.weekday == DateTime.saturday) {
    return 'السبت';
  }
  return DateFormat.E(locale).format(date).toUpperCase();
}
