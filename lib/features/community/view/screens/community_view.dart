import 'package:flutter/material.dart';
import 'package:lnastaqim/core/utilits/widgets/custom_app_bar.dart';

class CommunityView extends StatelessWidget {
  const CommunityView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(
        title: "المجتمع",
        isLayout: true,
      ),
      body: Column(
        children: [],
      ),
    );
  }
}
