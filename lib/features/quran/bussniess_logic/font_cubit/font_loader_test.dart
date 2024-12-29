// ignore_for_file: avoid_print

import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'dart:math' as m;
import '../../../../config/routing/app_routes_info/app_routes_name.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/utilits/functions/toast_message.dart';
import '../../../../core/utilits/services/local_notification_service.dart';
import '../../../../main.dart';
import 'qurn_fonts_downlod_progress_persentage_cubit.dart';

class FontService {
  static FontService? _instance;

  // Factory constructor to return the same instance
  static FontService getfontServiceInstance() {
    _instance ??= FontService._internal();
    return _instance!;
  }

  // Private constructor
  FontService._internal();

  Map<String, String> loadedFonts = {};

//TODO: عمل SHIMMER EFFECT لحين عمل لودينج لملف الخط

  Future<void> loadFont(String page) async {
    // تحقق إذا كان الخط محمل بالفعل
    if (loadedFonts.containsKey(page)) {
      return; // الخط محمل مسبقًا، لا حاجة لتحميله مرة أخرى
    }

    // الحصول على مسار تخزين التطبيق المحلي
    final directory = await getApplicationDocumentsDirectory();

    final fontDirectory = Directory('${directory.path}/fonts');

    final fontPath = '${fontDirectory.path}/quran_font_$page.ttf';
    String fileName = p.basename(File(fontPath).path);
    log("font page=========>$page");

    log('File name: $fileName');
    // قراءة ملف الخط من التخزين المحلي
    final fontFile = File(fontPath);
    if (fontFile.existsSync()) {
      log(fontFile.path);
      // قراءة بيانات الخط كـ bytes
      final fontData = await fontFile.readAsBytes();

      // إنشاء FontLoader وربطه باسم مميز للخط (quran_font_$page)
      final fontLoader = FontLoader('quran_font_$page');

      // إضافة بيانات الخط إلى FontLoader
      fontLoader.addFont(Future.value(ByteData.view(fontData.buffer)));

      // تحميل الخط وتسجيله في الـ engine
      await fontLoader.load();

      // إضافة الخط إلى قائمة الخطوط المحملة
      loadedFonts[page] = 'quran_font_$page';

      log('Font for page $page loaded.');
    } else {
      log("font $fontPath not found");
    }
  }

  Future<void> downloadProcess() async {
    // Get the directory where files will be stored

    final directory = await getApplicationDocumentsDirectory();

    final fontDirectory = Directory('${directory.path}/fonts');
    await fontDirectory.create(recursive: true);

    // Start the download process in an isolate
    for (int i = 595; i == 604; i++) {
      String fontNum = i.toString().padLeft(3, '0');
      final url =
          'https://raw.githubusercontent.com/amrEsma3il/lnastaqim_assets/main/fonts/p2$fontNum.ttf';
      final fontPath = '${fontDirectory.path}/quran_font_$fontNum.ttf';

      if (!await File(fontPath).exists()) {
        try {
          final response = await http.get(Uri.parse(url));
          if (response.statusCode == 200) {
            final file = File(fontPath);
            await file.create(recursive: true);
            await file.writeAsBytes(response.bodyBytes);
            log('Downloaded: $fontNum');
          } else {
            log('Failed to download font $fontNum: ${response.statusCode}');
          }
        } catch (e) {
          log('Error downloading font $fontNum: $e');
        }
      } else {
        log('Font $fontNum already exists.');
      }
    }
    log('انتهت عملية التحميل');
    showToast("تم الانتهاء من تحميل الخطوط", AppColor.blueColor);
  }

//TODO :تقسيم عملية التنزيل الي اجزاء متتالية من القرءان وجعل طول  PAGE VIEW =لعدد صفحات هذه الاجواء المنزلة

