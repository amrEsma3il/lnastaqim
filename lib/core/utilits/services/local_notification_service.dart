
import 'dart:async';
import 'dart:io';
import 'package:adhan/adhan.dart';
import 'package:alarm/alarm.dart';

import 'dart:developer';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import 'dart:math' as ms;

import '../../local_database/azkar/azkar_local_database.dart';

class LocalNotificationService {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static StreamController<NotificationResponse> streamController =
      StreamController();
  static onTap(NotificationResponse notificationResponse) {
    // log(notificationResponse.id!.toString());
    // log(notificationResponse.payload!.toString());
    streamController.add(notificationResponse);
    // Navigator.push(context, route);
  }

  static Future init() async {
    InitializationSettings settings = const InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings(),
    );
    flutterLocalNotificationsPlugin.initialize(
      settings,
      onDidReceiveNotificationResponse: onTap,
      onDidReceiveBackgroundNotificationResponse: onTap,
    );
  }


static void alarmNotification()async{
//  tz.initializeTimeZones();
//     tz.setLocalLocation(tz.getLocation('Africa/Cairo'));
//     var currentTime = tz.TZDateTime.now(tz.local);

 final AlarmSettings alarmSettings=AlarmSettings(
  id: 42,
  dateTime: DateTime.now().add(const Duration(minutes: 1)),
  assetAudioPath: 'assets/sounds/azhan.mp3',
  // loopAudio: true,
  vibrate: true,
  volume: 0.8,
  // fadeDuration: 3.0,
  notificationTitle: 'حان الان موعد اذان الضهر',
  notificationBody: '«اللهم رب هذه الدعوة التامة، والصلاة القائمة، آت محمدًا الوسيلة والفضيلة، وابعثه مقامًا محمودًا الذي وعدته؛ حلت له شفاعتي يوم القيامة هذا»',
  enableNotificationOnKill: Platform.isIOS,
);

await Alarm.set(alarmSettings: alarmSettings);
}
  //basic Notification
  static void showBasicNotification() async {
    
               ms.Random random = ms.Random();

         int randomIndex = random.nextInt(AzkarDataBase.azkarJsonData.length);
 Map<String, String> randomZekr= AzkarDataBase.azkarJsonData[randomIndex];


  //  String largeIconPath = await getImageFilePath(AppImages.notificationLargeIcon);
  // String bigPicturePath = await getImageFilePath(AppImages.notificationBigPicture);
    AndroidNotificationDetails android =  AndroidNotificationDetails(
    'id 1',
    'basic notification',
    channelDescription: "body description",
    importance: Importance.max,
    priority: Priority.high,
     ongoing: true,
autoCancel: false,
 actions: <AndroidNotificationAction>[
        const AndroidNotificationAction(
          'dismiss_action',
          'Dismiss',
          cancelNotification: true,
        ),
      ],
    sound: const RawResourceAndroidNotificationSound('sound'),
    // color:  Color.fromARGB(255, 255, 90, 20), // Custom notification color
    // largeIcon: FilePathAndroidBitmap(largeIconPath),
    styleInformation:
    BigTextStyleInformation(
     randomZekr['zekr']!,
    htmlFormatBigText: true,
    contentTitle: randomZekr['category'],
    htmlFormatContentTitle: true,
    summaryText: 'اذكار وادعية',
    htmlFormatSummaryText: true,
  ),
    //  BigPictureStyleInformation(
    //   FilePathAndroidBitmap(bigPicturePath),
    //   largeIcon: FilePathAndroidBitmap(largeIconPath),
    //   // contentTitle: '<b>Custom Title</b>', // HTML formatting for bold text
    //   htmlFormatContentTitle: true,
    //   summaryText: 'Custom Summary Text',
    //   htmlFormatSummaryText: true,
    // ),
  );
    NotificationDetails details = NotificationDetails(
      android: android,
    );

    await flutterLocalNotificationsPlugin.show(

      0,
      randomZekr['category'],
       randomZekr['zekr'],
      details,
      payload: "Payload Data",
    );
  }

  //basic Notification2
  static void showBasicNotification2() async {
    AndroidNotificationDetails android = AndroidNotificationDetails(
        'id 3', 'basic notification1',
        importance: Importance.max,
        priority: Priority.high,
        sound:
            RawResourceAndroidNotificationSound('sound.wav'.split('.').first));
    NotificationDetails details = NotificationDetails(
      android: android,
    );
    await flutterLocalNotificationsPlugin.show(
      4,
      'Basic Notification',
      'body',
      details,
      payload: "Payload Data",
    );
  }

  //showRepeatedNotification
  static void showRepeatedNotification() async {
    const AndroidNotificationDetails android = AndroidNotificationDetails(
      'id 2',
      'repeated notification',
      importance: Importance.max,
      priority: Priority.high,
    );
    NotificationDetails details = const NotificationDetails(
      android: android,
    );
    await flutterLocalNotificationsPlugin.periodicallyShow(
      1,
      'Reapated Notification',
      'body',
      RepeatInterval.daily,
      details,
      payload: "Payload Data",
    );
  }

  //showSchduledNotification
  static void showSchduledNotification() async {
    const AndroidNotificationDetails android = AndroidNotificationDetails(
      'schduled notification',
      'id 3',
      importance: Importance.max,
      priority: Priority.high,
      autoCancel: false,
      ongoing: true,
       sound: RawResourceAndroidNotificationSound('sound'),
    );
    NotificationDetails details = const NotificationDetails(
      android: android,
    );
    tz.initializeTimeZones();
    log(tz.local.name);
    log("Before ${tz.TZDateTime.now(tz.local).hour}");
    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
    log(currentTimeZone);
    tz.setLocalLocation(tz.getLocation(currentTimeZone));
    log(tz.local.name);
        log("After ${tz.TZDateTime.now(tz.getLocation(currentTimeZone)).hour}");
    log("After ${tz.TZDateTime.now(tz.getLocation(currentTimeZone)).minute}");
    await flutterLocalNotificationsPlugin.zonedSchedule(
      2,
      'Schduled Notification',
      'body',
      // tz.TZDateTime.now(tz.local).add(const Duration(minutes: 1)),
      tz.TZDateTime(
        tz.local,
        2024,
        7,
        23,
        19,
        3,
      ),
      details,
      payload: 'zonedSchedule',
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  //showDailySchduledNotification
  static void showDailySchduledNotification() async {
  
    const AndroidNotificationDetails android = AndroidNotificationDetails(
      'daily schduled notification',
      'id 4',
      importance: Importance.max,
      priority: Priority.high,
    );
    NotificationDetails details = const NotificationDetails(
      android: android,
    );
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Africa/Cairo'));
    var currentTime = tz.TZDateTime.now(tz.local);

          final coordinates = Coordinates(31.2156, 29.9553); // Example: Alexandria, Egypt
    final params = CalculationMethod.egyptian.getParameters();
    final prayerTimes = PrayerTimes.today(coordinates, params);

     final localTime = tz.TZDateTime.from(prayerTimes.asr, tz.local);
  log("==========================================");
  log(localTime.timeZoneName);
    log(localTime.year.toString());

    log(localTime.month.toString());

    log(localTime.day.toString());
  log(localTime.hour.toString());

  log(localTime.minute.toString());
  log(localTime.second.toString());

  log("==========================================");   
    log("currentTime.year:${currentTime.year}");
    log("currentTime.month:${currentTime.month}");
    log("currentTime.day:${currentTime.day}");
    log("currentTime.hour:${currentTime.hour}");
    log("currentTime.minute:${currentTime.minute}");
    log("currentTime.second:${currentTime.second}");
    var scheduleTime = tz.TZDateTime( 
      tz.local,
      currentTime.year,
      currentTime.month,
      currentTime.day,
      currentTime.hour,
      currentTime.minute,
      15


     
    );
    log("scheduledTime.year:${scheduleTime.year}");
    log("scheduledTime.month:${scheduleTime.month}");
    log("scheduledTime.day:${scheduleTime.day}");
    log("scheduledTime.hour:${scheduleTime.hour}");
    log("scheduledTime.minute:${scheduleTime.minute}");
    log("scheduledTime.second:${scheduleTime.second}");
    if (scheduleTime.isBefore(currentTime)) {
      scheduleTime = scheduleTime.add(const Duration(minutes: 1));
      log("AfterAddedscheduledTime.year:${scheduleTime.year}");
      log("AfterAddedscheduledTime.month:${scheduleTime.month}");
      log("AfterAddedscheduledTime.day:${scheduleTime.day}");
      log("AfterAddedscheduledTime.hour:${scheduleTime.hour}");
      log("AfterAddedscheduledTime.minute:${scheduleTime.minute}");
      log("AfterAddedscheduledTime.second:${scheduleTime.second}");
      log('Added Duration to scheduled time');
    }
    await flutterLocalNotificationsPlugin.zonedSchedule(
      3,
      'Daily Schduled Notification',
      'body',
      // tz.TZDateTime.now(tz.local).add(const Duration(seconds: 10)),
      scheduleTime,
      details,
      payload: 'zonedSchedule',
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  static void cancelNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }
}

//1.setup. [Done]
//2.Basic Notification. [Done]
//3.Repeated Notification. [Done]
//4.Scheduled Notification. [Done]
//5.Custom Sound. [Done]
//6.on Tab. [Done]
//7.Daily Notifications at specific time. [Done]
//8.Real Example in To Do App.

