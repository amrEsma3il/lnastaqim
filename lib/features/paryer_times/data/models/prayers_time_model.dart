class PrayersTimeModel {
  late String fajr;
  late String sunrise;
  late String dhuhr;
  late String asr;
  late String maghrib;
  late String isha;
  Prayer? currentPrayer;
  Prayer? nextPrayer;
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

class Prayer {
  String? name;
  int? index;

  Prayer({this.name, this.index});
}
