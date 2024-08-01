import 'dart:async';
import 'dart:io';
import 'dart:math' as ms;

import 'package:alarm/alarm.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

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

  static void alarmNotification() async {
//  tz.initializeTimeZones();
//     tz.setLocalLocation(tz.getLocation('Africa/Cairo'));
//     var currentTime = tz.TZDateTime.now(tz.local);

    final AlarmSettings alarmSettings = AlarmSettings(
      id: 42,
      dateTime: DateTime.now().add(const Duration(minutes: 1)),
      assetAudioPath: 'assets/sounds/azhan.mp3',
      // loopAudio: true,
      vibrate: true,
      volume: 0.8,
      // fadeDuration: 3.0,
      notificationTitle: 'حان الان موعد اذان الضهر',
      notificationBody:
          '«اللهم رب هذه الدعوة التامة، والصلاة القائمة، آت محمدًا الوسيلة والفضيلة، وابعثه مقامًا محمودًا الذي وعدته؛ حلت له شفاعتي يوم القيامة هذا»',
      enableNotificationOnKill: Platform.isIOS,
    );

    await Alarm.set(alarmSettings: alarmSettings);
  }

  //basic Notification
  static void showBasicNotification() async {
    ms.Random random = ms.Random();
    int randomIndex = random.nextInt(AzkarDataBase.azkarJsonData.length);
    Map<String, String> randomZekr = AzkarDataBase.azkarJsonData[randomIndex];

    AndroidNotificationDetails android = AndroidNotificationDetails(
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
      styleInformation: BigTextStyleInformation(
        randomZekr['zekr']!,
        htmlFormatBigText: true,
        contentTitle: randomZekr['category'],
        htmlFormatContentTitle: true,
        summaryText: 'اذكار وادعية',
        htmlFormatSummaryText: true,
      ),
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

  static void showMorningAndEveningAzkarScheduledNotification() async {
    List<Map<String, String>> azkarNotifications = AzkarDataBase.azkarJsonData;

    NotificationDetails details = const NotificationDetails(
      android: AndroidNotificationDetails(
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
            'Dismiss',
            cancelNotification: true,
          ),
        ],
      ),
    );

    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Africa/Cairo'));
    var currentTimeZone = tz.TZDateTime.now(tz.local);
    var scheduledTime = tz.TZDateTime(
      tz.local,
      currentTimeZone.year,
      currentTimeZone.month,
      currentTimeZone.day,
      currentTimeZone.hour,
      0,
    );

    List<Map<String, String>> filteredAzkar;
    if (currentTimeZone.hour >= 4 && currentTimeZone.hour < 18) {
      // Morning Azkar
      filteredAzkar = azkarNotifications
          .where((azkar) => azkar['category'] == 'أذكار الصباح')
          .toList();
    } else if (currentTimeZone.hour >= 18 && currentTimeZone.hour <= 24) {
      // Evening Azkar
      filteredAzkar = azkarNotifications
          .where((azkar) => azkar['category'] == 'أذكار المساء')
          .toList();
    } else {
      return;
    }

    if (scheduledTime.isBefore(currentTimeZone)) {
      scheduledTime = scheduledTime.add(const Duration(hours: 1));
    }

    // Choose a random Azkar from the filtered list
    if (filteredAzkar.isNotEmpty) {
      ms.Random random = ms.Random();
      int randomIndex = random.nextInt(filteredAzkar.length);
      var azkar = filteredAzkar[randomIndex];

      await flutterLocalNotificationsPlugin.zonedSchedule(
        2, // Unique ID for the notification
        azkar["category"] ?? "الاذكار",
        azkar["zekr"] ?? '',
        scheduledTime,
        details,
        payload: 'zonedSchedule',
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
      );
    }
  }

  static void cancelNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }
}
