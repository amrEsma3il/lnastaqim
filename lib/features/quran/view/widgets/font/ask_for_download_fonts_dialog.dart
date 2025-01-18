import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../config/routing/app_routes_info/app_routes_name.dart';
import '../../../../../core/constants/colors.dart';
import '../../../bussniess_logic/font_cubit/qurn_fonts_downlod_progress_persentage_cubit.dart';
import 'download_progress_dialog.dart';

class AskForDownloadFontsDialog extends StatelessWidget {
  const AskForDownloadFontsDialog({super.key});

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
                content:  Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "يجب تحميل بعض الملفات لتسطيع استخدام المصحف ",
                      style: TextStyle(color: Colors.white70, fontSize: 16.sp),
                    ),
                  ],
                ),
                actionsAlignment: MainAxisAlignment.spaceAround,
                actions: [
                  TextButton(
                      onPressed: () async {
                        log("بدا التحميل");

                        //TODO: show download progresss dialog
                        // await downloadFontTest(context);

                        Get.back();
                         context.read<FontDownloadPercentage>().changePlayingState(isPlaying: true);
            showDialog(
            context: context,
            // barrierDismissible: false,
            builder: (BuildContext context) {
              log(Get.width.toString());

              return const DownloadProgressDialog();
            },
          );
                       

                        await   context.read<FontDownloadPercentage>().downloadFonts();

                        Get.offAllNamed(AppRouteName.home);
                        Get.toNamed(AppRouteName.moshaf);
                        //   Get.toNamed(AppRouteName.moshaf);
                      },
                      child: Text(
                        'تنزيل',
                        style: TextStyle(color: Colors.white, fontSize: 17.sp),
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