import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lnastaqim/core/constants/images.dart';
import '../../bussniess_logic/quran_sowar/quran_sowar_cubit.dart';

import '../../data/models/quran_model.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/quran_sora_component.dart';
import '../widgets/header_quran.dart';

class QuranSowar extends StatelessWidget {
  const QuranSowar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(
      child: BlocBuilder<QuranSowarCubit, List<SoraModel>>(
        builder: (context, state) {
          return SizedBox(
            height: Get.height,
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 7.h,
                      ),
                      const HeaderSection(),
                      SizedBox(
                        height: 10.h,
                      ),
                      ClipRRect(
                          borderRadius: BorderRadius.circular(20.r),
                          child: Image.asset(
                            AppImages.headerImage,
                            width: 363.w,
                            height: 155.h,
                          )),
                      SizedBox(
                        height: 22.h,
                      ),
                      Expanded(
                        child: Padding(
                          padding:  EdgeInsets.only(bottom: 68.h),
                          child: ListView.builder(
                            itemCount: state.length,
                            itemBuilder: (context, index) =>
                                QuranSoraComponent(quranAyaEntity: state[index]),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const BottomNavBar()
              ],
            ),
          );
        },
      ),
    ));
  }
}
