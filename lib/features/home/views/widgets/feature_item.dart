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
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(featureModel.image),
          const SizedBox(
            height: 3,
          ),
          Text(
            featureModel.text,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
          )
        ],
      ),
    );
  }
}
