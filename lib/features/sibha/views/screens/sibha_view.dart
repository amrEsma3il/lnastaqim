import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lnastaqim/core/constants/colors.dart';
import 'package:lnastaqim/core/constants/images.dart';

import '../widgets/custom_sibha.dart';
import '../widgets/custom_sibha_appbar.dart';

class SibhaView extends StatelessWidget {
  const SibhaView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(AppImages.azkarBackground))),
          child: Column(
            children: [
              const CustomSibhaAppBar(),
              Padding(
                padding: EdgeInsets.fromLTRB(35.w, 50.h, 35.w, 0.h),
                child: Container(
                  height: 117,
                  width: double.infinity,
                  decoration: ShapeDecoration(
                      color: AppColor.creame,
                      shadows: [
                        BoxShadow(
                            blurRadius: 21,
                            color: AppColor.darkBrown.withOpacity(0.19))
                      ],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "سبحان الله وبحمده",
                        style: TextStyle(
                            fontSize: 31,
                            color: AppColor.darkBrown,
                            fontWeight: FontWeight.w700),
                      ),
                      Text(
                        "يكتب له ألف حسنة أو يحط عنه ألف خطيئه",
                        style: TextStyle(
                            fontSize: 14,
                            color: AppColor.darkBrown,
                            fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
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
