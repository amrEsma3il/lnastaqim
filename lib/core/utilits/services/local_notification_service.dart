import 'dart:async';
import 'dart:io';
import 'dart:math' as ms;

import 'package:alarm/alarm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../../../features/paryer_times/data/models/prayers_time_model.dart';
import '../../local_database/azkar/azkar_local_database.dart';

class LocalNotificationService {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static StreamController<NotificationResponse> streamController =
      StreamController();
  static PrayersTimeModel? prayerTimesModel;

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

  static bool isTimeEqual(TimeOfDay time1, TimeOfDay time2) {
    return time1.hour == time2.hour && time1.minute == time2.minute;
  }

  static allSalwatNotifications() async {
    NotificationDetails details = const NotificationDetails(
        android: AndroidNotificationDetails(
      'channel_id4',
      'Daily Shduled notification',
      importance: Importance.max,
      priority: Priority.high,
    ));

    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Africa/Cairo'));
    var currentTimeZone = tz.TZDateTime.now(tz.local);
    // var currentTimeOfDay =
    //     TimeOfDay(hour: currentTimeZone.hour, minute: currentTimeZone.minute);
    var fajrTime = parseTime(prayerTimesModel!.fajr);
    var dhuhrTime = parseTime(prayerTimesModel!.dhuhr);
    var asrTime = parseTime(prayerTimesModel!.asr);
    var maghribTime = parseTime(prayerTimesModel!.maghrib);
    var ishaTime = parseTime(prayerTimesModel!.isha);
    if (currentTimeZone.hour == fajrTime.hour &&
        currentTimeZone.minute == fajrTime.minute) {
      var shduledTime = tz.TZDateTime(
          tz.local,
          currentTimeZone.year,
          currentTimeZone.month,
          currentTimeZone.day,
          currentTimeZone.hour,
          currentTimeZone.minute);
      if (shduledTime.isBefore(currentTimeZone)) {
        shduledTime = shduledTime.add(const Duration(days: 1));
      }
      flutterLocalNotificationsPlugin.zonedSchedule(
          2,
          'الصلاه',
          'موعد اذان الفجر  بتوقيت المنصوره',
          payload: 'zonedSchedule',
          shduledTime,
          details,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime);
    }
    if (currentTimeZone.hour > 2 && currentTimeZone.minute > 10) {
      var shduledTime = tz.TZDateTime(
          tz.local,
          currentTimeZone.year,
          currentTimeZone.month,
          currentTimeZone.day,
          currentTimeZone.hour,
          currentTimeZone.minute);
      if (shduledTime.isBefore(currentTimeZone)) {
        shduledTime = shduledTime.add(const Duration(days: 1));
      }
      flutterLocalNotificationsPlugin.zonedSchedule(
          2,
          'الصلاه',
          'موعد اذان الظهر بتوقيت المنصوره',
          payload: 'zonedSchedule',
          shduledTime,
          details,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime);
    }
    if (currentTimeZone.hour == dhuhrTime.hour &&
        currentTimeZone.minute == dhuhrTime.minute) {
      var shduledTime = tz.TZDateTime(
          tz.local,
          currentTimeZone.year,
          currentTimeZone.month,
          currentTimeZone.day,
          currentTimeZone.hour,
          currentTimeZone.minute);
      if (shduledTime.isBefore(currentTimeZone)) {
        shduledTime = shduledTime.add(const Duration(days: 1));
      }
      flutterLocalNotificationsPlugin.zonedSchedule(
          2,
          'الصلاه',
          'موعد اذان العصر بتوقيت المنصوره',
          payload: 'zonedSchedule',
          shduledTime,
          details,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime);
    }
    if (currentTimeZone.hour == 20 && currentTimeZone.minute == 47) {
      var shduledTime = tz.TZDateTime(
          tz.local,
          currentTimeZone.year,
          currentTimeZone.month,
          currentTimeZone.day,
          currentTimeZone.hour,
          currentTimeZone.minute);
      if (shduledTime.isBefore(currentTimeZone)) {
        shduledTime = shduledTime.add(const Duration(days: 1));
      }
      flutterLocalNotificationsPlugin.zonedSchedule(
          2,
          'الصلاه',
          'موعد اذان المغرب بتوقيت المنصوره',
          payload: 'zonedSchedule',
          shduledTime,
          details,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime);
    }
    if (currentTimeZone.hour == 20 && currentTimeZone.minute == 50) {
      var shduledTime = tz.TZDateTime(
          tz.local,
          currentTimeZone.year,
          currentTimeZone.month,
          currentTimeZone.day,
          currentTimeZone.hour,
          currentTimeZone.minute);
      if (shduledTime.isBefore(currentTimeZone)) {
        shduledTime = shduledTime.add(const Duration(days: 1));
      }
      flutterLocalNotificationsPlugin.zonedSchedule(
          2,
          'الصلاه',
          'موعد اذان العشاء بتوقيت المنصوره',
          payload: 'zonedSchedule',
          shduledTime,
          details,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime);
    }
  }

  static void showSalahNabiNotification() {
    NotificationDetails details = const NotificationDetails(
        android: AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      importance: Importance.max,
      priority: Priority.high,
    ));
    flutterLocalNotificationsPlugin.show(
        0,
        'تسابيح',
        'اللهم صل وسلم وزد وبارك على نبينا وحبيبنا محمد.',
        payload: 'basic notification',
        details);
  }

  static void cancelNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }
}
