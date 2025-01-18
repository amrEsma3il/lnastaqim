import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../config/routing/app_routes_info/app_routes_name.dart';
import '../../../../../core/constants/colors.dart';
import '../../../bussniess_logic/font_cubit/qurn_fonts_downlod_progress_persentage_cubit.dart';
import '../../../bussniess_logic/font_cubit/qurn_fonts_downlod_progress_persentage_state.dart';
import 'diagonal_striped_progress_bar.dart';

class DownloadProgressDialog extends StatelessWidget {
  const DownloadProgressDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
          // contentPadding: EdgeInsets.only(left: 20),
          backgroundColor: AppColor.blueColor.withOpacity(0.89),
          // contentPadding: const EdgeInsets.all(20),
          title: const Text(
            "تنزيل المصحف",
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.right,
          ),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.min,
            children: [
              DiagonalStripedProgressBar(
                height: 45.h,
              )
            ],
          ),
          actionsAlignment: MainAxisAlignment.spaceAround,
          actions: [
            TextButton(onPressed: () async {
              log("تغيير حالة التحميل");
              context.read<FontDownloadPercentage>().togglePlayPause();

              await   context.read<FontDownloadPercentage>().downloadFonts();
              if (context.mounted) {

                final getState=  context.read<FontDownloadPercentage>().state;
                if (getState.isFinished ) {

                  log("انا برا يباشا");
                  Get.offAllNamed(AppRouteName.home);
                  Get.toNamed(AppRouteName.moshaf);
                }
              }
            }, child: BlocBuilder<FontDownloadPercentage, FontDownloadState>(
              builder: (context, state) {
                return Text(
                  state.isPlaying ? 'ايقاف' : "استئناف",
                  style: TextStyle(color: Colors.white, fontSize: 17.sp),
                );
              },
            )),
            TextButton(
                onPressed: () {
                  Get.offAllNamed(AppRouteName.home);
                },
                child: Text(
                  'الصفحة الرئيسية',
                  style: TextStyle(color: Colors.white, fontSize: 17.sp),
                ))
          ],
        );
  }
}