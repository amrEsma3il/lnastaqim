import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/surah_player_cubit/surah_player_cubit.dart';
import '../widgets/surah_controls_widget.dart';
import '../widgets/surah_info_widget.dart';
import '../widgets/surah_slider_widget.dart';


class SurahPlayerScreen extends StatelessWidget {
  const SurahPlayerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SurahPlayerCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('سورة البقرة'),
          backgroundColor: Colors.teal,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {},
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.download),
              onPressed: () {
                // Download surah
              },
            ),
          ],
        ),
        body: const Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SurahInfoWidget(),
              SizedBox(height: 20),
              SurahControlsWidget(),
              SizedBox(height: 20),
              SurahSliderWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
