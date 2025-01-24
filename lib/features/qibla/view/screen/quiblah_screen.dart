import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lnastaqim/features/qibla/bussiness_logic/quiblah_controller.dart';
import 'package:lnastaqim/features/qibla/view/screen/compass_Screen.dart';


class QuiblahScreen extends StatelessWidget {
  const QuiblahScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<QuiblahCubit>(
      create: (BuildContext context) => QuiblahCubit(true),
      child: BlocBuilder<QuiblahCubit, bool>(
        builder: (BuildContext context, bool state) {
          return   const CompassScreen();
        },
      ),
    );
  }
}
