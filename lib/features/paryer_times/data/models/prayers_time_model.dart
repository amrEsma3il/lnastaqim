class PrayersTimeModel {
  PrayersTimeModel({
    required this.fajr,
    required this.sunrise,
    required this.dhuhr,
    required this.asr,
    required this.maghrib,
    required this.isha,
  });

  PrayersTimeModel.fromJson(dynamic json) {
    fajr = json['fajr'];
    sunrise = json['sunrise'];
    dhuhr = json['dhuhr'];
    asr = json['asr'];
    maghrib = json['maghrib'];
    isha = json['isha'];
  }
  late String fajr;
  late String sunrise;
  late String dhuhr;
  late String asr;
  late String maghrib;
  late String isha;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['fajr'] = fajr;
    map['sunrise'] = sunrise;
    map['dhuhr'] = dhuhr;
    map['asr'] = asr;
    map['maghrib'] = maghrib;
    map['isha'] = isha;
    return map;
  }
}
