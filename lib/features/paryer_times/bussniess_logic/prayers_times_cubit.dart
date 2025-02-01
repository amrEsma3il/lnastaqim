import 'dart:async';
import 'dart:developer';

import 'package:adhan/adhan.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lnastaqim/features/paryer_times/data/models/prayers_time_model.dart';
import 'package:lnastaqim/features/paryer_times/data/repository/prayers_times_repo.dart';

import '../../../core/utilits/services/location_service.dart';
import '../../../main.dart';



part 'prayers_times_state.dart';

class PrayersTimesCubit extends Cubit<PrayersTimeModel> {
  PrayersTimesCubit() : super(PrayersTimeModel(asr: "",dhuhr: "",fajr: "",maghrib: "",isha: "",sunrise: "",lastThirdOfTheNight: "",qiblaDirection: 0.0,currentPrayer: PrayerModel(name:"fajr",index: 0 ))){
    fetchPrayersTimes();
    Timer.periodic(const Duration(minutes: 1), (timer) {
      fetchPrayersTimes();
    },);
  }


static PrayersTimesCubit get(BuildContext context)=>BlocProvider.of<PrayersTimesCubit>(context);
  late Timer timer;


   static Coordinates myCoordinates = Coordinates(position!.latitude, position!.longitude
);



  static CalculationParameters params =
      PrayersTimesRepo.getCalculationParameters();
  static PrayersTimeModel prayerTimesModel =
      PrayersTimesRepo.fetchPrayersTimes(myCoordinates, params);
  fetchPrayersTimes() async {
    log("Fetching prayer times...");

    // إعادة حساب أوقات الصلاة بناءً على الوقت الحالي
    final params = PrayersTimesRepo.getCalculationParameters();
    final newPrayerTimesModel =
        PrayersTimesRepo.fetchPrayersTimes(myCoordinates, params);

    log("Current prayer index: ${newPrayerTimesModel.currentPrayer?.index}");
    log("Current prayer name: ${newPrayerTimesModel.currentPrayer?.name}");

    log(" prayer fajr: ${newPrayerTimesModel.fajr}");
    log(" prayer duhar: ${newPrayerTimesModel.dhuhr}");

    // تحديث الحالة بالقيم الجديدة
  emit(newPrayerTimesModel);
  }
}