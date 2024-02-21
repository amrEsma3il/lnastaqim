class PrayersTimeModel {
  late String fajr;
  late String sunrise;
  late String dhuhr;
  late String asr;
  late String maghrib;
  late String isha;
  PrayerModel? currentPrayer;
  PrayerModel? nextPrayer;
  String? lastThirdOfTheNight;
  double? qiblaDirection;

  PrayersTimeModel(
      {required this.fajr,
      required this.sunrise,
      required this.dhuhr,
      required this.asr,
      required this.maghrib,
      required this.isha,
      this.currentPrayer,
      this.nextPrayer,
      this.lastThirdOfTheNight,
      this.qiblaDirection});
}

class PrayerModel {
  String? name;
  int? index;

  PrayerModel({this.name, this.index});
}
