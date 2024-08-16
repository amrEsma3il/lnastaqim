import 'package:flutter/material.dart';

import '../../../../core/constants/images.dart';

class SurahInfoWidget extends StatelessWidget {
  const SurahInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundImage: AssetImage(AppImages.azkarHeader),
        ),
        SizedBox(height: 20),
        Text(
          'محمود خليل الحصري',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
