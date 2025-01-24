// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:math' as ms;
import 'dart:developer';

// import 'package:alarm/alarm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../../../features/notification/bussiness_logic/notification_cubit.dart';
import '../../../features/paryer_times/bussniess_logic/prayers_times_cubit.dart';

import '../../../main.dart';
import '../../local_database/azkar/azkar_local_database.dart';
import 'audio_service/players_key.dart';

class LocalNotificationService {

  static final NotificationCubit notificationCubit=NotificationCubit();
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static StreamController<NotificationResponse> streamController =
      StreamController();

 

  static void onTap(NotificationResponse notificationResponse) {
    streamController.add(notificationResponse);
  }

  @pragma('vm:entry-point')
  static void notificationTapBackground(
      NotificationResponse notificationResponse) async {
    log("hi from onDidReceiveNotificationBackgroundResponse");
    log("before switch case${notificationResponse.actionId}");

    String action = notificationResponse.actionId!;

    await handleMediaAction(action);
  }

  static Future<void> handleMediaAction(String action) async {
    // final cubit = SurahPlayerCubit.get(navigatorKey.currentContext!);

    log("navigator key${navigatorKey.currentContext}");
    switch (action) {
      case 'play':
        log('play sound');
        // await  cubit.togglePlayPause();
        await LocalNotificationService.showMediaNotification(
              groupKey: "quran",

          isPlaying: true,
          id: 30,
          keyFeature: NotificationKeys.quranPlayer,
        );
        break;
      case 'pause':
        log('pause sound');
        await LocalNotificationService.showMediaNotification(
              groupKey: "quran",

          isPlaying: false,
          id: 30,
          keyFeature: NotificationKeys.quranPlayer,
        );

        //  await   cubit.togglePlayPause();
        break;
      case 'next':
        log('next sound');
        // await  cubit.nextSurah();
        break;
      case 'previous':
        log('previous sound');
        //  await   cubit.previousSurah();
        break;
    }
  }

  static Future<void> requestNotificationPermission() async {
    final bool granted = await flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin>()
            ?.areNotificationsEnabled() ??
        false;

    // final bool? granted = await flutterLocalNotificationsPlugin
    //     .resolvePlatformSpecificImplementation<
    //         AndroidFlutterLocalNotificationsPlugin>()?.requestNotificationsPermission();

    if (granted == false) {
      final bool? granted = await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.requestNotificationsPermission();

      if (granted!) {
        print('Notification permission granted');
      } else {
        print('Notification permission not enabled');
      }

      // يمكنك عرض حوار أو رسالة هنا إذا تم رفض الإذن
    } else {
      print('Notification permission granted');
    }
  }

