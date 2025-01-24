
import 'dart:developer';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/constants/sounds.dart';
import '../../../core/utilits/services/audio_service/audio_players.dart';
import '../../../core/utilits/services/audio_service/players_key.dart';
import '../../../core/utilits/services/local_notification_service.dart';
import '../../../core/utilits/services/work_manager_service.dart';
import '../../../main.dart';
import 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {

  
  final WorkManagerService _workManagerService=WorkManagerService();
  final AudioPlayer audioPlayer =
      AudioPlayers().getPlayer(NotificationKeys.quranPlayer);




  static final NotificationCubit _instance = NotificationCubit._internal();

  factory NotificationCubit(){

    return _instance;
  }
    // final LocalNotificationService _localNotificationService;
  NotificationCubit._internal() : super(NotificationState.init()) {
    _loadNotificationStates();
  }



  void _loadNotificationStates() async {
  // قم بتحميل جميع القيم من SharedPreferences
  final prefs = await SharedPreferences.getInstance();

  final azkarNotificationFrequancy = prefs.getInt('morningAndEviningNotificationFrequancy') ?? 15;
  final salahNabiNotificationFrequancy = prefs.getInt('salahNabiNotificationFrequancy') ?? 15;

  final salahNabiNotificationStatus = prefs.getBool('salahNabiNotificationStatus') ?? false;
  final morningAndEviningNotificationStatus = prefs.getBool('morningAndEviningNotificationStatus') ?? false;

  final fajarAlarmStatus = prefs.getBool('fajarAlarmStatus') ?? false;
  final duharAlarmStatus = prefs.getBool('duharAlarmStatus') ?? false;
  final asrAlarmStatus = prefs.getBool('asrAlarmStatus') ?? false;
  final maghribAlarmStatus = prefs.getBool('maghribAlarmStatus') ?? false;
  final ishaAlarmStatus = prefs.getBool('ishaAlarmStatus') ?? false;

  final salahNabiNotificationSound = prefs.getString('salahNabiNotificationSoundState') ?? 'صلي علي محمد';
  final fajarAlarmSound = prefs.getString('fajarAlarmSoundState') ?? 'احمد الطرابلسي';
  final duharAlarmSound = prefs.getString('duharAlarmSoundState') ?? 'علي بن احمد الملا';
  final asrAlarmSound = prefs.getString('asrAlarmSoundState') ?? 'علي بن احمد الملا';
  final maghribAlarmSound = prefs.getString('maghribAlarmSoundState') ?? 'علي بن احمد الملا';
  final ishaAlarmSound = prefs.getString('ishaAlarmSoundState') ?? 'علي بن احمد الملا';

  // قم بإرسال الحالة الجديدة مع جميع القيم المحملة
  emit(state.copyWith(
    morningAndEviningNotificationFrequancy: azkarNotificationFrequancy,
    salahNabiNotificationFrequancy: salahNabiNotificationFrequancy,
    salahNabiNotificationStatus: salahNabiNotificationStatus,
    morningAndEviningNotificationStatus: morningAndEviningNotificationStatus,
    fajarAlarmStatus: fajarAlarmStatus,
    duharAlarmStatus: duharAlarmStatus,
    asrAlarmStatus: asrAlarmStatus,
    maghribAlarmStatus: maghribAlarmStatus,
    ishaAlarmStatus: ishaAlarmStatus,
    salahNabiNotificationSound: salahNabiNotificationSound,
    fajarAlarmSound: fajarAlarmSound,
    duharAlarmSound: duharAlarmSound,
    asrAlarmSound: asrAlarmSound,
    maghribAlarmSound: maghribAlarmSound,
    ishaAlarmSound: ishaAlarmSound,
  ));
}

 void onChangeSliderEvent({int? azkarNotificationFrequancy,int?salahNabiNotificationFrequancy}){
emit(state.copyWith(morningAndEviningNotificationFrequancy:azkarNotificationFrequancy ,salahNabiNotificationFrequancy:salahNabiNotificationFrequancy ));

  }

  Future<void> changeSalahNabiNotificationStatus()async {
    log("change salahNabi status");

emit(state.copyWith(salahNabiNotificationStatus: !state.salahNabiNotificationStatus));


    await prefs.setBool('salahNabiNotificationStatus', state.salahNabiNotificationStatus);

  //  Hive.box<bool>('notificationBox').put('salahNabiNotificationStatus', state.salahNabiNotificationStatus);
    if (state.salahNabiNotificationStatus) {
      log("register");
   await   _workManagerService.registersalahNabiTask(state.salahNabiNotificationFrequancy);
    } else {
        log("cancel");
   await   _workManagerService.cancelTask('uniquesalahNabiTask');
    }
    
  }

  Future<void> changeAzkarNotificationStatus()async {

emit(state.copyWith(morningAndEviningNotificationStatus: !state.morningAndEviningNotificationStatus));



    await prefs.setBool('morningAndEviningNotificationStatus', state.morningAndEviningNotificationStatus);

   // Hive.box<bool>('notificationBox').put('morningAndEviningNotificationStatus', state.morningAndEviningNotificationStatus);
    if (state.morningAndEviningNotificationStatus) {
   await   _workManagerService.registerMoringAndEveningAzkarTask(state.morningAndEviningNotificationFrequancy);
    } else {
   await   _workManagerService.cancelTask('uniquemorningAndEveningTask');
    }
    
  }

Future<void> changeFajrParyerNotificationStatus() async {
  emit(state.copyWith(fajarAlarmStatus: !state.fajarAlarmStatus));


    await prefs.setBool('fajarAlarmStatus', state.fajarAlarmStatus);

 // Hive.box<bool>('notificationBox').put('fajarAlarmStatus', state.fajarAlarmStatus);
  if (state.fajarAlarmStatus) {
    await _workManagerService.registerFajrParyerTimeTask();
  } else {
    await _workManagerService.cancelTask('uniquefajrparyerTimeTask');
  }
}

Future<void> changeDuharParyerNotificationStatus() async {
  emit(state.copyWith(duharAlarmStatus: !state.duharAlarmStatus));




    await prefs.setBool('duharAlarmStatus', state.duharAlarmStatus);

//  Hive.box<bool>('notificationBox').put('duharAlarmStatus', state.duharAlarmStatus);
  if (state.duharAlarmStatus) {
    await _workManagerService.registerDuharParyerTimeTask();
  } else {
    await _workManagerService.cancelTask('uniqueduharparyerTimeTask');
  }
}

Future<void> changeAsrParyerNotificationStatus() async {
  emit(state.copyWith(asrAlarmStatus: !state.asrAlarmStatus));


    await prefs.setBool('asrAlarmStatus', state.asrAlarmStatus);

 // Hive.box<bool>('notificationBox').put('asrAlarmStatus', state.asrAlarmStatus);
  if (state.asrAlarmStatus) {
    await _workManagerService.registerAsrParyerTimeTask();
  } else {
    await _workManagerService.cancelTask('uniqueasrparyerTimeTask');
  }
}

Future<void> changeMaghribParyerNotificationStatus() async {
  emit(state.copyWith(maghribAlarmStatus: !state.maghribAlarmStatus));



    await prefs.setBool('maghribAlarmStatus', state.maghribAlarmStatus);

  //Hive.box<bool>('notificationBox').put('maghribAlarmStatus', state.maghribAlarmStatus);
  if (state.maghribAlarmStatus) {
    await _workManagerService.registerMaghribParyerTimeTask();
  } else {
    await _workManagerService.cancelTask('uniquemaghribparyerTimeTask');
  }
}

Future<void> changeIshaParyerNotificationStatus() async {
  emit(state.copyWith(ishaAlarmStatus: !state.ishaAlarmStatus));





 await prefs.setBool('ishaAlarmStatus', state.ishaAlarmStatus);
  //Hive.box<bool>('notificationBox').put('ishaAlarmStatus', state.ishaAlarmStatus);
  if (state.ishaAlarmStatus) {
    await _workManagerService.registerIshaParyerTimeTask();
  } else {
    await _workManagerService.cancelTask('uniqueishaparyerTimeTask');
  }
}





//=======================================

  Future<void> changeSalahNabiNotificationFrequancy(int frequancy)async {


        log("change salahNabi frequancy =  $frequancy");

    emit(state.copyWith(salahNabiNotificationFrequancy:frequancy ));




    await prefs.setInt('salahNabiNotificationFrequancy', state.salahNabiNotificationFrequancy);


  // Hive.box<int>('notificationBox').put('salahNabiNotificationFrequancy', state.salahNabiNotificationFrequancy);


 await     _workManagerService.cancelTask('uniquesalahNabiTask');

  // تسجيل المهمة الجديدة بزمن التكرار المُحدث
 await _workManagerService.registersalahNabiTask(state.salahNabiNotificationFrequancy);



  }



   Future<void> changeAzkarNotificationFrequancy(int frequancy)async {
    emit(state.copyWith(morningAndEviningNotificationFrequancy:frequancy ));





      await prefs.setInt('morningAndEviningNotificationFrequancy', state.morningAndEviningNotificationFrequancy);

//Hive.box<int>('notificationBox').put('morningAndEviningNotificationFrequancy', state.morningAndEviningNotificationFrequancy);


 await     _workManagerService.cancelTask('uniquemorningAndEveningTask');

  // تسجيل المهمة الجديدة بزمن التكرار المُحدث
 await _workManagerService.registerMoringAndEveningAzkarTask(frequancy);



  }


//===========================================


void changeSoundState({
String? salahNabiNotificationSound,
String? fajarAlarmSound,
String? duharAlarmSound,
String? asrAlarmSound,
String? maghribAlarmSound,
String? ishaAlarmSound}){
emit(state.copyWith(
salahNabiNotificationSound: salahNabiNotificationSound,

fajarAlarmSound: fajarAlarmSound,
duharAlarmSound: duharAlarmSound,
asrAlarmSound: asrAlarmSound,
maghribAlarmSound: maghribAlarmSound,
ishaAlarmSound: ishaAlarmSound));
}

 Future<void> changeSoundSalahNabi() async {

late String sound;
switch (state.salahNabiNotificationSound) {
  case "صلي علي محمد":
    sound="salah_mohamed";
    break;

    case "صلي علي النبي":
    sound="salah_nabi";
    break;

}
  // emit(state.copyWith(salahNabiNotificationSound: sound));
   prefs = await SharedPreferences.getInstance();
   await prefs.setString('salahNabiNotificationSoundState', state.salahNabiNotificationSound);
  await prefs.setString('salahNabiNotificationSound', sound);
log(state.salahNabiNotificationSound);
  await     _workManagerService.cancelTask('uniquesalahNabiTask');

  // تسجيل المهمة الجديدة بزمن التكرار المُحدث
 await _workManagerService.registersalahNabiTask(state.salahNabiNotificationFrequancy);

 // Hive.box<String>('notificationBox').put('salahNabiNotificationSound', state.salahNabiNotificationSound);
 }

Future<void> changeSoundFajrParyer( )async{

late String sound;
switch (state.fajarAlarmSound) {
  case "احمد الطرابلسي":
    sound="ahmed_eltrabolsy_fajr";
    break;
 case "مشاري راشد العفاسي":
    sound="mashari_rashed_fajr";
    break;

    case "عبد الباسط عبد الصمد":
    sound="abdelbassit_fajr";
    break;

}
  
     prefs = await SharedPreferences.getInstance();
     await prefs.setString('fajarAlarmSoundState', state.fajarAlarmSound);
  await prefs.setString('fajarAlarmSound', sound);
log(state.fajarAlarmSound);
  await     _workManagerService.cancelTask('uniquefajrparyerTimeTask');

  // تسجيل المهمة الجديدة بزمن التكرار المُحدث
 await _workManagerService.registerFajrParyerTimeTask();

  //Hive.box<String>('notificationBox').put('fajarAlarmSound', state.fajarAlarmSound);
 }



String azanSoundSelectExceptFajr(String sound){

late String soundSelect;
switch (sound) {
  case "علي بن احمد الملا":
    soundSelect="ali_elmola";
    break;

    case "عبد الباسط عبد الصمد":
    soundSelect="abdelbassit";
    break;


     case "محمد صديق المنشاوي":
    soundSelect="saddik_menshawy";
    break;
 case "مشاري راشد العفاسي":
    soundSelect="mashari_rashed";
    break;


 case "محمد رفعت":
    soundSelect="mohamed_rafeat";
    break;

    case "مصطفي اسماعيل":
    soundSelect="mostafa_esmail";
    break;

        case "ناصر القطامي":
    soundSelect="nasser_katamii";
    break;

}
  
return soundSelect;
}
Future<void>  changeSoundDuharParyer( ) async {

String sound =azanSoundSelectExceptFajr(state.duharAlarmSound);
 
     prefs = await SharedPreferences.getInstance();
       await prefs.setString('duharAlarmSoundState', state.duharAlarmSound);
  await prefs.setString('duharAlarmSound', sound);
log(state.duharAlarmSound);
  await     _workManagerService.cancelTask('uniqueduharparyerTimeTask');

  // تسجيل المهمة الجديدة بزمن التكرار المُحدث
 await _workManagerService.registerDuharParyerTimeTask();
 }
 Future<void> changeSoundAsrParyer( ) async {
String sound =azanSoundSelectExceptFajr(state.asrAlarmSound);

     prefs = await SharedPreferences.getInstance();
       await prefs.setString('asrAlarmSoundState', state.asrAlarmSound);

  await prefs.setString('asrAlarmSound', sound);
log(state.asrAlarmSound);
  await     _workManagerService.cancelTask('uniqueasrparyerTimeTask');

  // تسجيل المهمة الجديدة بزمن التكرار المُحدث
 await _workManagerService.registerAsrParyerTimeTask();

  //Hive.box<String>('notificationBox').put('asrAlarmSound', state.asrAlarmSound);
 }

 Future<void> changeSoundMaghribParyer( ) async {

log("from maghrib");
log(state.maghribAlarmStatus.toString());
String sound =azanSoundSelectExceptFajr(state.maghribAlarmSound);
   prefs = await SharedPreferences.getInstance();
   await prefs.setString('maghribAlarmSoundState', state.maghribAlarmSound);
  await prefs.setString('maghribAlarmSound', sound);
log(state.maghribAlarmSound);
  await     _workManagerService.cancelTask('uniquemaghribparyerTimeTask');

  // تسجيل المهمة الجديدة بزمن التكرار المُحدث
 await _workManagerService.registerMaghribParyerTimeTask();

  //Hive.box<String>('notificationBox').put('maghribAlarmSound', state.maghribAlarmSound);
 }
Future<void>  changeSoundIshaParyer( ) async {

String sound =azanSoundSelectExceptFajr(state.ishaAlarmSound);
   prefs = await SharedPreferences.getInstance();
   await prefs.setString('ishaAlarmSoundState', state.ishaAlarmSound);
  await prefs.setString('ishaAlarmSound', sound);
log(state.ishaAlarmSound);
  await     _workManagerService.cancelTask('uniqueishaparyerTimeTask');

  // تسجيل المهمة الجديدة بزمن التكرار المُحدث
 await _workManagerService.registerIshaParyerTimeTask();

  // Hive.box<String>('notificationBox').put('ishaAlarmSound', state.ishaAlarmSound);
 }




Future<void> playAlarmSound(String sound)async{
await AudioPlayers().pauseAll();

   await audioPlayer.play(AssetSource("${AppSounds.notificationSounds}/$sound.mp3"));
}



Future<void> stopAlarmSound()async{


   await audioPlayer.stop();
}



}
