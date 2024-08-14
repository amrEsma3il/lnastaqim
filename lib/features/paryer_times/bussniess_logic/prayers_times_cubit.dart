import 'dart:async';
import 'dart:developer';

import 'package:adhan/adhan.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lnastaqim/features/paryer_times/data/models/prayers_time_model.dart';
import 'package:lnastaqim/features/paryer_times/data/repository/prayers_times_repo.dart';

import '../../../core/utilits/services/location_service.dart';


part 'prayers_times_state.dart';

class PrayersTimesCubit extends Cubit<PrayersTimeModel> {
  PrayersTimesCubit() : super(PrayersTimeModel(asr: "",dhuhr: "",fajr: "",maghrib: "",isha: "",sunrise: "",lastThirdOfTheNight: "",qiblaDirection: 0.0,currentPrayer: PrayerModel(name:"fajr",index: 0 ))){
    fetchPrayersTimes();
  }


static PrayersTimesCubit get(BuildContext context)=>BlocProvider.of<PrayersTimesCubit>(context);
  late Timer timer;



  fetchPrayersTimes()async{
    log("test from paryer times");
// Position? position=await LocationService.determinePosition();
// final myCoordinates = Coordinates(position!.latitude,position.longitude);
final myCoordinates = Coordinates(31.360835, 31.572778);

  late CalculationParameters params = PrayersTimesRepo.getCalculationParameters();

   PrayersTimeModel prayerTimesModel = PrayersTimesRepo.fetchPrayersTimes(myCoordinates, params);
   emit(prayerTimesModel);

   timer=Timer.periodic(const Duration(minutes: 1), (timer) {  
log(prayerTimesModel.currentPrayer!.index.toString());
log(prayerTimesModel.currentPrayer!.name.toString());

    emit(prayerTimesModel);
           log("-----------------test from paryer times-----------------");

});
  }
}
