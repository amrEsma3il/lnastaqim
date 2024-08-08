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
      frequency: const Duration(minutes: 15),
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

  void registerFajrTask() {
    Workmanager().registerPeriodicTask(
      'id10',
      'name10',
      frequency: const Duration(days: 1),
      inputData: {'صلاه الفجر': "صلاه الفجر"},
    );
  }

  void registerDhuhrTask() {
    Workmanager().registerPeriodicTask(
      'id11',
      'name11',
      frequency: const Duration(days: 1),
      inputData: {'صلاه الظهر': "صلاه الظهر"},
    );
  }

  void registerAsrTask() {
    Workmanager().registerPeriodicTask(
      'id12',
      'name12',
      frequency: const Duration(days: 1),
      inputData: {'صلاه العصر': "صلاه العصر"},
    );
  }

  void registerMaghribTask() {
    Workmanager().registerPeriodicTask(
      'id13',
      'name13',
      frequency: const Duration(days: 1),
      inputData: {'صلاه المغرب': "صلاه المغرب"},
    );
  }

  void registerIshaTask() {
    Workmanager().registerPeriodicTask(
      'id14',
      'name14',
      frequency: const Duration(days: 1),
      inputData: {'صلاه العشاء': "صلاه العشاء"},
    );
  }

  //init work manager service
  Future<void> init() async {
    await Workmanager().initialize(actionTask, isInDebugMode: false);
    registerTask();
    registerMoringAndEveningAzkarTask();
    registerFajrTask();
    registerDhuhrTask();
    registerAsrTask();
    registerMaghribTask();
    registerIshaTask();
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
    LocalNotificationService.salahFajrNotification();
    LocalNotificationService.salahDuhrNotification();
    LocalNotificationService.salahAsrNotification();
    LocalNotificationService.salahMagribNotification();
    LocalNotificationService.salahIshaNotification();

    return Future.value(true);
  });
}
