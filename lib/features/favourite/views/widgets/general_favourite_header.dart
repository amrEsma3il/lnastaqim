import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lnastaqim/core/constants/colors.dart';

class GeneralFavouriteHeader extends StatelessWidget {
  const GeneralFavouriteHeader({
    super.key,
    this.onTap,
    required this.title,
    required this.isVisible,
  });

  final void Function()? onTap;
  final String title;
  final bool isVisible;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Text(
            title,
            style: TextStyle(fontSize: 20.sp,fontWeight: FontWeight.w600,color: AppColor.primary),
          ),
        ),
        SizedBox(height: 5.h,),
        Visibility(
          visible: isVisible,
          child:  SizedBox(
            width: 120,
            height: 0,
            child: Divider(
              height: 9,
              thickness: 3,
              color: AppColor.primary,
            ),
          ),
        ),
      ],
    );
  }
}
