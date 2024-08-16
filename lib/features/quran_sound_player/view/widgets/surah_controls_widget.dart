import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/surah_player_cubit/surah_player_cubit.dart';
import '../../logic/surah_player_cubit/surah_player_state.dart';

class SurahControlsWidget extends StatelessWidget {
  const SurahControlsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.skip_previous),
              onPressed: () {
                context.read<SurahPlayerCubit>().previousSurah();
              },
            ),
            BlocBuilder<SurahPlayerCubit, SurahPlayerState>(
              builder: (context, state) {
                return IconButton(
                  icon: state.isPlaying
                      ? const Icon(Icons.pause)
                      : const Icon(Icons.play_arrow),
                  onPressed: () {
                    context.read<SurahPlayerCubit>().togglePlayPause();
                  },
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.skip_next),
              onPressed: () {
                context.read<SurahPlayerCubit>().nextSurah();
              },
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<SurahPlayerCubit, SurahPlayerState>(
              builder: (context, state) {
                return IconButton(
                  icon: Icon(
                    Icons.repeat,
                    color: state.maxRepeats > 0 ? Colors.teal : Colors.grey,
                  ),
                  onPressed: () {
                    context.read<SurahPlayerCubit>().toggleRepeat();
                  },
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.shuffle),
              onPressed: () {
                context.read<SurahPlayerCubit>().playRandomSurah();
              },
            ),
          ],
        ),
        const SizedBox(height: 10),
        BlocBuilder<SurahPlayerCubit, SurahPlayerState>(
          builder: (context, state) {
            return Text(
              'Repeat: ${state.maxRepeats} time${state.maxRepeats > 1 ? 's' : ''}',
            );
          },
        ),
      ],
    );
  }
}
