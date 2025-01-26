import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lnastaqim/core/constants/colors.dart';

class CustomSibhaAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomSibhaAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColor.primary,
                    toolbarHeight: 100.h,
              title: Padding(padding:  EdgeInsets.only(bottom: 15.h,top: 5.h),child: Text(
                "المسبحة الالكترونية",
                style: TextStyle(
                  fontSize: 23.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),),
              centerTitle: true,

      leading: GestureDetector(
        onTap: () {
          Get.back();
        },
        child: const Icon(
          Icons.arrow_back,
          color: Colors.white,
          size: 25,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
