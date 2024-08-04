 import '../models/hijri_date_model.dart';

class DateTimeService {
   
static String formatHijriDate(HijriDate hijriDate) {
    List<String> months = [
      "محرم",
      "صفر",
      "ربيع الأول",
      "ربيع الآخر",
      "جمادى الأولى",
      "جمادى الآخرة",
      "رجب",
      "شعبان",
      "رمضان",
      "شوال",
      "ذو القعدة",
      "ذو الحجة"
    ];



    return "${hijriDate.day} ${months[hijriDate.month - 1]} ${hijriDate.year} هجريا";
  }


 static String weekdaysNames(int weekday){
    List<String> weekdays = [
      "السبت",
      "الأحد",
      "الاثنين",
      "الثلاثاء",
      "الأربعاء",
      "الخميس",
      "الجمعة"
    ];
return weekdays[weekday % 7];
  }

 static   HijriDate gregorianToHijri(int year, int month, int day) {
    int jd = (1461 * (year + 4800 + (month - 14) ~/ 12)) ~/ 4 +
        (367 * (month - 2 - 12 * ((month - 14) ~/ 12))) ~/ 12 -
        (3 * ((year + 4900 + (month - 14) ~/ 12) ~/ 100)) ~/ 4 +
        day - 32075;

    int l = jd - 1948440 + 10632;
    int n = ((l - 1) ~/ 10631);
    l = l - 10631 * n + 354;
    int j = ((10985 - l) ~/ 5316) * ((50 * l) ~/ 17719) + ((l ~/ 5670) * ((43 * l) ~/ 15238));
    l = l - ((30 - j) ~/ 15) * ((17719 * j) ~/ 50) - ((j ~/ 16) * ((15238 * j) ~/ 43)) + 29;

     month = ((24 * l) ~/ 709);
     day = l - ((709 * month) ~/ 24);
     year = 30 * n + j - 30;

    // Adjust the day and month to match Um Al-Qura calendar
    int dayAdjust = 1;
    day += dayAdjust;
    if (day > 30) {
      day -= 30;
      month++;
    }
    if (month > 12) {
      month -= 12;
      year++;
    }

    return HijriDate(day: day, month: month, year: year);
  }

static String formatgreGorianDate(DateTime date) {
  // Array of month names in Arabic
  List<String> months = [
    "يناير", "فبراير", "مارس", "أبريل", "مايو", "يونيو",
    "يوليو", "أغسطس", "سبتمبر", "أكتوبر", "نوفمبر", "ديسمبر"
  ];

  // Get the day, month, and year
  String day = date.day.toString();
  String month = months[date.month - 1];
  String year = date.year.toString();

  // Combine them into the desired format
  return '$day $month $year';
}


 }
 
 


 