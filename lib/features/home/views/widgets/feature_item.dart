import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lnastaqim/features/home/data/models/feature_model.dart';

class FeatureItem extends StatelessWidget {
  const FeatureItem({super.key, required this.featureModel});
  final FeatureModel featureModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.h,
      width: 80.w,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
        shadows: [
         
           BoxShadow(
            color: Colors.grey.withOpacity(0.2), // ظل رمادي خفيف
            offset: const Offset(0, 4),          // الاتجاه
            blurRadius: 10,                      // نعومة الظل
            spreadRadius: 1,                     // امتداد الظل
          ),
          BoxShadow(
            color: Colors.grey.withOpacity(0.2), // ظل رمادي خفيف
            offset: const Offset(0, 4),          // الاتجاه
            blurRadius: 10,                      // نعومة الظل
            spreadRadius: 1,                     // امتداد الظل
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            width: 25,
            height: 25,
            featureModel.image,
          ),
          const SizedBox(
            height: 3,
          ),
          Text(
            featureModel.text,
            style:  TextStyle(
              fontSize: 12.2.sp,
              fontWeight: FontWeight.w700,
            ),
          )
        ],
      ),
    );
  }
}