  static Future init() async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    InitializationSettings settings = const InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings(),
    );
    await flutterLocalNotificationsPlugin.initialize(settings,
        onDidReceiveNotificationResponse:
            (NotificationResponse notificationResponse) async {
      log("hi from onDidReceiveNotificationResponse");

      log(notificationResponse.actionId.toString());
// if (notificationResponse.actionId == null) {
//   log("action id is null");
// } else {
      await handleMediaAction(notificationResponse.actionId!);

// }
    }, onDidReceiveBackgroundNotificationResponse: notificationTapBackground);
  }

  static Future<void> showMediaNotification(
      {required String keyFeature,
      required   groupKey,
      required int id,
      required bool isPlaying,
      String? body = "محمد صديق المنشاوي مجود",
      String? title = "سورة البقرة"}) async {
// log("show media notification");
    final String playPauseIcon = isPlaying ? 'pause_icon' : 'play_icon';
    // final String playPauseLabel = isPlaying ? 'Pause' : 'Play';
    final String actionId = isPlaying
        ? '${keyFeature}pause'
        : '${keyFeature}play';

    final AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
          groupKey: groupKey,
          // category:AndroidNotificationCategory. reminder,
      'media_player_channel', // يجب أن يتطابق مع معرف القناة
      'Media Player Controls',
      channelDescription: 'Control playback from the notification',
      importance: Importance.low,
      priority: Priority.low,
      showWhen: false,
      icon: 'drawable/quran_notification_icon',
      styleInformation: const MediaStyleInformation(),
      actions: <AndroidNotificationAction>[
        AndroidNotificationAction('${keyFeature}previous', 'previous',
            icon: const DrawableResourceAndroidBitmap('previous_icon'),
            cancelNotification: false),
        AndroidNotificationAction(actionId, actionId,
            icon: DrawableResourceAndroidBitmap(playPauseIcon),
            cancelNotification: false),
        // AndroidNotificationAction('pause', '',icon:DrawableResourceAndroidBitmap('pause_icon')),
        AndroidNotificationAction('${keyFeature}next', 'next',
            icon: const DrawableResourceAndroidBitmap('next_icon'),
            cancelNotification: false),
      ],
    );

    final NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      id, // معرف الإشعار (يمكن تغييره لتحديث الإشعار لاحقاً)
      title,
      body,
      platformChannelSpecifics,
    );
  }

  static Future<void> downloadNotification(
      {required int progress,
      required String keyFeature,
      required String title,
      required bool isPlaying,
      required bool hasAction,
      required int maxProgress,
      required String groupKey,
      required int id,
      required String progressText}) async {


          
    // final String playPauseLabel = isPlaying ? 'Pause' : 'Play';
    final String actionId = isPlaying
        ? 'ايقاف'
        : 'استئناف';

    //show the notifications.
    final AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails('download_channel', 'Downloads',
        groupKey: groupKey,
            channelDescription: 'progress channel description',
            channelShowBadge: false,
            importance: Importance.low, // تغيير من max إلى default
            priority: Priority.low,
            onlyAlertOnce: true,
            showProgress: true,
            maxProgress: maxProgress,
            progress: progress,
            actions:!hasAction?null: [
                AndroidNotificationAction(actionId,actionId,
            cancelNotification: false),
            ],
            icon: 'drawable/download_icon');

    final NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        id, title, progressText, platformChannelSpecifics,
        payload: 'item x');
  }

  static Future<void> showCompletionNotification(int id,String title) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'download_complete_channel',
      'Downloads_complete',
      channelDescription: 'Download complete',
      channelShowBadge: false,
      importance: Importance.max,
      priority: Priority.high,
      icon: 'drawable/check_icon', // أيقونة إكمال التحميل
    );

    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      id,
     title,
     null,
      platformChannelSpecifics,
      payload: 'complete',
    );
  }

  // static void alarmNotification() async {
  //   final AlarmSettings alarmSettings = AlarmSettings(
  //     id: 42,
  //     dateTime: DateTime.now().add(const Duration(minutes: 1)),
  //     assetAudioPath: 'assets/sounds/azan5.mp3',
  //     vibrate: true,
  //     volume: 0.8,
  //     notificationTitle: 'حان الان موعد اذان الضهر',
  //     notificationBody:
  //         '«اللهم رب هذه الدعوة التامة، والصلاة القائمة، آت محمدًا الوسيلة والفضيلة، وابعثه مقامًا محمودًا الذي وعدته؛ حلت له شفاعتي يوم القيامة هذا»',
  //     enableNotificationOnKill: Platform.isIOS,
  //   );

  //   await Alarm.set(alarmSettings: alarmSettings);
  // }

  static Future<void> showBasicNotification(String title, String body) async {
  

    AndroidNotificationDetails android = const AndroidNotificationDetails(
      'id 111',
      'basic notification',
      channelDescription: "body description",
      importance: Importance.max,
      priority: Priority.high,
      ongoing: true,
      autoCancel: false,
     
      sound: RawResourceAndroidNotificationSound('sound'),
      
    );

    NotificationDetails details = NotificationDetails(
      android: android,
    );
    await flutterLocalNotificationsPlugin.show(
      3021,
      title,
      body,
      details,
      payload: "Payload Data",
    );
  }



