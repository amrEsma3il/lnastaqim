import 'package:adhan/adhan.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lnastaqim/features/paryer_times/data/models/prayers_time_model.dart';
import 'package:lnastaqim/features/paryer_times/data/repository/prayers_times_repo.dart';
import 'package:meta/meta.dart';

part 'prayers_times_state.dart';

class PrayersTimesCubit extends Cubit<PrayersTimesState> {
  PrayersTimesCubit() : super(PrayersTimesInitial());

  final myCoordinates = Coordinates(31.360835, 31.572778);

  late CalculationParameters params = PrayersTimesRepo.getCalculationParameters();
  late PrayersTimeModel prayerTimesModel = PrayersTimesRepo.fetchPrayersTimes(myCoordinates, params);
}
