import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../core/utilits/extensions/arabic_numbers.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/images.dart';
import '../../bussniess_logic/quran/index_cubit/index_cubit.dart';


class QuranSoraComponent extends StatelessWidget {
  final dynamic indexEntity;

  const QuranSoraComponent({
    super.key,
    required this.indexEntity,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // int page=indexEntity is SurahIndexState ?(indexEntity as SurahIndexState).indexList as List<SurahIndex>.sta:;
        
        
        // || indexEntity is ChapterIndexState ||indexEntity is HizbIndexState?indexEntity.indexList.startPage:0;
        Get.back();
        

        BlocProvider.of<IndexCubit>(context)
            .goToSoraDetailsEsvent(context,indexEntity.startPage);
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(40.w, 6.h, 20.w, 6.h),
        margin: EdgeInsets.only(bottom: 5.h),
        width: Get.width-100.w,
        height: 55.h,
        decoration: BoxDecoration(
            color: AppColor.lightBlue, borderRadius: BorderRadius.circular(15.r)),
        child: Row(
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Image.asset(
                  AppImages.pattern,
                  width: 32.w,
                  height: 32.h,
                  color: const Color.fromARGB(255, 151, 109, 219),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 3.0),
                  child: Text(
                    indexEntity.id.toString().toArabic,
                    style: const TextStyle(color: AppColor.blueColor,fontSize: 20),
                  ),
                )
              ],
            ),
            SizedBox(
              width: 22.w,
            ),
            Text(
              indexEntity.name,
              style: TextStyle(
                  color: AppColor.blueColor,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
    );
  }
}
