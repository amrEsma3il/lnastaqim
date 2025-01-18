
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import '../../../core/utilits/services/work_manager_service.dart';
import 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  final WorkManagerService _workManagerService;
  NotificationCubit(this._workManagerService) : super(NotificationInitial()) {
    _loadNotificationStates();
  }

  bool isSalahNabiNotification = true;
  bool isAzkarNotification = true;

  void _loadNotificationStates() {
    final box = Hive.box<bool>('notificationBox');
    isSalahNabiNotification = box.get('isSalahNabiNotification', defaultValue: true)!;
    isAzkarNotification = box.get('isAzkarNotification', defaultValue: true)!;
    emit(SaveNotificationState(isSalahNabiNotification: isSalahNabiNotification,isAzkarNotification:  isAzkarNotification));
  }

  void changeSalahNabiNotification() {
    isSalahNabiNotification = !isSalahNabiNotification;
    Hive.box<bool>('notificationBox').put('isSalahNabiNotification', isSalahNabiNotification);
    if (isSalahNabiNotification) {
      _workManagerService.registersalahNabiTask(15);
    } else {
      _workManagerService.cancelTask('id4');
    }
    emit(ChangeSalahNabiNotification());
  }

  void changeAzkarNotification() {
    isAzkarNotification = !isAzkarNotification;
    Hive.box<bool>('notificationBox').put('isAzkarNotification', isAzkarNotification);
    if (isAzkarNotification) {
      _workManagerService.registerMoringAndEveningAzkarTask(15);
    } else {
      _workManagerService.cancelTask('id8');
    }
    emit(ChangeAzkarNotification());
  }

  void changeNotificationTime(int time) {
    emit(ChangeNotificationTime(durationInMinutes: time));
  }

 void reScheduleNotification(int durationInMinutes) {
  // إلغاء المهمة القديمة
  _workManagerService.cancelTask('id8');

  // تسجيل المهمة الجديدة بزمن التكرار المُحدث
  _workManagerService.registerMoringAndEveningAzkarTask(durationInMinutes);
}

}
