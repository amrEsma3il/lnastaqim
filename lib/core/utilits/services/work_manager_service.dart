import 'dart:developer';

import 'package:workmanager/workmanager.dart';

import 'local_notification_service.dart';

class WorkManagerService {
  void registerMyTask() async {
    // push_notification  task
    Workmanager().registerPeriodicTask('push_notification', 'push_notification',
        frequency: const Duration(minutes: 60),
        initialDelay: const Duration(minutes: 1) // Frequency of the task
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

  Duration calculateInitialDelay(
      {required int targetHour, required int targetMinute}) {
    final now = DateTime.now();
    var targetTime =
        DateTime(now.year, now.month, now.day, targetHour, targetMinute);

    log("======target========");
    log(targetTime.toString());

    log("==============");
    log("======initial========");
    log(targetTime.difference(now).toString());
    log(targetTime.difference(now).inHours.toString());
    log(targetTime.difference(now).inMinutes.toString());

    log("==============");

    return targetTime.difference(now);
  }
}

@pragma('vm-entry-point')
void actionTask() {
  //show notification

  Workmanager().executeTask((taskName, inputData) {
    // LocalNotificationService.showBasicNotification();

    switch (taskName) {
      case 'push_notification':
        LocalNotificationService.showBasicNotification();
        // Your background task 1 code here
        break;
    }
    return Future.value(true);
  });
}
