import 'dart:developer';
import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import '../../../../config/routing/app_routes_info/app_routes_name.dart';
import '../../../../core/utilits/services/audio_service/players_key.dart';
import '../../../../core/utilits/services/local_notification_service.dart';
import '../../../../main.dart';
import 'qurn_fonts_downlod_progress_persentage_state.dart';
import 'package:http/http.dart' as http;

class FontDownloadPercentage extends Cubit<FontDownloadState> {









  Map<String, String> loadedFonts = {};
  static const int total = 603;
  static int pointer = 0; // العدد الكلي للعناصر
  static bool isStartDownload = false;

  ReceivePort? receivePort;

  static final FontDownloadPercentage _instance = FontDownloadPercentage._internal();

  factory FontDownloadPercentage() {
    return _instance;
  }

  FontDownloadPercentage._internal() : super(FontDownloadState.init()) {
    registerPort();
  }

  Future<void> registerPort() async {
    receivePort = ReceivePort();
    IsolateNameServer.registerPortWithName(
      receivePort!.sendPort,
      NotificationKeys.quranDownload,
    );

    receivePort!.listen((message) async {
      log('Received quran download message: $message');
      await _handleNotificationAction(message);
    });
  }

  Future<void> _handleNotificationAction(String action) async {
    switch (action) {
      case 'play':
        log("action  quran download play");
       log("تغيير حالة التحميل");
             togglePlayPause();

              await   downloadFonts();
            

                
                if (state.isFinished ) {

                  log("انا برا يباشا");
                  Get.offAllNamed(AppRouteName.layout);
                  Get.toNamed(AppRouteName.moshaf);
                }
              
 

        break;
      case 'pause':
       log("action  quran download pause");
       log("تغيير حالة التحميل");
             togglePlayPause();

              await   downloadFonts();
            

                
                if (state.isFinished ) {

                  log("انا برا يباشا");
                  Get.offAllNamed(AppRouteName.layout);
                  Get.toNamed(AppRouteName.moshaf);
                }
              
        break;
    }
  }

  // static FontDownloadPercentage get(BuildContext context) =>
  //     BlocProvider.of<FontDownloadPercentage>(context);

  // تبديل حالة التشغيل والإيقاف
  void togglePlayPause() {
    emit(state.copyWith(isPlaying: !state.isPlaying));
  }

  // إعادة ضبط الحالة
  void resetDownload() {
    emit(state.copyWith(
      percentage: 0,
      isPlaying: false,
    ));
  }

  changePlayingState({
    bool? isFinished,
    bool? isPlaying,
  }) {
    emit(state.copyWith(
        isPlaying: isPlaying ?? state.isPlaying,
        isFinished: isFinished ?? state.isFinished));
  }

  void getPercentage(int value) {
    if (!state.isPlaying) {
      log("Download paused, cannot proceed.");
      return;
    }

    final double percent = value / 135.0;
    // log("Percentage updated: ${percent * 100}%");

    emit(state.copyWith(percentage: percent));
  }

//==========================

  Future<void> downloadFonts() async {
    FontDownloadPercentage.isStartDownload = true;
    final directory = await getApplicationDocumentsDirectory();
    final fontDirectory = Directory('${directory.path}/fonts');
    await fontDirectory.create(recursive: true);

     
     

      while (FontDownloadPercentage.pointer <= FontDownloadPercentage.total) {
        const double totalSize = 135.0; // الحجم الكلي بالميجابايت
        double progressInMBS =
            (totalSize / 603) * FontDownloadPercentage.pointer;
        final String progressText =
            '${((progressInMBS.toInt() / totalSize) * 100).toStringAsFixed(0)}% - ${progressInMBS.toStringAsFixed(1)} MB / ${totalSize.toStringAsFixed(0)} MB';

        if (!state.isPlaying) {
          // إذا تم إيقاف التحميل مؤقتًا

          await LocalNotificationService.downloadNotification(
           groupKey: "quranDownloadAndLoad",
              title: 'تحميل المصحف',
            keyFeature: NotificationKeys.quranDownload,
            hasAction: true,
            isPlaying: false,
            progress: progressInMBS.toInt(),
            maxProgress: totalSize.toInt(),
            id: 604,
            progressText: progressText,
          );

          log('Paused at font ${FontDownloadPercentage.pointer}');
          break;
        }

        String fontNum =
            (FontDownloadPercentage.pointer + 1).toString().padLeft(3, '0');
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
            await LocalNotificationService.downloadNotification(
               groupKey: "quranDownloadAndLoad",
                title: 'تحميل المصحف',
              keyFeature: NotificationKeys.quranDownload,
              hasAction: true,
              isPlaying: false,
              progress: progressInMBS.toInt(),
              maxProgress: totalSize.toInt(),
              id: 604,
              progressText: progressText,
            );
            log('Error downloading font $fontNum: $e');
            break;
          }
        } else {
          log('Font $fontNum already exists.');
        }

        await loadAllFonts(fontNum: fontNum, fontPath: fontPath);

        // تحديث النسبة المئوية في الـ Cubit
        getPercentage(progressInMBS.toInt());

        // حساب التقدم بالنسب المئوية والميجابايت

        await LocalNotificationService.downloadNotification(
          groupKey: "quranDownloadAndLoad",
          title: 'تحميل المصحف',
          keyFeature: NotificationKeys.quranDownload,
          hasAction: true,
          isPlaying: true,
          progress: progressInMBS.toInt(),
          maxProgress: totalSize.toInt(),
          id: 604,
          progressText: progressText,
        );

        if (progressInMBS >= totalSize) {
          LocalNotificationService.cancelNotification(604);
          await LocalNotificationService.showCompletionNotification(606,"تم تحميل المصحف بنجاح");
          break;
        }

        FontDownloadPercentage.pointer++;
      }

      // إذا اكتمل التحميل
      if (FontDownloadPercentage.pointer == FontDownloadPercentage.total) {
        changePlayingState(isFinished: true);
        prefs.setBool("quranFintsSownload", true);
      }
    
  }

  loadAllFonts({required String fontNum, required String fontPath}) async {
    if (loadedFonts.containsKey(fontNum)) {
      log("font $fontNum already loaded befor");

      // الخط محمل مسبقًا، لا حاجة لتحميله مرة أخرى
    } else {
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
  }

//===================================

  Future<void> loadFontsIndividually() async {
    for (var i = 603; i >= 0; i--) {
      String fontNum = (i + 1).toString().padLeft(3, '0');

      if (loadedFonts.containsKey(fontNum)) {
        log("font $fontNum already loaded befor");

        continue; // الخط محمل مسبقًا، لا حاجة لتحميله مرة أخرى
      }

      // الحصول على مسار تخزين التطبيق المحلي
      final directory = await getApplicationDocumentsDirectory();

      final fontDirectory = Directory('${directory.path}/fonts');

      final fontPath = '${fontDirectory.path}/quran_font_$fontNum.ttf';

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
      } else {
        log("font $fontPath not found");
      }
    }
  }

  Future<bool> checkAnyChapterDownloaded() async {
    return prefs.getBool("quranFintsSownload") ?? false;
  }

  //==============================================================
}
