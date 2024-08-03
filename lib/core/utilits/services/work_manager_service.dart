import 'dart:developer';

import 'package:workmanager/workmanager.dart';

import '../../../features/paryer_times/bussniess_logic/date_cubit.dart';
import '../../../features/paryer_times/bussniess_logic/prayers_times_cubit.dart';
import '../../../main.dart';
import 'local_notification_service.dart';
// steps
//1.init work manager
//2.excute our task.
//3.register our task in work manager

class WorkManagerService {
  void registerMyTask() async {
        // push_notification  task 
    Workmanager().registerPeriodicTask(
      'push_notification',
      'push_notification',
       frequency: const Duration(minutes: 70),// Frequency of the task
    );

    // update ui task 
    Workmanager().registerPeriodicTask(
      'update_ui',
      'update_ui',
      frequency: const Duration(minutes: 1),  // Frequency of the task
      // initialDelay: calculateInitialDelay(targetHour: 23, targetMinute: 59),  // Delay before the first execution
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


  Duration calculateInitialDelay({required int targetHour, required int targetMinute}) {
  final now = DateTime.now();
  var targetTime =DateTime(now.year, now.month, now.day, targetHour, targetMinute).add( const Duration(minutes: 1));

  // If the current time is after the target time, schedule for the next day
  // if (now.isAfter(targetTime)) {
  //   targetTime = targetTime.add(Duration(days: 1));
  // }

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

  Workmanager().executeTask((taskName, inputData)  {
  // LocalNotificationService.showBasicNotification();
 

switch (taskName) {
      case 'push_notification':
        LocalNotificationService.showBasicNotification();
        // Your background task 1 code here
        break;
      case 'update_ui':
      // DateTime now=DateTime.now();
      // DateTime tar
      // if(now.hour==){

      // }
      final context = Lnastaqim.navigatorKey.currentContext;
        PrayersTimesCubit.get(context!).fetchPrayersTimes();
        DateCubit.get(context).getDates();
        // Your background task 2 code here
        break;
    }
    return Future.value(true);
  });
}

//1.schedule notification at 9 pm.
//2.execute for this notification.
