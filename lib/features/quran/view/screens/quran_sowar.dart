import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lnastaqim/core/constants/images.dart';
import '../../bussniess_logic/quran_sowar/quran_sowar_cubit.dart';
import '../../data/models/quran_model.dart';
import '../widgets/quran_aya_component.dart';

class QuranSowar extends StatelessWidget {
  const QuranSowar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BlocBuilder<QuranSowarCubit, List<QuranModel>>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Column(
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(20.r),
                  child: Image.asset(
                    AppImages.headerImage,
                  )),
                  SizedBox(height: 22.h,),
              ListView.builder(
                itemCount: state.length,
                itemBuilder: (context, index) =>
                    QuranAyaComponent(quranAyaEntity: state[index]),
              ),
            ],
          ),
        );
      },
    ));
  }
}
