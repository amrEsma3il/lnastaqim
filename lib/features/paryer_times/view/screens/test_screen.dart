import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lnastaqim/features/paryer_times/bussniess_logic/prayers_times_cubit.dart';
import 'package:lnastaqim/features/paryer_times/view/widgets/prayers_stepper.dart';

class ParyerTimesScreen extends StatelessWidget {
  const ParyerTimesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PrayersTimesCubit, PrayersTimesState>(
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
              child: PrayersStepper(
                  prayerTimesModel: BlocProvider.of<PrayersTimesCubit>(context)
                      .prayerTimesModel)),
        );
      },
    );
  }
}
