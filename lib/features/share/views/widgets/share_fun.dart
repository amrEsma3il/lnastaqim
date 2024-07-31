import "dart:io";

import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:flutter_svg/svg.dart";
import "package:get/get.dart";
import "package:lnastaqim/core/utilits/extensions/arabic_numbers.dart";
import "package:path_provider/path_provider.dart";
import "package:screenshot/screenshot.dart";
import 'package:share_plus/share_plus.dart';

import "../../../quran/bussniess_logic/quran/quran_cubit.dart";
import "../../../quran/data/models/surahs_model.dart";

void shareText(String selectedText) {
  Share.share(selectedText);
}

Future<void> shareAyahAsImage(
    String ayahNumber, BuildContext context, Ayah selectedAyah) async {
  final directory = (await getApplicationDocumentsDirectory()).path;
  final fileName = 'ayah_$ayahNumber}.png';
  final path = '$directory/$fileName';
  var name = QuranCubit.get(context).getSurahNameFromAyah(selectedAyah);
  final cubit = QuranCubit.get(context);
  final screenShotController = ScreenshotController();

  final imageFile = await screenShotController.captureFromWidget(
    Container(
      color: Colors.white,
      child: IntrinsicHeight(
        child: Column(
          children: [
            SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 5.h),
                  child: Stack(alignment: Alignment.center, children: [
                    SvgPicture.asset(
                      'assets/svgs/surah_banner1.svg',
                      height: 44.h,
                      width: Get.width,
                    ), // banner
                    SvgPicture.asset(
                      'assets/svgs/surah_name/00${cubit.getSurahNumberByName(name)}.svg',
                      height: 41.w,
                      width: 250.w,
                    ),
                  ]),
                )),
            SvgPicture.asset(
              'assets/svgs/besmAllah2.svg',
              width: 300.w,
              height: 41.h,
              colorFilter: const ColorFilter.mode(
                  Color.fromARGB(255, 14, 10, 58), BlendMode.srcIn),
            ),
            Text.rich(
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.center,
              TextSpan(
                children: <InlineSpan>[
                  TextSpan(
                    text: "${selectedAyah.text}",
                    style: TextStyle(
                      height: 2.04.h,
                      fontSize: 20.sp,
                      color: Colors.black,
                    ),
                  ),
                  WidgetSpan(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 5.0),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Text(
                            selectedAyah.ayahNumber.toString().toArabic,
                            style: const TextStyle(
                                fontSize: 8, color: Color(0xff404c6e)),
                          ),
                          SvgPicture.asset(
                            'assets/svgs/surah-number.svg',
                            width: 20.w,
                            height: 20.h,
                            colorFilter: const ColorFilter.mode(
                                Color.fromARGB(255, 14, 10, 58),
                                BlendMode.srcIn),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );

  print("..................");
  print(selectedAyah.ayahNumber);
  final file = File(path);
  await file.writeAsBytes(imageFile);

  final xfile = XFile(path);
  await Share.shareXFiles([xfile]);
}

Future<void> shareImage(Uint8List image, String name) async {
  final directory = await getTemporaryDirectory();
  final imagePath = File('${directory.path}/$name.png');
  await imagePath.writeAsBytes(image);

  final XFile file = XFile(imagePath.path);
  Share.shareXFiles(
    [file],
  );
}
