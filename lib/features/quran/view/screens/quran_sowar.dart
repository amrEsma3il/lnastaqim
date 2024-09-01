// import 'dart:async';

// import 'package:alarm/alarm.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:lnastaqim/core/constants/images.dart';

// import '../../bussniess_logic/quran_sowar/quran_sowar_cubit.dart';
// import '../../data/models/quran_model.dart';
// import '../widgets/bottom_nav_bar.dart';
// import '../widgets/header_quran.dart';
// import '../widgets/quran_sora_component.dart';
// import 'package:permission_handler/permission_handler.dart';


// class QuranSowar extends StatefulWidget {
//   const QuranSowar({super.key});

//   @override
//   State<QuranSowar> createState() => _QuranSowarState();
// }

// class _QuranSowarState extends State<QuranSowar> {
//    late List<AlarmSettings> alarms;

//   // static StreamSubscription<AlarmSettings>? subscription;
//   @override
//   void initState() {
//     super.initState();
//     if (Alarm.android) {
//       checkAndroidNotificationPermission();
//       checkAndroidScheduleExactAlarmPermission();
//     }
//     // loadAlarms();
//     // subscription ??= Alarm.ringStream.stream.listen(navigateToRingScreen);
//   }

// //


// //   Future<void> navigateToRingScreen(AlarmSettings alarmSettings) async {
// //     // await Navigator.push(
// //     //   context,
// //     //   MaterialPageRoute<void>(
// //     //     builder: (context) =>
// //     //         ExampleAlarmRingScreen(alarmSettings: alarmSettings),
// //     //   ),
// //     // );
// //     loadAlarms();
// //   }

// // //

// //   void loadAlarms() {
// //     setState(() {
// //       alarms = Alarm.getAlarms();
// //       alarms.sort((a, b) => a.dateTime.isBefore(b.dateTime) ? 0 : 1);
// //     });
// //   }


//   Future<void> checkAndroidNotificationPermission() async {
//     final status = await Permission.notification.status;
//     if (status.isDenied) {
//       alarmPrint('Requesting notification permission...');
//       final res = await Permission.notification.request();
//       alarmPrint(
//         'Notification permission ${res.isGranted ? '' : 'not '}granted',
//       );
//     }
//   }

 
//   Future<void> checkAndroidScheduleExactAlarmPermission() async {
//     final status = await Permission.scheduleExactAlarm.status;
//     alarmPrint('Schedule exact alarm permission: $status.');
//     if (status.isDenied) {
//       alarmPrint('Requesting schedule exact alarm permission...');
//       final res = await Permission.scheduleExactAlarm.request();
//       alarmPrint(
//         'Schedule exact alarm permission ${res.isGranted ? '' : 'not'} granted',
//       );
//     }
//   }




//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(body: SafeArea(
//       child: BlocBuilder<QuranSowarCubit, List<SoraModel>>(
//         builder: (context, state) {
//           return 
          
//           SizedBox(
//             height: Get.height,
//             child: Stack(
//               children: [
//                 Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 15.w),
//                   child: Column(
//                     children: [
//                       SizedBox(
//                         height: 7.h,
//                       ),
//                       const HeaderSection(),
//                       SizedBox(
//                         height: 10.h,
//                       ),
//                       ClipRRect(
//                           borderRadius: BorderRadius.circular(20.r),
//                           child: Image.asset(
//                             AppImages.headerImage,
//                             width: 363.w,
//                             height: 155.h,
//                           )),
//                       SizedBox(
//                         height: 22.h,
//                       ),
//                       Expanded(
//                         child: Padding(
//                           padding: EdgeInsets.only(bottom: 68.h),
//                           child: ListView.builder(
//                             itemCount: state.length,
//                             itemBuilder: (context, index) => QuranSoraComponent(
//                                 quranAyaEntity: state[index]),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 const BottomNavBar()
//               ],
//             ),
//           );
//         },
//       ),

//     ));
//   }
// }