//====================
static Future<void>testCancelNotificationAutoAfterShow() async {
  

    AndroidNotificationDetails android = const AndroidNotificationDetails(
      'test cancel',
      'basic notification',
      channelDescription: "body description",
      importance: Importance.max,
      priority: Priority.high,
      ongoing: true,
      autoCancel: false,
     
      sound: RawResourceAndroidNotificationSound('azhan5'),
      
    );

    NotificationDetails details = NotificationDetails(
      android: android,
    );
    await flutterLocalNotificationsPlugin.show(
      1010102,
      "test cancel",
      "test auto cancelation",
      details,
      payload: "Payload Data",
    );

  // final currentTime = tz.TZDateTime.now(tz.local);
  // final delay=currentTime + Duration(minutes: 3);


      Future.delayed(const Duration(minutes: 2), () async {
        log("cancel test notification after 2 m");
    await cancelNotification(1010102);
  
  });
  }

//===============================




  static Future<void> testSechduleCancelNotification() async {
    NotificationDetails details = NotificationDetails(
        android: AndroidNotificationDetails(
                    groupKey: "paryers",

            'test4_id14', 'Daily Shduled notification',
            importance: Importance.max,
            priority: Priority.high,
                audioAttributesUsage: AudioAttributesUsage.alarm,
            sound:
                RawResourceAndroidNotificationSound('azhan5'.split('.').first),
            ));
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Africa/Cairo'));
    var currentTimeZone = tz.TZDateTime.now(tz.local);
    // var shduledTime = tz.TZDateTime(
    //     tz.local,
    //     currentTimeZone.year,
    //     currentTimeZone.month,
    //     currentTimeZone.day,
    //     fajrTime.hour,
    //     fajrTime.minute);
    // if (shduledTime.isBefore(currentTimeZone)) {
    //   shduledTime = shduledTime.add(const Duration(days: 1));
    // }
 await   flutterLocalNotificationsPlugin.zonedSchedule(
        1213455,
        "test cancel schedule",
       "test",
        payload: 'zonedSchedule',
        currentTimeZone.add(const Duration(minutes: 1)),
        details,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle);



  // final delay = (currentTimeZone.add(const Duration(minutes: 1))).difference(currentTimeZone) + const Duration(minutes: 3);

  // log(delay.inMinutes.toString());

  //  Future.delayed(delay, () async {
  //       log("cancel test schedule notification after 3 m");
  //   await cancelNotification(1213455);
  
  // });


await scheduleNotificationCancellationAt(id:1213455,
currentTime: currentTimeZone,

scheduledTime: (currentTimeZone.add(const Duration(minutes: 1))),);  
  }


//==========================

static Future<void> setSelectedAzanSound(String sound) async {
   prefs = await SharedPreferences.getInstance();
  await prefs.setString('randomAzanSound', sound);
  log("Selected Azan Sound updated to: $sound");
}


