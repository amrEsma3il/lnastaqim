import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lnastaqim/core/constants/colors.dart';

import '../screens/sibha_view.dart';

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
      actions: [Padding(
        padding:  EdgeInsets.only(left: 10.w,bottom: 8.h),
        child: IconButton(
                    icon: Obx(
                      () => Icon(
                        ZekrController.instance.isFreeMode.value
                ?   Icons.looks_two:Icons.all_inclusive // unlimited mode
               ,
                        color: AppColor.white,
                      ),
                    ),
                    onPressed:  ZekrController.instance.toggleFreeMode,
                  ),
      ),],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
