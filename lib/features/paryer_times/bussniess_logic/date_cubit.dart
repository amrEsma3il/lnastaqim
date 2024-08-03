import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lnastaqim/core/utilits/extensions/arabic_numbers.dart';

import '../../../core/utilits/models/hijri_date_model.dart';
import '../../../core/utilits/services/hijri_date_service.dart';

class DateCubit extends Cubit<Map<String,String>> {
  DateCubit() : super({"gregorian":"","hijri": ""});

 static DateCubit get(BuildContext context)=>BlocProvider.of<DateCubit>(context);


    getDates(){
   DateTime now = DateTime.now();
    log(now.toString());
    HijriDate hijriDate =
        DateTimeService.gregorianToHijri(now.year, now.month, now.day);

    // String hijriTime = "${now.hour}:${now.minute}:${now.second}";
    String formattedHijriDate = DateTimeService.formatHijriDate(hijriDate);

      emit({"gregorian": DateTimeService.formatgreGorianDate(now)
                                      .toArabic,"hijri": formattedHijriDate.toArabic});
    }
}