  Future<void> downloadFontTest(BuildContext context) async {
    final directory = await getApplicationDocumentsDirectory();

    final fontDirectory = Directory('${directory.path}/fonts');
    await fontDirectory.create(recursive: true);


    for (var i = 0; i <= 603; i++) {
      String fontNum = (i + 1).toString().padLeft(3, '0');
      final url =
          'https://raw.githubusercontent.com/amrEsma3il/lnastaqim_assets/main/fonts/p2$fontNum.ttf';
      final fontPath = '${fontDirectory.path}/quran_font_$fontNum.ttf';

      if (!await File(fontPath).exists()) {
        try {
          final response = await http.get(Uri.parse(url));
          if (response.statusCode == 200) {
            final file = File(fontPath);
            await file.create(recursive: true);
            await file.writeAsBytes(response.bodyBytes);
            log('Downloaded: $fontNum');
          
          } else {
            log('Failed to download font $fontNum: ${response.statusCode}');
          }
        } catch (e) {
          log('Error downloading font $fontNum: $e');
        }
      } else {
        log('Font $fontNum already exists.');
      }

         await loadAllFonts(fontNum: fontNum,fontPath: fontPath);
            // if (context.mounted) {
            //   FontDownloadPercentage.get(context).getPercentage(i);
            // }



// navigatorKey.currentContext!.read<FontDownloadPercentage>().getPercentage(i);


            FontDownloadPercentage.get(navigatorKey.currentContext!).getPercentage(i);


            LocalNotificationService.downloadNotification(((i/603) * 100).toInt());

    }
   
      prefs.setBool("quranFintsSownload", true);
  }

// Function that runs in an isolate
// Future<void> downloadFontsInIsolate(String directoryPath) async {
//   for (int i = 590; i == 604; i++) {
//     String fontNum = i.toString().padLeft(3, '0');
//     final url = 'https://raw.githubusercontent.com/amrEsma3il/lnastaqim_assets/main/fonts/p2$fontNum.ttf';
//     final fontPath = '$directoryPath/quran_font_$fontNum.ttf';

//     if (!await File(fontPath).exists()) {
//       try {
//         final response = await http.get(Uri.parse(url));
//         if (response.statusCode == 200) {
//           final file = File(fontPath);
//           await file.create(recursive: true);
//           await file.writeAsBytes(response.bodyBytes);
//           log('Downloaded: $fontNum');
//         } else {
//           log('Failed to download font $fontNum: ${response.statusCode}');
//         }
//       } catch (e) {
//         log('Error downloading font $fontNum: $e');
//       }
//     } else {
//       log('Font $fontNum already exists.');
//     }
//   }
//         log('انتهت عملية التحميل');
//     // showToast("تم الانتهاء من تحميل الخطوط",AppColor.blueColor);
// }

  loadAllFonts({required String fontNum,required String fontPath}) async {
    
      // String fontNum = (index + 1).toString().padLeft(3, '0');

      if (loadedFonts.containsKey(fontNum)) {
        log("font $fontNum already loaded befor");

    // الخط محمل مسبقًا، لا حاجة لتحميله مرة أخرى
      }else{
      //    final directory = await getApplicationDocumentsDirectory();

      // final fontDirectory = Directory('${directory.path}/fonts');

      // final fontPath = '${fontDirectory.path}/quran_font_$fontNum.ttf';


        final fontFile = File(fontPath);
      if (fontFile.existsSync()) {
        log(fontFile.path);
        // قراءة بيانات الخط كـ bytes
        final fontData = await fontFile.readAsBytes();

        // إنشاء FontLoader وربطه باسم مميز للخط (quran_font_$page)
        final fontLoader = FontLoader('quran_font_$fontNum');

        // إضافة بيانات الخط إلى FontLoader
        fontLoader.addFont(Future.value(ByteData.view(fontData.buffer)));

        // تحميل الخط وتسجيله في الـ engine
        await fontLoader.load();

        // إضافة الخط إلى قائمة الخطوط المحملة
        loadedFonts[fontNum] = 'quran_font_$fontNum';

        log('Font for page $fontNum loaded.');
      } else {
        log("font $fontPath not found");
      
    }
      }

      // الحصول على مسار تخزين التطبيق المحلي
     
      // String fileName =p.basename(File(fontPath).path);
      //   log("font page=========>$fontNum");

      // log('File name: $fileName');
      // قراءة ملف الخط من التخزين المحلي
    
  }






Future<void>loadFontsIndividually()async{



  for (var i = 0; i <= 603; i++) {
         String fontNum =( i+1).toString().padLeft(3, '0');

      if (loadedFonts.containsKey(fontNum)) {
            log("font $fontNum already loaded befor" );

    continue;  // الخط محمل مسبقًا، لا حاجة لتحميله مرة أخرى
  }

  // الحصول على مسار تخزين التطبيق المحلي
     final directory = await getApplicationDocumentsDirectory();
    
  final fontDirectory = 
        Directory('${directory.path}/fonts');

  final fontPath = '${fontDirectory.path}/quran_font_$fontNum.ttf';
  // String fileName =p.basename(File(fontPath).path);
  //   log("font page=========>$fontNum");

  // log('File name: $fileName');
  // قراءة ملف الخط من التخزين المحلي
  final fontFile = File(fontPath);
  if (fontFile.existsSync()) {
    log(fontFile.path);
    // قراءة بيانات الخط كـ bytes
    final fontData = await fontFile.readAsBytes();

    // إنشاء FontLoader وربطه باسم مميز للخط (quran_font_$page)
    final fontLoader = FontLoader('quran_font_$fontNum');
    
    // إضافة بيانات الخط إلى FontLoader
    fontLoader.addFont(Future.value(ByteData.view(fontData.buffer)));

    // تحميل الخط وتسجيله في الـ engine
    await fontLoader.load();

    // إضافة الخط إلى قائمة الخطوط المحملة
    loadedFonts[fontNum] = 'quran_font_$fontNum';
    
    log('Font for page $fontNum loaded.');
  }else{
    log("font $fontPath not found" );
  }
  }


}