static Future<String> getSavedAzanSound() async {
   prefs = await SharedPreferences.getInstance();
  return prefs.getString('randomAzanSound') ?? "azan1"; // الصوت الافتراضي
}


 static Future<void> testAzanSoundOptionsNotification() async {
  log("test");
  String sound = await getSavedAzanSound();
  await cancelNotification(1001001);
  await initializeNotificationChannel('azan_channellll_$sound', 'basic notification', sound);

  AndroidNotificationDetails android = AndroidNotificationDetails(
    'azan_channellll_$sound',
    'basic notification',
    channelDescription: "body description",
    importance: Importance.max,
    priority: Priority.high,
    ongoing: true,
    autoCancel: false,
    sound: RawResourceAndroidNotificationSound(sound),
  );

  NotificationDetails details = NotificationDetails(
    android: android,
  );
  await flutterLocalNotificationsPlugin.show(
    1001001,
    "أذان",
    "حان الآن موعد صلاة العصر",
    details,
    payload: "Payload Data",
  );
}












  static Future<void> showMorningAndEveningAzkarScheduledNotification() async {
    List<Map<String, String>> azkarNotifications = AzkarDataBase.azkarJsonData;

    NotificationDetails details = const NotificationDetails(
      android: AndroidNotificationDetails(
        groupKey: "morningAndEvining",
        'id 1',
        'basic notification',
        channelDescription: "body description",
        importance: Importance.max,
        priority: Priority.high,
        ongoing: true,
        autoCancel: false,
        actions: <AndroidNotificationAction>[
          AndroidNotificationAction(
            'dismiss_action',
            'اغلاق',
            cancelNotification: true,
          ),
        ],
      ),
    );

    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Africa/Cairo'));
    var currentTimeZone = tz.TZDateTime.now(tz.local);
    // var scheduledTime = tz.TZDateTime(
    //   tz.local,
    //   currentTimeZone.year,
    //   currentTimeZone.month,
    //   currentTimeZone.day,
    //   currentTimeZone.hour,
    //   0,
    // );

    List<Map<String, String>> filteredAzkar;
    if (currentTimeZone.hour >= 4 && currentTimeZone.hour < 12) {
      // Morning Azkar
      filteredAzkar = azkarNotifications
          .where((azkar) => azkar['category'] == 'أذكار الصباح')
          .toList();
    } else if ((currentTimeZone.hour >= 19 && currentTimeZone.hour <= 24) || (currentTimeZone.hour >= 1 && currentTimeZone.hour < 3)) {
      // Evening Azkar
      filteredAzkar = azkarNotifications
          .where((azkar) => azkar['category'] == 'أذكار المساء')
          .toList();
    } else {
      return;
    }

    // if (scheduledTime.isBefore(currentTimeZone)) {
    //   scheduledTime = scheduledTime.add(const Duration(hours: 1));
    // }

    // Choose a random Azkar from the filtered list
    if (filteredAzkar.isNotEmpty) {
      ms.Random random = ms.Random();
      int randomIndex = random.nextInt(filteredAzkar.length);
      var azkar = filteredAzkar[randomIndex];

      await flutterLocalNotificationsPlugin.show(
          2, // Unique ID for the notification
          azkar["category"] ?? "الاذكار",
          azkar["zekr"] ?? '',
      
          details,
          payload: 'zonedSchedule',
         );
    }
  }

  static TimeOfDay parseTime(String time) {
    final period = time.endsWith('AM') ? 'AM' : 'PM';
    final timeWithoutPeriod = time.replaceAll(period, '');
    final timeParts = timeWithoutPeriod.split(':');

    int hour = int.parse(timeParts[0].trim());
    final int minute = int.parse(timeParts[1].trim());

    if (period == 'PM' && hour != 12) {
      hour += 12;
    } else if (period == 'AM' && hour == 12) {
      hour = 0;
    }

    return TimeOfDay(hour: hour, minute: minute);
  }

  static var fajrTime = parseTime(PrayersTimesCubit.prayerTimesModel.fajr);
  static var dhuhrTime = parseTime(PrayersTimesCubit.prayerTimesModel.dhuhr);
  static var asrTime = parseTime(PrayersTimesCubit.prayerTimesModel.asr);
  static var maghribTime = parseTime(PrayersTimesCubit.prayerTimesModel.maghrib);
  static var ishaTime = parseTime(PrayersTimesCubit.prayerTimesModel.isha);




  static Future<void> initializeNotificationChannel(String id,String name,String sound) async {
  final AndroidNotificationChannel channel = AndroidNotificationChannel(
   id, // قناة جديدة لكل صوت
    name,
    description: 'Notification for prayer times with custom sound',
    importance: Importance.max,
    sound: RawResourceAndroidNotificationSound(sound),
  );


        await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
}



  static Future<void> showSalahNabiNotification() async{

 prefs = await SharedPreferences.getInstance();
 String sound= prefs.getString('salahNabiNotificationSound') ?? "salah_mohamed"; // الصوت الافتراضي


String id="salahNabiNotification$sound";
String name="salahNabiNotification";

log(sound);

await cancelNotification(30101);
    await initializeNotificationChannel(id,name,sound);
    NotificationDetails details =  NotificationDetails(
      android: AndroidNotificationDetails(
        id,
        name,
        importance: Importance.max,
        priority: Priority.high,
        ongoing: true,
        sound:
             RawResourceAndroidNotificationSound(sound),
             groupKey: 'salahNabi'
      ),
    );
  await  flutterLocalNotificationsPlugin.show(
        30101,
        'ذكر النبي',
        'اللهم صل وسلم وزد وبارك على نبينا وحبيبنا محمد.',
        payload: 'basic notification',
        details);
  }

  static Future<void> cancelNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }


  static Future<void> cancelAllNotification() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }


