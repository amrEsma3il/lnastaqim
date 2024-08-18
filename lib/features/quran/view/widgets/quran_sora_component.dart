import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/images.dart';
import '../../bussniess_logic/quran_sowar/quran_sowar_cubit.dart';
import '../../data/models/quran_model.dart';

class QuranSoraComponent extends StatelessWidget {
  final MoshafSurahIndexModel quranAyaEntity;

  const QuranSoraComponent({
    super.key,
    required this.quranAyaEntity,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.back();
        BlocProvider.of<QuranSowarCubit>(context)
            .goToSoraDetailsEsvent(context,quranAyaEntity);
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(40.w, 6.h, 20.w, 6.h),
        margin: EdgeInsets.only(bottom: 10.h),
        width: 362.w,
        height: 63.h,
        decoration: BoxDecoration(
            color: AppColor.lightBlue, borderRadius: BorderRadius.circular(15.r)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(
                      AppImages.pattern,
                      width: 38.66.w,
                      height: 36.h,
                      color: const Color.fromARGB(255, 151, 109, 219),
                    ),
                    Text(
                      '${quranAyaEntity.id}',
                      style: const TextStyle(color: AppColor.blueColor),
                    )
                  ],
                ),
                SizedBox(
                  width: 18.w,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      quranAyaEntity.name,
                      style: TextStyle(
                          color: AppColor.blueColor,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    Text(
                     quranAyaEntity.makkia == 1?"مكية":"مدنية",
                      style: TextStyle(
                          color: AppColor.blueColor.withOpacity(0.9),
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              ],
            ),
            Image.asset(
              quranAyaEntity.makkia == 0
                  ? AppImages.madania
                  : AppImages.kaaba,
              width: 25.w,
              height: 25.h,
              color: AppColor.blueColor.withOpacity(0.9),
            )
          ],
        ),
      ),
    );
  }
}
