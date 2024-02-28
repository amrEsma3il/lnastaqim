import 'package:flutter/material.dart';
import 'package:lnastaqim/features/paryer_times/view/widgets/prayers_stepper.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
          child: PrayersStepper()
      ),
    );
  }
}
