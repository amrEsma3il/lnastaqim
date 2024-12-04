import 'package:flutter/material.dart';
import 'package:lnastaqim/core/utilits/widgets/custom_app_bar.dart';

class CompetitionsView extends StatelessWidget {
  const CompetitionsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(
        title: "التحديات",
        isLayout: true,
      ),
      body: Column(
        children: [],
      ),
    );
  }
}