static Future<void> scheduleNotificationCancellationAt({required
tz.TZDateTime currentTime,
 required   int id,required tz.TZDateTime scheduledTime,Duration delayAfterDisplay=const Duration(minutes: 3)}) async {
  // final currentTime = tz.TZDateTime.now(tz.local);
  final cancelNotificationDelay = scheduledTime.difference(currentTime) + delayAfterDisplay;

  final exactDelay=scheduledTime.difference(currentTime) ;

  if (cancelNotificationDelay.isNegative) {
    log("The notification is already displayed or the time is invalid.");
    return;
  }

log("delay =  "+cancelNotificationDelay.inMinutes.toString());
// log("====================currentTime========$currentTime");
// log("====================scheduledTime========$scheduledTime");

// log("====================delayAfterDisplay========$delayAfterDisplay");

// log("====================delay========$delay");

Future.delayed(exactDelay, () async {
    
 PrayersTimesCubit().fetchPrayersTimes();
  });

  Future.delayed(cancelNotificationDelay, () async {

    await cancelNotification(id);
    log('Notification with ID $id has been cancelled after ${delayAfterDisplay.inMinutes} minutes.');
  });
}




  static Future<void> salahFajrNotification() async {

 prefs = await SharedPreferences.getInstance();
 String sound= prefs.getString('fajarAlarmSound') ?? "ahmed_eltrabolsy_fajr"; // الصوت الافتراضي


String id="fajarAlarmSound$sound";
String name="fajarAlarmSound";

log(sound);

await cancelNotification(5);
    await initializeNotificationChannel(id,name,sound);



    NotificationDetails details = NotificationDetails(
        android: AndroidNotificationDetails(
                    groupKey: "paryers",

     id,name,            importance: Importance.max,
            priority: Priority.high,
                audioAttributesUsage: AudioAttributesUsage.alarm,
            sound:
                RawResourceAndroidNotificationSound(sound),
            ));
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Africa/Cairo'));
    var currentTimeZone = tz.TZDateTime.now(tz.local);
    var shduledTime = tz.TZDateTime(
        tz.local,
        currentTimeZone.year,
        currentTimeZone.month,
        currentTimeZone.day,
        fajrTime.hour,
        fajrTime.minute);
    if (shduledTime.isBefore(currentTimeZone)) {
      shduledTime = shduledTime.add(const Duration(days: 1));
    }
 await   flutterLocalNotificationsPlugin.zonedSchedule(
        5,
        'صلاه الفجر',
        'حان الان موعد اذان الفجر',
        payload: 'zonedSchedule',
        shduledTime,
        details,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle);

await scheduleNotificationCancellationAt(id: 5,scheduledTime: shduledTime,currentTime: currentTimeZone);

  
  }

  static Future<void> salahDuhrNotification()async {


 prefs = await SharedPreferences.getInstance();
 String sound= prefs.getString('duharAlarmSound') ?? "ali_elmola"; // الصوت الافتراضي


String id="duharAlarmSound$sound";
String name="duharAlarmSound";

log(sound);

await cancelNotification(50);
    await initializeNotificationChannel(id,name,sound);


    NotificationDetails details = NotificationDetails(
        android: AndroidNotificationDetails(
                    groupKey: "paryers",

                 id,name,
            importance: Importance.max,
            priority: Priority.high,
                              audioAttributesUsage: AudioAttributesUsage.alarm,
  
            sound:
                RawResourceAndroidNotificationSound(sound),
            ));
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Africa/Cairo'));
    var currentTimeZone = tz.TZDateTime.now(tz.local);
    var shduledTime = tz.TZDateTime(
        tz.local,
        currentTimeZone.year,
        currentTimeZone.month,
        currentTimeZone.day,
        dhuhrTime.hour,
        dhuhrTime.minute);
    if (shduledTime.isBefore(currentTimeZone)) {
      shduledTime = shduledTime.add(const Duration(days: 1));
    }
  await  flutterLocalNotificationsPlugin.zonedSchedule(
        50,
        'صلاه الظهر',
        'حان الان موعد اذان الظهر',
        payload: 'zonedSchedule',
        shduledTime,
        details,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);


            await scheduleNotificationCancellationAt(id: 50,scheduledTime: shduledTime,currentTime: currentTimeZone);



  }

  static Future<void> salahAsrNotification() async{


 prefs = await SharedPreferences.getInstance();
 String sound= prefs.getString('asrAlarmSound') ?? "ali_elmola"; // الصوت الافتراضي


String id="asrAlarmSound$sound";
String name="asrAlarmSound";

log(sound);

await cancelNotification(500);
    await initializeNotificationChannel(id,name,sound);




    NotificationDetails details = NotificationDetails(
        android: AndroidNotificationDetails(
                    groupKey: "paryers",

                 id,name,
            importance: Importance.max,
            priority: Priority.high,
                                audioAttributesUsage: AudioAttributesUsage.alarm,

            sound:
                RawResourceAndroidNotificationSound(sound),
            ));
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Africa/Cairo'));
    var currentTimeZone = tz.TZDateTime.now(tz.local);
    var shduledTime = tz.TZDateTime(
        tz.local,
        currentTimeZone.year,
        currentTimeZone.month,
        currentTimeZone.day,
        asrTime.hour,
        asrTime.minute);
    if (shduledTime.isBefore(currentTimeZone)) {
      shduledTime = shduledTime.add(const Duration(days: 1));
    }
 await   flutterLocalNotificationsPlugin.zonedSchedule(
        500,
        'صلاه العصر',
        'حان الان موعد اذان العصر',
        payload: 'zonedSchedule',
        shduledTime,
        details,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);


            await scheduleNotificationCancellationAt(id: 500,scheduledTime: shduledTime,currentTime: currentTimeZone);


   
  }

  static Future<void> salahMagribNotification() async{




 prefs = await SharedPreferences.getInstance();
 String sound= prefs.getString('maghribAlarmSound') ?? "ali_elmola"; // الصوت الافتراضي


String id="maghribAlarmSound$sound";
String name="maghribAlarmSound";

log(sound);

await cancelNotification(5000);
    await initializeNotificationChannel(id,name,sound);










    NotificationDetails details = NotificationDetails(
        android: AndroidNotificationDetails(
                    groupKey: "paryers",

                 id,name,
            importance: Importance.max,
            priority: Priority.high,
                           audioAttributesUsage: AudioAttributesUsage.alarm,
     
            sound:
                RawResourceAndroidNotificationSound(sound),
            ));
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Africa/Cairo'));
    var currentTimeZone = tz.TZDateTime.now(tz.local);
    var shduledTime = tz.TZDateTime(
        tz.local,
        currentTimeZone.year,
        currentTimeZone.month,
        currentTimeZone.day,
        maghribTime.hour,
        maghribTime.minute);
    if (shduledTime.isBefore(currentTimeZone)) {
      shduledTime = shduledTime.add(const Duration(days: 1));
    }
await    flutterLocalNotificationsPlugin.zonedSchedule(
        5000,
        'صلاه المغرب',
        'حان الان موعد اذان المغرب',
        payload: 'zonedSchedule',
        shduledTime,
        details,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);


            await scheduleNotificationCancellationAt(id: 5000,scheduledTime: shduledTime,currentTime: currentTimeZone);


    
  }

  static Future<void> salahIshaNotification()async {




 prefs = await SharedPreferences.getInstance();
 String sound= prefs.getString('ishaAlarmSound') ?? "ali_elmola"; // الصوت الافتراضي


String id="ishaAlarmSound$sound";
String name="ishaAlarmSound";

log(sound);

await cancelNotification(50000);
    await initializeNotificationChannel(id,name,sound);








    NotificationDetails details = NotificationDetails(
        android: AndroidNotificationDetails(
          groupKey: "paryers",
           id,name,
            importance: Importance.max,
            priority: Priority.high,
                             audioAttributesUsage: AudioAttributesUsage.alarm,
   
            sound:
                RawResourceAndroidNotificationSound(sound),
            ));
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Africa/Cairo'));
    var currentTimeZone = tz.TZDateTime.now(tz.local);
    var shduledTime = tz.TZDateTime(
        tz.local,
        currentTimeZone.year,
        currentTimeZone.month,
        currentTimeZone.day,
        ishaTime.hour,
        ishaTime.minute);
    if (shduledTime.isBefore(currentTimeZone)) {
      shduledTime = shduledTime.add(const Duration(days: 1));
    }
  await  flutterLocalNotificationsPlugin.zonedSchedule(
        50000,
        'صلاه العشاء',
        'حان الان موعد اذان العشاء',
        payload: 'zonedSchedule',
        shduledTime,
        details,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);


            await scheduleNotificationCancellationAt(id: 50000,scheduledTime: shduledTime,currentTime: currentTimeZone);

   
  }




