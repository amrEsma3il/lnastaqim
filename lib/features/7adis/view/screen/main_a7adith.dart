import 'package:flutter/material.dart';
import 'package:lnastaqim/core/constants/images.dart';
import 'package:lnastaqim/core/utilits/widgets/custom_azkar_hadis_app.dart';

import '../widget/books_grid_view.dart';

class MainHadithScreen extends StatelessWidget {
  const MainHadithScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAzkarHadisApp(
        title: "الاحاديث",
        isZekr: false,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImages.azkarBackground),
          ),
        ),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BooksGridView(),
          ],
        ),
      ),
    );
  }
}
