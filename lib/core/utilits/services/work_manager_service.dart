import 'package:workmanager/workmanager.dart';

import 'local_notification_service.dart';
// steps
//1.init work manager
//2.excute our task.
//3.register our task in work manager

class WorkManagerService {
  void registerMyTask() async {
    //register my task
    await Workmanager().registerPeriodicTask(
      'id1',
      'show simple notification',
      frequency: const Duration(hours: 2),
    );
  }

  //init work manager service
  Future<void> init() async {
    await Workmanager().initialize(actionTask);
    registerMyTask();
  }

  void cancelTask(String id) {
    Workmanager().cancelByUniqueName(id);
  }
}

@pragma('vm-entry-point')
void actionTask() {
  //show notification
  Workmanager().executeTask((taskName, inputData)  {
  // LocalNotificationService.showBasicNotification();
  LocalNotificationService.showBasicNotification();

    return Future.value(true);
  });
}

//1.schedule notification at 9 pm.
//2.execute for this notification.