// static Future<void> canclAllParyersNotifications()async{
//   tz.initializeTimeZones();
//     tz.setLocalLocation(tz.getLocation('Africa/Cairo'));
//     var currentTimeZone = tz.TZDateTime.now(tz.local);



//     var fajrShduledTime = tz.TZDateTime(
//         tz.local,
//         currentTimeZone.year,
//         currentTimeZone.month,
//         currentTimeZone.day,
//         fajrTime.hour,
//         fajrTime.minute);
//     if (fajrShduledTime.isBefore(currentTimeZone)) {
//       fajrShduledTime = fajrShduledTime.add(const Duration(days: 1));
//     }

// await scheduleNotificationCancellationAt(id: 5,scheduledTime: fajrShduledTime,
// currentTime: currentTimeZone);

// //==========================

//   var duharShduledTime = tz.TZDateTime(
//         tz.local,
//         currentTimeZone.year,
//         currentTimeZone.month,
//         currentTimeZone.day,
//         dhuhrTime.hour,
//         dhuhrTime.minute);
//     if (duharShduledTime.isBefore(currentTimeZone)) {
//       duharShduledTime = duharShduledTime.add(const Duration(days: 1));
//     }


// await scheduleNotificationCancellationAt(id: 50,scheduledTime: duharShduledTime,
// currentTime: currentTimeZone);

