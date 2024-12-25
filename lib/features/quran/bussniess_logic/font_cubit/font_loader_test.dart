// ignore_for_file: avoid_print

import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p ;
import '../../../../core/constants/colors.dart';
import '../../../../core/utilits/functions/toast_message.dart';


class FontService{
  
  static   FontService? _instance ;

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
    return;  // الخط محمل مسبقًا، لا حاجة لتحميله مرة أخرى
  }

  // الحصول على مسار تخزين التطبيق المحلي
     final directory = await getApplicationDocumentsDirectory();
    
  final fontDirectory = 
        Directory('${directory.path}/fonts');

  final fontPath = '${fontDirectory.path}/quran_font_$page.ttf';
  String fileName =p.basename(File(fontPath).path);
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
  }else{
    log("font $fontPath not found" );
  }
}

Future<void> downloadProcess() async {
  // Get the directory where files will be stored

      final directory = await getApplicationDocumentsDirectory();
    
  final fontDirectory = 
        Directory('${directory.path}/fonts');
  await fontDirectory.create(recursive: true);

  // Start the download process in an isolate
 for (int i = 595; i == 604; i++) {
    String fontNum = i.toString().padLeft(3, '0');
    final url = 'https://raw.githubusercontent.com/amrEsma3il/lnastaqim_assets/main/fonts/p2$fontNum.ttf';
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
           showToast("تم الانتهاء من تحميل الخطوط",AppColor.blueColor);


}




//TODO :تقسيم عملية التنزيل الي اجزاء متتالية من القرءان وجعل طول  PAGE VIEW =لعدد صفحات هذه الاجواء المنزلة


Future<void> downloadFontTest()async{
        final directory = await getApplicationDocumentsDirectory();
    
  final fontDirectory = 
        Directory('${directory.path}/fonts');
  await fontDirectory.create(recursive: true);

//     if (await fontDirectory.exists() ) {
//     // الحصول على قائمة الملفات
//     List<FileSystemEntity> files = fontDirectory.listSync();

//     // طباعة المسارات

// if (files.length==604) {
//     log('all fonts dowloaded');
// } else {
  
// }   

//   log('Directory is found!');
  
//   } else {
//     log('Directory not found!');
//   }


 for (var i = 0; i <= 603; i++) {
     String fontNum =( i+1).toString().padLeft(3, '0');
    final url = 'https://raw.githubusercontent.com/amrEsma3il/lnastaqim_assets/main/fonts/p2$fontNum.ttf';
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








loadAllFonts()async{



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

}