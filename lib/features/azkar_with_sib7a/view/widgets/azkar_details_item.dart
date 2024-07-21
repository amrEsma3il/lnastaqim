import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lnastaqim/core/constants/colors.dart';
import 'package:lnastaqim/features/azkar_with_sib7a/data/models/AzkarModel.dart';

class AzkarDetailsItem extends StatelessWidget {
  const AzkarDetailsItem({
    super.key,
    required this.azkarModel,
  });

  final AzkarModel azkarModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 15.w, left: 15.w, bottom: 25.h),
      child: Container(
        decoration: ShapeDecoration(
            color: AppColor.lightBrownWithOpacity10,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.r))),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              decoration: ShapeDecoration(
                  color: AppColor.darkBrown,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.r))),
              child: Padding(
                padding: EdgeInsets.fromLTRB(15.w, 12.h, 15.w, 10.h),
                child: Center(
                  child: Text(
                    azkarModel.zekr ?? "",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 14.sp,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(15.w, 15.h, 15.w, 15.h),
              child: Row(
                children: [
                  Expanded(
                    child: CircleAvatar(
                      radius: 25,
                      backgroundColor: AppColor.pantone,
                      child: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.share,
                            size: 24,
                            color: Colors.white,
                          )),
                    ),
                  ),
                  Expanded(
                    child: CircleAvatar(
                      radius: 25,
                      backgroundColor: AppColor.pantone,
                      child: Text(
                        azkarModel.count ?? "",
                        style: const TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  Expanded(
                    child: CircleAvatar(
                      radius: 25,
                      backgroundColor: AppColor.pantone,
                      child: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.favorite_border,
                            size: 24,
                            color: Colors.white,
                          )),
                    ),
                  ),
                  Expanded(
                    child: CircleAvatar(
                      radius: 25,
                      backgroundColor: AppColor.pantone,
                      child: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.copy,
                            size: 24,
                            color: Colors.white,
                          )),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
