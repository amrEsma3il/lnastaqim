import 'package:adhan/adhan.dart';
import 'package:intl/intl.dart';
import 'package:lnastaqim/features/paryer_times/data/models/prayers_time_model.dart';

class PrayersTimesRepo {
  static PrayersTimeModel fetchPrayersTimes(coordinates, params) {
    final prayerTimes = PrayerTimes.today(coordinates, params);
    final currentPrayer = prayerTimes.currentPrayer();
    final nextPrayer = prayerTimes.nextPrayer();
    final sunnahTimes = SunnahTimes(prayerTimes);
    final qibla = Qibla(coordinates);
    return PrayersTimeModel(
        fajr: reformat(prayerTimes.fajr),
        sunrise: reformat(prayerTimes.sunrise),
        dhuhr: reformat(prayerTimes.dhuhr),
        asr: reformat(prayerTimes.asr),
        maghrib: reformat(prayerTimes.maghrib),
        isha: reformat(prayerTimes.isha),
        currentPrayer: PrayerModel(name: currentPrayer.name, index: currentPrayer.index),
        nextPrayer: PrayerModel(name: nextPrayer.name, index: nextPrayer.index),
        lastThirdOfTheNight: reformat(sunnahTimes.lastThirdOfTheNight),
        qiblaDirection: qibla.direction);
  }

  static CalculationParameters getCalculationParameters() {
    final params = CalculationMethod.egyptian.getParameters();
    params.madhab = Madhab.shafi;
    return params;
  }

  static String reformat(DateTime time) {
    DateFormat timeFormat = DateFormat.jm();
    return timeFormat.format(time);
  }
}
