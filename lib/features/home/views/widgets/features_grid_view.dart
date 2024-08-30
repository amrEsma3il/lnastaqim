import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lnastaqim/core/constants/images.dart';
import 'package:lnastaqim/features/home/data/models/feature_model.dart';
import 'package:lnastaqim/features/home/views/widgets/feature_item.dart';

import '../../../../config/routing/app_routes_info/app_routes_name.dart';

class FeaturesGridView extends StatelessWidget {
  const FeaturesGridView({super.key});

  static List<FeatureModel> items = [
    FeatureModel(
        text: "القران",
        image: AppImages.quranFeature,
        route: AppRouteName.moshaf),
    FeatureModel(
        text: "سماع القران",
        image: AppImages.listenFeature,
        route: AppRouteName.surahPlayerScreen),
    FeatureModel(text: "احاديث", image: AppImages.ahadesFeature),
    FeatureModel(
        text: "اذكار",
        image: AppImages.sibhaFeature,
        route: AppRouteName.azkarView),
    FeatureModel(
        text: "القبله",
        image: AppImages.qiblaFeature,
        route: AppRouteName.qibla),
    FeatureModel(
        text: "الراديو",
        image: AppImages.storyFeature,
        route: AppRouteName.radio),
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.count(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        childAspectRatio: 5 / 3,
        padding: EdgeInsets.zero,
        crossAxisCount: 3,
        mainAxisSpacing: 20,
        crossAxisSpacing: 15,
        children: List.generate(
          items.length,
          (item) => GestureDetector(
              onTap: () {
                Get.toNamed(items[item].route ?? AppRouteName.home);
              },
              child: FeatureItem(
                featureModel: items[item],
              )),
        ));
  }
}
