import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lnastaqim/core/constants/images.dart';
import 'package:lnastaqim/features/7adis/bussiness_logic/a7adith_cubit.dart';
import 'package:lnastaqim/features/7adis/bussiness_logic/a7adiths_state.dart';
import 'package:lottie/lottie.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../../../../core/constants/animations.dart';
import '../../../../core/constants/colors.dart';
import 'a7adith_details.dart';
import 'main_a7adith.dart';
class A7adithScreen extends StatelessWidget {
  const A7adithScreen({super.key, required this.bookName});
  final String bookName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: AppColor.primary.withValues(alpha:0.8),
        title: BlocBuilder<HadithCubit, HadithState>(
          builder: (context, state) {
            if (state is HadithLoaded) {
              return Row(
                children: [
                  const Text(
                    'فهرس الكتاب ',
                    style: TextStyle(
                        fontFamily: 'Arab140',
                        fontSize: 23,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "(${state.hadiths[0].metadata!.arabic!.title!})",
                    style: const TextStyle(
                        fontFamily: 'Arab140',
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              );
            } else {
              return const Text(
                'فهرس الكتاب',
                style: TextStyle(
                    fontFamily: 'Arab140',
                    fontSize: 23,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              );
            }
          },
        ),
      ),
      body: BlocBuilder<HadithCubit, HadithState>(
        builder: (context, state) {
          if (state is HadithLoading) {
            return  Center(child:
            Lottie.asset(
         AppAnimation.loadingCircle, // مسار ملف Lottie الخاص بك
          width: 135.w, // حجم الرسوم المتحركة
          height: 135.h,
          fit: BoxFit.contain,
          repeat: true,
          animate: true,
    
        )
            
            
             );
          }

          if (state is HadithDownloadProgress) {
            double percent = switch (bookName) {
              "bukhari" => state.progressBukhari,
              "muslim" => state.progressMuslim,
              "abudawod" => state.progressAbuDawud,
              "nasai" => state.progressNasai,
              "tirmidhi" => state.progressTirmidhi,
              "ibnmajah" => state.progressIbnmajah,
              "darimi" => state.progressDarimi,
              "malik" => state.progressMalik,
              "ahmed" => state.progressAhmed,
              _ => 0.0,
            };
            return Center(
              child: CircularPercentIndicator(
                radius: 120.0,
                lineWidth: 10.0,
                percent: percent,
                center: Text(
                  '${(percent * 100).toStringAsFixed(0)}%',
                  style: const TextStyle(fontSize: 24.0),
                ),
                progressColor: AppColor.blueColor,
                backgroundColor: Colors.grey[200]!,
              ),
            );
          }

          if (state is HadithLoaded) {
            return Container(
              width: MediaQuery.sizeOf(context).width,
              height: MediaQuery.sizeOf(context).height,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fitWidth,
                  image: AssetImage(AppImages.azkarBackground),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    return SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => A7adithDetails(id: index + 1)));
                        },
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                            child: Row(
                              children: [
                                Text(
                                  state.hadiths[0].chapters![index].arabic!,
                                  style: const TextStyle(
                                      fontFamily: 'Arab140', fontSize: 15),
                                  textAlign: TextAlign.right,
                                ),
                                const Spacer(),
                                const Icon(Icons.arrow_drop_down),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => const SizedBox(height: 8),
                  itemCount: state.hadiths[0].chapters!.length,
                ),
              ),
            );
          }

          if (state is HadithError) {
            return Center(child: Text(state.message));
          }

          // Default fallback
          return const MainHadithScreen();
        },
      ),
    );
  }
}
