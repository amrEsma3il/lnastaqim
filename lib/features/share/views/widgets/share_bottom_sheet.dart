import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/colors.dart';

void showShareBottomSheet(BuildContext context, Widget widget) {
  showModalBottomSheet(
    context: context,
    backgroundColor: AppColor.blueColor.withOpacity(0.98),
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(48.r), topLeft: Radius.circular(48.r))),
    builder: (context) => SizedBox(
      height: 200.h,
      width: double.infinity,
      child: SingleChildScrollView(
        child: Padding(padding: const EdgeInsets.all(20.0), child: widget),
      ),
    ),
  );
}
