import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/images.dart';
import '../../data/models/quran_model.dart';

class QuranAyaComponent extends StatelessWidget {
  final QuranModel quranAyaEntity;
  const QuranAyaComponent({
    super.key,
    required this.quranAyaEntity,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(40.w, 6.h, 20.w, 6.h),
      width: 362.w,
      height: 63.h,
      decoration: BoxDecoration(
          color: AppColor.creame, borderRadius: BorderRadius.circular(15.r)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(AppImages.pattern),
                  Text('${quranAyaEntity.id}')
                ],
              ),
              SizedBox(
                width: 17.w,
              ),
              Column(
                children: [
                  Text(quranAyaEntity.name),
                  SizedBox(
                    height: 3.h,
                  ),
                  Text(quranAyaEntity.type)
                ],
              ),
            ],
          ),
          Image.asset(quranAyaEntity.typeEn == 'medinan'
              ? AppImages.madania
              : AppImages.kaaba)
        ],
      ),
    );
  }
}
