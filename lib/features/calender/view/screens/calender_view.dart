import 'package:flutter/material.dart';
import 'package:lnastaqim/core/utilits/widgets/custom_app_bar.dart';

class CalenderView extends StatelessWidget {
  const CalenderView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(
        title: "التقويم",
        isLayout: true,
      ),
      body: Column(
        children: [],
      ),
    );
  }
}
