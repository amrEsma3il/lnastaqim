import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lnastaqim/core/constants/images.dart';
import 'package:lnastaqim/features/home/data/models/feature_model.dart';
import 'package:lnastaqim/features/home/views/widgets/feature_item.dart';

import '../../../../config/routing/app_routes_info/app_routes_name.dart';
import '../../../quran/bussniess_logic/font_cubit/font_cubit.dart';
import '../../../quran/bussniess_logic/font_cubit/font_loader_test.dart';

class FeaturesGridView extends StatelessWidget {
  const FeaturesGridView({super.key});

  static List<FeatureModel> items = [
    FeatureModel(
        text: "القران",
        image: AppImages.quranFeature,
        route: AppRouteName.moshaf),
    FeatureModel(
        text: "السبحة",
        image: AppImages.sibhaFeature,
        route: AppRouteName.sibhaView),
    FeatureModel(
        text: "الأحاديث",
        image: AppImages.ahadesFeature,
        route: AppRouteName.a7adithView),
    FeatureModel(
        text: "الأذكار",
        image: AppImages.azkarIc,
        route: AppRouteName.azkarView),
    FeatureModel(
        text: "القبلة",
        image: AppImages.qiblaFeature,
        route: AppRouteName.qibla),
    FeatureModel(
        text: "الراديو",
        image: AppImages.storyFeature,
        route: AppRouteName.radio),
         FeatureModel(
        text: "سماع القرءان",
        image: AppImages.listenFeature,
        route: AppRouteName.surahPlayerScreen),
  ];//surahPlayerScreen

  @override
  Widget build(BuildContext context) {
    return GridView.count(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        childAspectRatio: 5 / 3,
        padding: EdgeInsets.zero,
        crossAxisCount: 3,
        mainAxisSpacing: 17.h,
        crossAxisSpacing: 33.w,
        children: List.generate(
          items.length,
          (item) => GestureDetector(
              onTap: ()async {
                Get.toNamed(items[item].route ?? AppRouteName.home);
            // items[item].text=="القران"?    FontCubit.getFontCubit(context).loadFont(604):null;

              },
              child: FeatureItem(
                featureModel: items[item],
              )),
        ));
  }
}