  Future<void> loadDownloadedFontsFirstTimeOpenApp() async {
    final directory = await getApplicationDocumentsDirectory();

    final fontDirectory = Directory('${directory.path}/fonts');

    final List<FileSystemEntity> files = fontDirectory.listSync();

    if (files.isNotEmpty) {
      if (loadedFonts.length < files.length) {
        // start = diffrence
        // int start=files.length-loadedFonts.length;
        loadFontsIndividually();
      }
    } else {
            log("لا توجد خطوط ");

      // return;
    }

// 23 = number of pages in first chapter
  }


Future<bool>checkfileExisit()async{
  final directory = await getApplicationDocumentsDirectory();

    final fontDirectory = Directory('${directory.path}/fonts');

    final fontPath = '${fontDirectory.path}/quran_font_009.ttf';
    String fileName = p.basename(File(fontPath).path);
    log("font page=========>009");

    log('File name: $fileName');
    // قراءة ملف الخط من التخزين المحلي
    final fontFile = File(fontPath);


return fontFile.existsSync() ;

}


Future<void> downloadFont()async{
        final directory = await getApplicationDocumentsDirectory();
    
  final fontDirectory = 
        Directory('${directory.path}/fonts');
  await fontDirectory.create(recursive: true);


   String fontNum = "009".toString().padLeft(3, '0');
    final url = 'https://raw.githubusercontent.com/amrEsma3il/lnastaqim_assets/main/fonts/p2$fontNum.ttf';
    final fontPath = '${fontDirectory.path}/quran_font_$fontNum.ttf';

    if (!await File(fontPath).exists()) {
      try {
        final response = await http.get(Uri.parse(url));
        if (response.statusCode == 200) {
          final file = File(fontPath);
          await file.create(recursive: true);
          await file.writeAsBytes(response.bodyBytes);
          print('Downloaded: $fontNum');
        } else {
          print('Failed to download font $fontNum: ${response.statusCode}');
        }
      } catch (e) {
        print('Error downloading font $fontNum: $e');
      }
    } else {
      print('Font $fontNum already exists.');
    }
}




 Future<bool> checkAnyChapterDownloaded() async {
    return prefs.getBool("quranFintsSownload") ?? false;
  }






  showFontDownloadDialog(BuildContext context) {
    showDialog(
      context: context,
      // barrierDismissible: false,
      builder: (BuildContext context) {
        log(Get.width.toString());

        return AlertDialog(
          // contentPadding: EdgeInsets.only(left: 20),
          backgroundColor: AppColor.blueColor.withOpacity(0.89),
          // contentPadding: const EdgeInsets.all(20),
          title: const Text(
            "تنزيل المصحف",
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.right,
          ),
          content: SizedBox(
            width: (Get.width),
            height: Get.height / 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "يجب تحميل بعض الملفات لتسطيع استخدام المصحف ",
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
                SizedBox(
                  height: 20.h,
                ),
                DiagonalStripedProgressBar(
                  height: 40.h,
                ),
              ],
            ),
          ),
          actionsAlignment: MainAxisAlignment.spaceAround,
          actions: [
            TextButton(
                onPressed: () async {
                  log("بدا التحميل");
                  await downloadFontTest(context);
                
                  Get.offAllNamed(AppRouteName.home);
                    Get.toNamed(AppRouteName.moshaf);
                },
                child: Text(
                  'تنزيل',
                  style: TextStyle(color: Colors.white, fontSize: 15.sp),
                )),
            TextButton(
                onPressed: () {
                  Get.offAllNamed(AppRouteName.home);
                },
                child: Text(
                  'خروج',
                  style: TextStyle(color: Colors.white, fontSize: 15.sp),
                ))
          ],
        );
      },
    );
  }
}

class DiagonalStripedProgressBar extends StatelessWidget {
  final double height;

  const DiagonalStripedProgressBar({
    super.key,
    this.height = 20,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.centerLeft,
      children: [
        // الخلفية الرمادية

        Container(
          height: height,
          width: Get.width,
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        // شريط التقدم فقط
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Container(
            height: height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.blue.withOpacity(0.7),
                  Colors.blueAccent.withOpacity(0.6)
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
            child: BlocBuilder<FontDownloadPercentage, double>(
              builder: (context, state) {
                double progressWidth = Get.width * (69.26 / 100) * state;
                return CustomPaint(
                  size: Size(progressWidth, height),
                  painter: _DiagonalStripedPainter(),
                );
              },
            ),
          ),
        ),
        BlocBuilder<FontDownloadPercentage, double>(
          builder: (context, state) {
            return Center(
              child: Text(
                "${(state * 100).toInt()}%",
                style: TextStyle(
                    fontSize: 17.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColor.gray),
              ),
            );
          },
        ),
      ],
    );
  }
}

// رسام مخصص لإضافة الخطوط المائلة فقط للشريط المتقدم
class _DiagonalStripedPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..shader = LinearGradient(
        colors: [
          Colors.blue.withOpacity(0.7),
          Colors.blueAccent.withOpacity(0.5)
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    const double stripeWidth = 14;
    const double spacing = 10;
    final double diagonal =
        m.sqrt(m.pow(size.width, 2) + m.pow(size.height, 2));

    for (double i = -diagonal; i < diagonal; i += stripeWidth + spacing) {
      final path = Path();
      path.moveTo(i, 0);
      path.lineTo(i + stripeWidth, 0);
      path.lineTo(i + stripeWidth - size.height, size.height);
      path.lineTo(i - size.height, size.height);
      path.close();
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
