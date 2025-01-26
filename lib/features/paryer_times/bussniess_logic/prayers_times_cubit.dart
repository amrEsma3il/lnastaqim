import 'dart:async';
import 'dart:developer';

import 'package:adhan/adhan.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lnastaqim/features/paryer_times/data/models/prayers_time_model.dart';
import 'package:lnastaqim/features/paryer_times/data/repository/prayers_times_repo.dart';



part 'prayers_times_state.dart';

class PrayersTimesCubit extends Cubit<PrayersTimeModel> {
  PrayersTimesCubit() : super(PrayersTimeModel(asr: "",dhuhr: "",fajr: "",maghrib: "",isha: "",sunrise: "",lastThirdOfTheNight: "",qiblaDirection: 0.0,currentPrayer: PrayerModel(name:"fajr",index: 0 ))){
    fetchPrayersTimes();
  Timer.periodic(const Duration(minutes: 1), (timer) {
  fetchPrayersTimes();
});
    
  }


static PrayersTimesCubit get(BuildContext context)=>BlocProvider.of<PrayersTimesCubit>(context);
  // late Timer timer;


    final  Coordinates myCoordinates = Coordinates(31.053698, 31.409504
);



  //  final CalculationParameters params =
  //     PrayersTimesRepo.getCalculationParameters();
   final PrayersTimeModel paryerTimesModel =
      PrayersTimesRepo.fetchPrayersTimes( Coordinates(31.053698, 31.409504
), PrayersTimesRepo.getCalculationParameters());
  fetchPrayersTimes()async{



    log("test from paryer times");
    
// Position? position=await LocationService.determinePosition();

   emit(paryerTimesModel);

  

  }
}
