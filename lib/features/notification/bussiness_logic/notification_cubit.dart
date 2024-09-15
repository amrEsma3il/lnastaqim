import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import '../../../core/utilits/services/work_manager_service.dart';
import 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  final WorkManagerService _workManagerService;

  NotificationCubit(this._workManagerService) : super(NotificationInitial()) {
    _loadNotificationStates();
  }
static NotificationCubit get(BuildContext context)=>BlocProvider.of<NotificationCubit>(context);


  bool isSalahNabiNotification = true;
  bool isAzkarNotification = true;
  int selectedFrequency = 15;
  final List<int> frequencies = [15, 30, 60, 120, 240];

  static const _boxName = 'userPreferences';
  static const _frequencyKey = 'notification_frequency';

  static Future<void> setFrequency(int frequency) async {
    var box = await Hive.openBox(_boxName);
    await box.put(_frequencyKey, frequency);
    await box.close();
  }

  static Future<int> getFrequency() async {
    var box = await Hive.openBox(_boxName);
    int frequency = box.get(_frequencyKey, defaultValue: 15);
    await box.close();
    return frequency;
  }

  void _loadNotificationStates() {
    final box = Hive.box<bool>('notificationBox');
    isSalahNabiNotification =
        box.get('isSalahNabiNotification', defaultValue: true)!;
    isAzkarNotification = box.get('isAzkarNotification', defaultValue: true)!;
    emit(SaveNotificationState(
        isSalahNabiNotification: isSalahNabiNotification,
        isAzkarNotification: isAzkarNotification));
  }

  void changeSalahNabiNotification() {
    isSalahNabiNotification = !isSalahNabiNotification;
    final box = Hive.box<bool>('notificationBox');
    box.put('isSalahNabiNotification', isSalahNabiNotification);

    print('Salah Nabi Notification changed: $isSalahNabiNotification');

    if (isSalahNabiNotification) {
      log('Registering task...');
      _workManagerService.registerTask();
    } else {
      log('Cancelling task...');
      _workManagerService.cancelTask('id4');
    }

    emit(ChangeSalahNabiNotification());
  }

  void changeAzkarNotification() {
    isAzkarNotification = !isAzkarNotification;
    final box = Hive.box<bool>('notificationBox');
    box.put('isAzkarNotification', isAzkarNotification);

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


  reScheduleNotification(int durationInMinutes){
_workManagerService.registerMoringAndEveningAzkarTask(durationInMinutes);

  }
}
