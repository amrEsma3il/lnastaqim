
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../config/routing/app_routes_info/app_routes_name.dart';
import '../../../../core/constants/colors.dart';
import '../../data/data_sources/const_data_sources/bottom_nav_bar.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 15.h,
      right: 14.w,
      left: 14.w,
      child: Container(
        width: 365.w,
        height: 50.h,
        decoration: BoxDecoration(
            color: AppColor.brownBackground,
            borderRadius: BorderRadius.circular(30.r)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ...List.generate(
                navBarIconDataSource.length,
                (index) => GestureDetector(
                  onTap: () {
                 index==1?   Get.toNamed(AppRouteName.moshaf):null;
                  },
                  child: Image.asset(
                        navBarIconDataSource[index],
                        width: 23.w,
                        height: 23.h,
                      ),
                ))
          ],
        ),
      ),
    );
  }
}
