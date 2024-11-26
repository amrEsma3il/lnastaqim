import 'package:flutter/material.dart';
import 'package:lnastaqim/core/constants/images.dart';
import 'package:lnastaqim/core/utilits/widgets/custom_app_bar.dart';
import 'package:lnastaqim/features/azkar_with_sib7a/view/widgets/custom_menu.dart';

import '../widget/books_grid_view.dart';

class MainHadithScreen extends StatelessWidget {
  const MainHadithScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        actions: [
          CustomMenu(
            isZekr: false,
          ),
        ],
        title: "الاحاديث",
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
