import 'package:flutter/material.dart';
import 'package:prayers_times/prayers_times.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  Coordinates coordinates = Coordinates(31.053558472894615, 31.409808272765183);
  PrayerCalculationParameters params = PrayerCalculationMethod.egyptian();
  late PrayerTimes prayerTimes;

  @override
  void initState() {
    super.initState();
    params.madhab = PrayerMadhab.shafi;
    prayerTimes = PrayerTimes(
      coordinates: coordinates,
      calculationParameters: params,
      precision: true,
      locationName: 'Cairo',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Text('Fajr Start Time:\t${prayerTimes.fajrStartTime!}'),
          Text('Fajr End Time:\t${prayerTimes.fajrEndTime!}'),
          Text('Sunrise Time:\t${prayerTimes.sunrise!}'),
          Text('Dhuhr Start Time:\t${prayerTimes.dhuhrStartTime!}'),
          Text('Dhuhr End Time:\t${prayerTimes.dhuhrEndTime!}'),
          Text('Asr Start Time:\t${prayerTimes.asrStartTime!}'),
          Text('Asr End Time:\t${prayerTimes.asrEndTime!}'),
          Text('Maghrib Start Time:\t${prayerTimes.maghribStartTime!}'),
          Text('Maghrib End Time:\t${prayerTimes.maghribEndTime!}'),
          Text('Isha Start Time:\t${prayerTimes.ishaStartTime!}'),
          Text('Isha End Time:\t${prayerTimes.ishaEndTime!}'),
        ],
      )),
    );
  }
}
