import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/models/quran_model.dart';
import '../../../data/repository/quran_repository.dart';
import '../quran_cubit.dart';

class IndexCubit extends Cubit<int> {
  IndexCubit() : super(0);

  static IndexCubit get(BuildContext context) =>
      BlocProvider.of<IndexCubit>(context);

static String hizbQuarterToFraction(int quarterNumber) {
  int remainder = quarterNumber % 4;
   int realNumber = quarterNumber ~/ 4;
  
  switch (remainder) {
    case 1:
      return (remainder+realNumber).toString(); // Start of a new Hizb
    case 2:
      return "1/4";
    case 3:
      return "1/2";
    case 0:
      return "3/4";
    default:
      return quarterNumber.toString(); // Just in case, though this should never be reached
  }
}



static String juzArabicWord(int number) {
  Map<int, String> numberMap = {
    1: 'الأول',
    2: 'الثاني',
    3: 'الثالث',
    4: 'الرابع',
    5: 'الخامس',
    6: 'السادس',
    7: 'السابع',
    8: 'الثامن',
    9: 'التاسع',
    10: 'العاشر',
    11: 'الحادي عشر',
    12: 'الثاني عشر',
    13: 'الثالث عشر',
    14: 'الرابع عشر',
    15: 'الخامس عشر',
    16: 'السادس عشر',
    17: 'السابع عشر',
    18: 'الثامن عشر',
    19: 'التاسع عشر',
    20: 'العشرون',
    21: 'الحادي والعشرون',
    22: 'الثاني والعشرون',
    23: 'الثالث والعشرون',
    24: 'الرابع والعشرون',
    25: 'الخامس والعشرون',
    26: 'السادس والعشرون',
    27: 'السابع والعشرون',
    28: 'الثامن والعشرون',
    29: 'التاسع والعشرون',
    30: 'الثلاثون',
  };

  return numberMap[number] ?? 'رقم غير مدعوم';
}








  moveToPageEvent(BuildContext context, int page) {
    QuranCubit.get(context).pageController.jumpToPage(604 - page);
  }

  static const List<String> moshafIndexTypes = [  "السور","الاجزاء"

  ];

  toggleIndex(int type){
emit(type);

  }

    static List<SurahModel> getQuranSurah() =>
    QuranRepository.getQuranSurah();


        static List<JuzModel> getQuranJuz() =>
     QuranRepository.getQuranJuz();

}
