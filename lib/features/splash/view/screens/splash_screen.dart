import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/images.dart';
import '../../logic/splash_cubit/splash_cubit.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SplashCubit().splashTimerEvent();

    return Scaffold(
      body: Container(
        width: Get.width,
        height: Get.height,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColor.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              AppImages.splash,
              width: 151.w,
              height: 143.h,
            ),
            SizedBox(height: 5.h,),
            Text("لنستقيم",style: TextStyle(fontFamily: "Andalus",fontSize: 32.sp,fontWeight: FontWeight.w600,color: AppColor.primaryBlueColor),)
          ].animate()
  .fade(duration: const Duration(seconds: 5))
  .scale(duration: const Duration(seconds: 4), begin: const Offset(0.5, 0.5), end:  const Offset(1, 1))
  .slideY(begin: -0.5, end: 0, duration: const Duration(seconds: 4)),
        ),
      ),
    );
  }
}
