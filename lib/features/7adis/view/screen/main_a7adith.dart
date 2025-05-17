import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lnastaqim/core/constants/images.dart';
import 'package:lnastaqim/core/utilits/widgets/custom_app_bar.dart';

import '../../../../config/routing/app_routes_info/app_routes_name.dart';
import '../widget/books_grid_view.dart';

class MainHadithScreen extends StatelessWidget {
  const MainHadithScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  CustomAppBar(
        actions: [
         IconButton(onPressed: () {
                Get.toNamed(AppRouteName.fav7adis);
         }, icon: const Icon(Icons.favorite,color: Colors.white,))
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
