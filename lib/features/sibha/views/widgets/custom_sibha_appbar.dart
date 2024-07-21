import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lnastaqim/core/constants/colors.dart';

class CustomSibhaAppBar extends StatelessWidget {
  const CustomSibhaAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90.h,
      decoration: ShapeDecoration(
          color: AppColor.darkBrown, shape: const RoundedRectangleBorder()),
      child: Center(
        child: Text(
          "المسبحة الالكترونية",
          style: TextStyle(
              fontSize: 25.sp,
              fontWeight: FontWeight.w700,
              color: Colors.white),
        ),
      ),
    );
  }
}
