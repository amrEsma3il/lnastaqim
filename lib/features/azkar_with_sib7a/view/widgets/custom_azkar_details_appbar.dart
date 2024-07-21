import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lnastaqim/core/constants/colors.dart';

class CustomAzkarDetailsAppBar extends StatelessWidget {
  const CustomAzkarDetailsAppBar({
    super.key,
    required this.category,
  });

  final String category;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90.h,
      decoration: ShapeDecoration(
          color: AppColor.creame, shape: const RoundedRectangleBorder()),
      child: Row(
        children: [
          IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(
                Icons.arrow_back_ios_new,
                size: 17,
                color: AppColor.lightBrown,
              )),
          SizedBox(
            width: category.length > 20 ? 30.w : 60.w,
          ),
          Expanded(
            child: Text(
              category,
              style: TextStyle(
                  fontSize: category.length > 25 ? 18.sp : 27.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColor.darkBrown),
            ),
          )
        ],
      ),
    );
  }
}
