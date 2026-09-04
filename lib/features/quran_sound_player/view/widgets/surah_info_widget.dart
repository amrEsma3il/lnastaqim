import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

// import '../../../../core/constants/images.dart';
class SurahInfoWidget extends StatelessWidget {
  const SurahInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width - 50,
      height: 350.h,
      decoration: const BoxDecoration(
        // borderRadius: BorderRadius.circular(35),
        image: DecorationImage(
          alignment: Alignment.center,
          image: AssetImage('assets/images/reciter_10.png'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