// //======================================

//   var asrShduledTime = tz.TZDateTime(
//         tz.local,
//         currentTimeZone.year,
//         currentTimeZone.month,
//         currentTimeZone.day,
//         asrTime.hour,
//         asrTime.minute);
//     if (asrShduledTime.isBefore(currentTimeZone)) {
//       asrShduledTime = asrShduledTime.add(const Duration(days: 1));
//     }


// await scheduleNotificationCancellationAt(id: 500,scheduledTime: asrShduledTime,
// currentTime: currentTimeZone);



// //===========================




//       var maghribShduledTime = tz.TZDateTime(
//         tz.local,
//         currentTimeZone.year,
//         currentTimeZone.month,
//         currentTimeZone.day,
//         maghribTime.hour,
//         maghribTime.minute);
//     if (maghribShduledTime.isBefore(currentTimeZone)) {
//       maghribShduledTime = maghribShduledTime.add(const Duration(days: 1));
//     }

// await scheduleNotificationCancellationAt(id: 5000,scheduledTime: maghribShduledTime,currentTime: currentTimeZone);


// //==========================



//       var ishaShduledTime = tz.TZDateTime(
//         tz.local,
//         currentTimeZone.year,
//         currentTimeZone.month,
//         currentTimeZone.day,
//         ishaTime.hour,
//         ishaTime.minute);
//     if (ishaShduledTime.isBefore(currentTimeZone)) {
//       ishaShduledTime = ishaShduledTime.add(const Duration(days: 1));
//     }




// await scheduleNotificationCancellationAt(id: 50000,scheduledTime: ishaShduledTime,currentTime: currentTimeZone);




// //=================
// }




}
