import 'package:adhan/adhan.dart';
import 'package:lnastaqim/features/paryer_times/data/models/prayers_time_model.dart';

abstract class PrayersTimesRepo {
  PrayersTimeModel fetchPrayersTimes(coordinates, params);
  CalculationParameters getCalculationParameters();
}
