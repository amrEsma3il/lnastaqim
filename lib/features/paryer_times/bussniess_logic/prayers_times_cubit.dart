import 'package:adhan/adhan.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lnastaqim/features/paryer_times/data/models/prayers_time_model.dart';
import 'package:meta/meta.dart';

part 'prayers_times_state.dart';

class PrayersTimesCubit extends Cubit<PrayersTimesState> {
  PrayersTimesCubit() : super(PrayersTimesInitial());

  late CalculationParameters params;
  late PrayersTimeModel prayerTimesModel;
}
