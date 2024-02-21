import 'package:adhan/adhan.dart';
import 'package:intl/intl.dart';
import 'package:lnastaqim/features/paryer_times/data/models/prayers_time_model.dart';
import 'prayers_times_repo.dart';

class PrayersTimesRepoImpl implements PrayersTimesRepo {
  @override
  PrayersTimeModel fetchPrayersTimes(coordinates, params) {
    final prayerTimes = PrayerTimes.today(coordinates, params);
    final currentPrayer = prayerTimes.currentPrayer();
    final nextPrayer = prayerTimes.nextPrayer();
    final sunnahTimes = SunnahTimes(prayerTimes);
    final qibla = Qibla(coordinates);
    DateFormat timeFormat = DateFormat.jm();
    return PrayersTimeModel(
        fajr: timeFormat.format(prayerTimes.fajr),
        sunrise: timeFormat.format(prayerTimes.sunrise),
        dhuhr: timeFormat.format(prayerTimes.dhuhr),
        asr: timeFormat.format(prayerTimes.asr),
        maghrib: timeFormat.format(prayerTimes.maghrib),
        isha: timeFormat.format(prayerTimes.isha),
        currentPrayer:
            PrayerModel(name: currentPrayer.name, index: currentPrayer.index),
        nextPrayer: PrayerModel(name: nextPrayer.name, index: nextPrayer.index),
        lastThirdOfTheNight: timeFormat.format(sunnahTimes.lastThirdOfTheNight),
        qiblaDirection: qibla.direction);
  }
}
