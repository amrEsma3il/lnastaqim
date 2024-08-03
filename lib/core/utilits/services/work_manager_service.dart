import 'package:workmanager/workmanager.dart';

import 'local_notification_service.dart';

class WorkManagerService {
  void registerMyTask() async {
    //register my task
    await Workmanager().registerPeriodicTask(
      'id1',
      'show simple notification',
      frequency: const Duration(hours: 2),
    );
  }

  void registerTask() {
    Workmanager().registerPeriodicTask(
      'id4',
      'name4',
      frequency: const Duration(minutes: 1),
      inputData: {'تسابيح': 'اللهم صل وسلم وزد وبارك على نبينا وحبيبنا محمد.'},
    );
  }

  void registerMoringAndEveningAzkarTask() {
    Workmanager().registerPeriodicTask(
      'id8',
      'name8',
      frequency: const Duration(hours: 1),
      inputData: {
        'تسابيح':
            "بِسْمِ اللهِ الرَّحْمنِ الرَّحِيم\nقُلْ هُوَ ٱللَّهُ أَحَدٌ، ٱللَّهُ ٱلصَّمَدُ، لَمْ يَلِدْ وَلَمْ يُولَدْ، وَلَمْ يَكُن لَّهُۥ كُفُوًا أَحَدٌۢ."
      },
    );
  }

  void registerAllSalwat() {
    Workmanager().registerPeriodicTask(
      'id9',
      'name9',
      frequency: const Duration(minutes: 1),
      inputData: {'الصلوات': "الصلاه"},
    );
  }

  //init work manager service
  Future<void> init() async {
    await Workmanager().initialize(actionTask, isInDebugMode: false);
    registerTask();
    registerMoringAndEveningAzkarTask();
    registerAllSalwat();
  }

  void cancelTask(String id) {
    Workmanager().cancelByUniqueName(id);
  }
}

@pragma('vm-entry-point')
void actionTask() {
  Workmanager().executeTask((taskName, inputData) {
    LocalNotificationService.showSalahNabiNotification();
    LocalNotificationService.showMorningAndEveningAzkarScheduledNotification();
    LocalNotificationService.allSalwatNotifications();

    return Future.value(true);
  });
}
