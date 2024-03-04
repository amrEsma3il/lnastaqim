import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/images.dart';
import '../../bussniess_logic/quran_sowar/quran_sowar_cubit.dart';
import '../../bussniess_logic/sowra_detail/sora_details_cubit.dart';
import '../../data/models/quran_model.dart';

class QuranSoraComponent extends StatelessWidget {
  final SoraModel quranAyaEntity;

  const QuranSoraComponent({
    super.key,
    required this.quranAyaEntity,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        BlocProvider.of<QuranSowarVersusCubit>(context).selectedVerse(-1);
        BlocProvider.of<QuranSowarCubit>(context)
            .goToSoraDetailsEsvent(quranAyaEntity);
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(40.w, 6.h, 20.w, 6.h),
        margin: EdgeInsets.only(bottom: 10.h),
        width: 362.w,
        height: 63.h,
        decoration: BoxDecoration(
            color: AppColor.crame, borderRadius: BorderRadius.circular(15.r)),
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
                      color: AppColor.brownText,
                    ),
                    Text(
                      '${quranAyaEntity.id}',
                      style: const TextStyle(color: AppColor.black),
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
                      quranAyaEntity.name!,
                      style: TextStyle(
                          color: AppColor.brownBackground,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    Text(
                      quranAyaEntity.type!,
                      style: TextStyle(
                          color: AppColor.brownBackground,
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              ],
            ),
            Image.asset(
              quranAyaEntity.typeEn == 'medinan'
                  ? AppImages.madania
                  : AppImages.kaaba,
              width: 25.w,
              height: 25.h,
              color: AppColor.brownBackground,
            )
          ],
        ),
      ),
    );
  }
}
