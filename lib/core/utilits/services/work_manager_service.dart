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

  void registersalahNabiTask(int durationInMinutes) {
    Workmanager().registerPeriodicTask(
      'uniquesalahNabiTask',
      'salahNabiTask',
      frequency: Duration(minutes: durationInMinutes),
      initialDelay:  Duration(minutes: durationInMinutes)

    );
  }

  void registerMoringAndEveningAzkarTask(int durationInMinutes) {
    Workmanager().registerPeriodicTask(
      'uniquemorningAndEveningTask', // المعرف الفريد للمهمة
      'morningAndEveningTask', // اسم المهمة
      frequency: Duration(minutes: durationInMinutes), 
initialDelay:  Duration(minutes: durationInMinutes)
   );
  }

  void registerParyerTimeTask() {
    Workmanager().registerPeriodicTask(
      'uniqueparyerTimeTask',
      'paryerTimeTask',
       frequency: const Duration(days: 1),
       initialDelay: const Duration(minutes: 1)
    );
  }


  //   void registerCancelAllParyerTimeTask() {
  //   Workmanager().registerPeriodicTask(
  //     'uniquecancelAllParyerNotification',
  //     'cancelAllParyerNotification',
  //      frequency: const Duration(minutes: 15),
  //   );
  // }

  // void registerBootTask() {
  //   Workmanager().registerOneOffTask(
  //     "uniqueCancelNotificationsTask", // اسم فريد للمهمة
  //     "cancelNotificationsTask", // اسم المهمة الذي يتم ربطه في callbackDispatcher
  //     constraints: Constraints(
  //       networkType: NetworkType.not_required,
  //       requiresDeviceIdle: false, // لا حاجة لأن يكون الجهاز خاملاً
  //       requiresCharging: false, // لا حاجة للشاحن
  //     ),
  //     initialDelay: const Duration(
  //         seconds: 5), // تأخير التنفيذ بـ 5 ثوانٍ بعد إعادة التشغيل
  //   );
  // }

  //init work manager service
  Future<void> init() async {
    await Workmanager().initialize(actionTask, isInDebugMode: false);
    registersalahNabiTask(15);
    registerMoringAndEveningAzkarTask(15);
    registerParyerTimeTask();
    // registerCancelAllParyerTimeTask();
  }

  void cancelTask(String id) {
    Workmanager().cancelByUniqueName(id);
  }

  void changeSalahNabiDurationTo25m() {
    log("change");
    cancelTask("uniquesalahNabiTask");
    registersalahNabiTask(17);
  }
}

@pragma('vm-entry-point')
void actionTask() {
  Workmanager().executeTask((taskName, inputData) async {
    if (taskName == "paryerTimeTask") {
      log("test from paryerTimeTask");
  await    LocalNotificationService.salahFajrNotification();
   await   LocalNotificationService.salahDuhrNotification();
   await   LocalNotificationService.salahAsrNotification();
   await   LocalNotificationService.salahMagribNotification();
   await   LocalNotificationService.salahIshaNotification();
    } else if (taskName == "morningAndEveningTask") {
  await    LocalNotificationService
          .showMorningAndEveningAzkarScheduledNotification();
    } else if (taskName == "salahNabiTask") {
  await    LocalNotificationService.showSalahNabiNotification();
    } 
    // else if(taskName == "cancelAllParyerNotification"){

    // await  LocalNotificationService.canclAllParyersNotifications();
    // }

    return Future.value(true);
  });
}
