import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lnastaqim/core/utilits/extensions/arabic_numbers.dart';

import '../../../core/utilits/models/hijri_date_model.dart';
import '../../../core/utilits/services/hijri_date_service.dart';

class DateCubit extends Cubit<Map<String, String>> {
  DateCubit() : super({"gregorian": "", "hijri": ""}){
getDates();
    Timer.periodic(const Duration(minutes: 1), (timer) {
  getDates();
});
  }

  static DateCubit get(BuildContext context) =>
      BlocProvider.of<DateCubit>(context);
 
  
void getDates() {
  DateTime now = DateTime.now();
 final HijriDate hijriDate =
      DateTimeService.gregorianToHijri(now.year, now.month, now.day);

 final String newGregorian = DateTimeService.formatgreGorianDate(now).toArabic;
final  String newHijri = DateTimeService.formatHijriDate(hijriDate).toArabic;

  if (state["gregorian"] != newGregorian || state["hijri"] != newHijri) {
    emit({
      "gregorian": newGregorian,
      "hijri": newHijri,
    });
  }
}
}
