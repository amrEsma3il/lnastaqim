import 'package:flutter/material.dart';
import 'package:lnastaqim/core/utilits/widgets/custom_app_bar.dart';

class SupportView extends StatelessWidget {
  const SupportView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(title: "الدعم"),
      body: Column(
        children: [],
      ),
    );
  }
}
