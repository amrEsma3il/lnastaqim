import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lnastaqim/config/routing/app_routes_info/app_routes_name.dart';
import 'package:lnastaqim/core/constants/colors.dart';
import 'package:lnastaqim/core/constants/images.dart';

import '../widgets/custom_sibha.dart';
import '../widgets/custom_sibha_appbar.dart';

class SibhaView extends StatelessWidget {
  const SibhaView({super.key});

  @override
  Widget build(BuildContext context) {
    final TextController textController = Get.put(TextController());

    return Scaffold(
      appBar: const CustomSibhaAppBar(),
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(AppImages.azkarBackground))),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(35.w, 50.h, 35.w, 0.h),
                child: Container(
                  height: 117,
                  width: double.infinity,
                  decoration: ShapeDecoration(
                      color: AppColor.primary,
                      shadows: [
                        BoxShadow(
                            blurRadius: 21,
                            color: AppColor.darkBrown.withOpacity(0.19))
                      ],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                  child: Obx(
                    () => Center(
                      child: Text(
                        textController.selectedText.value,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 24,
                            color: AppColor.white,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Center(
                  child: TextButton(
                      onPressed: () {
                        Get.toNamed(AppRouteName.sibhaAzkar);
                      },
                      child: Text(
                        "تغيير الذكر",
                        style: TextStyle(color: AppColor.primary),
                      )),
                ),
              ),
              SizedBox(height: 250.h),
              const CustomSibha()
            ],
          ),
        ),
      ),
    );
  }
}

class TextController extends GetxController {
  var selectedText = "سبحان الله".obs;
  var selectedIndex = -1.obs;

  void updateText(String newText, int index) {
    selectedText.value = newText;
    selectedIndex = index;
  }
}
