import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lnastaqim/core/constants/images.dart';
import 'package:lnastaqim/features/7adis/bussiness_logic/a7adith_cubit.dart';
import 'package:lnastaqim/features/7adis/bussiness_logic/a7adiths_state.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../../../../core/constants/colors.dart';
import 'a7adith_details.dart';
import 'main_a7adith.dart';

class A7adithScreen extends StatelessWidget {
  const A7adithScreen({super.key, required this.bookName});
  final String bookName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HadithCubit, HadithState>(
        builder: (context, state) {
          if (state is HadithLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is HadithDownloadProgress) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding:  EdgeInsets.only(right: 10.w,top: 15.h),
                    child: Align(alignment: Alignment.topRight,
                      child: IconButton(onPressed: () {
                        Get.back();
                      }, icon: Icon(Icons.arrow_back,size: 31,color: 
                      AppColor.primaryBlueColor,)),
                    ),
                  ),
                  const SizedBox(height: 150,),
                  Expanded(
                    child: Center(
                      child: CircularPercentIndicator(
                        radius: 120.0, // You can adjust the size
                        lineWidth: 10.0, // Thickness of the circular line
                        percent: bookName == "bukhari"
                            ? state.progressBukhari
                            : bookName == "muslim"
                                ? state.progressMuslim
                                : bookName == "abudawod"
                                    ? state.progressAbuDawud
                                    : bookName == "nasai"
                                        ? state.progressNasai
                                        : bookName == "tirmidhi"
                                            ? state.progressTirmidhi
                                            : bookName == "ibnmajah"
                                                ? state.progressIbnmajah
                                                : bookName == "darimi"
                                                    ? state.progressDarimi
                                                    : bookName == "malik"
                                                        ? state.progressMalik
                                                        : bookName == "ahmed"
                                                            ? state.progressAhmed
                                                            : 0.0,
                        center: Text(
                          '${((bookName == "bukhari"
                            ? state.progressBukhari
                            : bookName == "muslim"
                                ? state.progressMuslim
                                : bookName == "abudawod"
                                    ? state.progressAbuDawud
                                    : bookName == "nasai"
                                        ? state.progressNasai
                                        : bookName == "tirmidhi"
                                            ? state.progressTirmidhi
                                            : bookName == "ibnmajah"
                                                ? state.progressIbnmajah
                                                : bookName == "darimi"
                                                    ? state.progressDarimi
                                                    : bookName == "malik"
                                                        ? state.progressMalik
                                                        : bookName == "ahmed"
                                                            ? state.progressAhmed
                                                            : 0.0) * 100).toStringAsFixed(0)}%',
                          style: const TextStyle(fontSize: 24.0),
                        ),
                        progressColor: AppColor.blueColor, // Change color as needed
                        backgroundColor: Colors.grey[200]!, // Background color
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else if (state is HadithLoaded) {
            return Scaffold(
              appBar: AppBar(
                foregroundColor: Colors.white,
                backgroundColor: AppColor.primary.withOpacity(0.8),
                title: Row(
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
                ),
              ),
              body: Container(
                width: MediaQuery.sizeOf(context).width,
                height: MediaQuery.sizeOf(context).height,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(AppImages.azkarBackground),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.separated(
                    itemBuilder: (context, index) {
                      return SizedBox(
                        width: double.infinity,
                        child: SizedBox(
                          height: 50,
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (
                                    context,
                                  ) =>
                                          A7adithDetails(
                                            id: index + 1,
                                          )));
                            },
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
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
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        width: 20,
                      );
                    },
                    itemCount: state.hadiths[0].chapters!.length,
                  ),
                ),
              ),
            );
          } else if (state is HadithError) {
            return Center(child: Text(state.message));
          } else {
            return const MainHadithScreen();
          }
        },
      ),
    );
  }
}
