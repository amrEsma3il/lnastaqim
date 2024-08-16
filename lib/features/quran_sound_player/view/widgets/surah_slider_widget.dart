import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/surah_player_cubit/surah_player_cubit.dart';
import '../../logic/surah_player_cubit/surah_player_state.dart';

class SurahSliderWidget extends StatelessWidget {
  const SurahSliderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SurahPlayerCubit, SurahPlayerState>(
      builder: (context, state) {
        return Slider(
          value: state.currentPosition,
          max: state.surahDuration,
          onChanged: (value) {
            context.read<SurahPlayerCubit>().seek(value);
          },
        );
      },
    );
  }
}
