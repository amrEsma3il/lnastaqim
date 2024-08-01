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

  //init work manager service
  Future<void> init() async {
    await Workmanager().initialize(actionTask);
    registerMoringAndEveningAzkarTask();
  }

  void cancelTask(String id) {
    Workmanager().cancelByUniqueName(id);
  }
}

@pragma('vm-entry-point')
void actionTask() {
  Workmanager().executeTask((taskName, inputData) {
    LocalNotificationService.showMorningAndEveningAzkarScheduledNotification();

    return Future.value(true);
  });
}
