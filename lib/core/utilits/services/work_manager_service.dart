import 'dart:developer';

import 'package:workmanager/workmanager.dart';

import 'local_notification_service.dart';

class WorkManagerService {
  Future<void> registerMyTask() async {
    // push_notification  task
   await Workmanager().registerPeriodicTask('push_notification', 'push_notification',
        frequency: const Duration(minutes: 60),
        initialDelay: const Duration(minutes: 1) // Frequency of the task
        );
  }

  Future<void> registersalahNabiTask(int durationInMinutes)async {

    log("register task");
  await  Workmanager().registerPeriodicTask(
      'uniquesalahNabiTask',
      'salahNabiTask',
      frequency: Duration(minutes: durationInMinutes),
      initialDelay:  Duration(minutes: durationInMinutes)

    );
  }

  Future<void> registerMoringAndEveningAzkarTask(int durationInMinutes) async{

      log("register azkar task");
   await Workmanager().registerPeriodicTask(
      'uniquemorningAndEveningTask', // المعرف الفريد للمهمة
      'morningAndEveningTask', // اسم المهمة
      frequency: Duration(minutes: durationInMinutes), 
initialDelay:  Duration(minutes: durationInMinutes)
   );
  }

  Future<void> registerFajrParyerTimeTask() async{
    log("register fajr task");
   await Workmanager().registerPeriodicTask(
      'uniquefajrparyerTimeTask',
      'fajrparyerTimeTask',
       frequency: const Duration(days: 1),
    );
  }

  Future<void> registerDuharParyerTimeTask() async{
    log("register  duhar task");
  await  Workmanager().registerPeriodicTask(
      'uniqueduharparyerTimeTask',
      'duharparyerTimeTask',
       frequency: const Duration(days: 1),
    );
  }
    Future<void> registerAsrParyerTimeTask()async {
      log("register asr task");
   await Workmanager().registerPeriodicTask(
      'uniqueasrparyerTimeTask',
      'asrparyerTimeTask',
       frequency: const Duration(days: 1),
    
    );
  }
    Future<void> registerMaghribParyerTimeTask() async{
      log("register maghrib task");
  await  Workmanager().registerPeriodicTask(
      'uniquemaghribparyerTimeTask',
      'maghribparyerTimeTask',
       frequency: const Duration(days: 1),
 
    );
  }
    Future<void> registerIshaParyerTimeTask() async {
      log("register isha task");
   await Workmanager().registerPeriodicTask(
      'uniqueishaparyerTimeTask',
      'ishaparyerTimeTask',
       frequency: const Duration(days: 1),
      
    );
  }


     Future<void> registerTestChangeSoundTimeTask() async {
   await Workmanager().registerPeriodicTask(
      'uniquetestChangeSoundTimeTask',
      'testChangeSoundTimeTask',
       frequency: const Duration(minutes: 15),
      
    );
  }

  //init work manager service
  Future<void> init() async {
    await Workmanager().initialize(actionTask, isInDebugMode: false);
    // registersalahNabiTask(15);
    // registerMoringAndEveningAzkarTask(15);
  }

  Future<void> cancelTask(String id)async {

    log("cancel task");
   await Workmanager().cancelByUniqueName(id);
  }

 
}

@pragma('vm-entry-point')
void actionTask() {
  Workmanager().executeTask((taskName, inputData) async {
    if (taskName == "fajrparyerTimeTask") {
      log("test from paryerTimeTask");
  await    LocalNotificationService.salahFajrNotification();
  
    } else  if (taskName == "duharparyerTimeTask") {
      log("test from paryerTimeTask");
   await   LocalNotificationService.salahDuhrNotification();
    }else  if (taskName == "asrparyerTimeTask") {
      log("test from paryerTimeTask");
   await   LocalNotificationService.salahAsrNotification();
    }else  if (taskName == "maghribparyerTimeTask") {
      log("test from paryerTimeTask");
   await   LocalNotificationService.salahMagribNotification();
    }
    else  if (taskName == "ishaparyerTimeTask") {
      log("test from paryerTimeTask");
   await   LocalNotificationService.salahIshaNotification();
    }
    
    
    
    else if (taskName == "morningAndEveningTask") {
  await    LocalNotificationService
          .showMorningAndEveningAzkarScheduledNotification();
    } else if (taskName == "salahNabiTask") {
  await    LocalNotificationService.showSalahNabiNotification();
    } else if (taskName == "testChangeSoundTimeTask"){

     
 await    LocalNotificationService.testAzanSoundOptionsNotification();
    }
  

    return Future.value(true);
  });
}