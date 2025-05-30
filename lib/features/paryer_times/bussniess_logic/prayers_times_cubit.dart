import 'dart:async';
import 'dart:developer';

import 'package:adhan/adhan.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lnastaqim/features/paryer_times/data/models/prayers_time_model.dart';
import 'package:lnastaqim/features/paryer_times/data/repository/prayers_times_repo.dart';

import '../../../main.dart';
import '../../notification/bussiness_logic/notification_cubit.dart';

part 'prayers_times_state.dart';

class PrayersTimesCubit extends Cubit<PrayersTimeModel> {
  PrayersTimesCubit()
    : super(
        PrayersTimeModel(
          asr: "",
          dhuhr: "",
          fajr: "",
          maghrib: "",
          isha: "",
          sunrise: "",
          lastThirdOfTheNight: "",
          qiblaDirection: 0.0,
          currentPrayer: PrayerModel(name: "fajr", index: 0),
        ),
      ) {
    fetchPrayersTimes();

    try {
      LocationSettings locationSettings = LocationSettings(
        accuracy: LocationAccuracy.bestForNavigation,
        distanceFilter: 200,
      );

      Geolocator.getPositionStream(locationSettings: locationSettings).listen((
        Position? newPosition,
      ) async {
        log("position");
        if (position!.latitude != newPosition!.latitude ||
            position!.longitude != newPosition.longitude) {
          position = newPosition;
          fetchPrayersTimes();

          await notificationCubit.cancelAllNotifications();
          await notificationCubit.registerAllNotifications();
        }
      });
    } catch (e) {
      throw Exception('حدث خطأ أثناء محاولة الحصول على الموقع: $e');
    }

    timer = Timer.periodic(const Duration(minutes: 1), (timer) {
      fetchPrayersTimes();
    });
  }

  static PrayersTimesCubit get(BuildContext context) =>
      BlocProvider.of<PrayersTimesCubit>(context);
  final notificationCubit = NotificationCubit();

  Timer? timer;

  //   static Coordinates myCoordinates = Coordinates(position!.latitude, position!.longitude,
  //   );

  // //TODO: are this will updated every time read ?!
  //   static CalculationParameters params =
  //       PrayersTimesRepo.getCalculationParameters();
  //   static PrayersTimeModel prayerTimesModel = PrayersTimesRepo.fetchPrayersTimes(
  //     myCoordinates,
  //     params,
  //   );

  fetchPrayersTimes() async {
    log("Fetching prayer times...");

    // إعادة حساب أوقات الصلاة بناءً على الوقت الحالي
    final params = PrayersTimesRepo.getCalculationParameters();
    final newPrayerTimesModel = PrayersTimesRepo.fetchPrayersTimes(
      Coordinates(position!.latitude, position!.longitude),
      params,
    );
    log(
      "new position latitude,longitude: ${position!.latitude},${position!.longitude}",
    );

    log("Current prayer index: ${newPrayerTimesModel.currentPrayer?.index}");
    log("Current prayer name: ${newPrayerTimesModel.currentPrayer?.name}");

    log(" prayer fajr: ${newPrayerTimesModel.fajr}");
    log(" prayer duhar: ${newPrayerTimesModel.dhuhr}");
    log(" prayer fajr: ${newPrayerTimesModel.asr}");
    log(" prayer duhar: ${newPrayerTimesModel.maghrib}");
    log(" prayer fajr: ${newPrayerTimesModel.isha}");

    // تحديث الحالة بالقيم الجديدة
    emit(newPrayerTimesModel);
  }
}
