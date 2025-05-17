import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lnastaqim/core/constants/colors.dart';

import '../../../../core/constants/images.dart';
import '../../bussiness_logic/notification_cubit.dart';
import '../widget/azkar_notification.dart';
import '../widget/paryer_time_notification_component.dart';
import '../widget/salah_nabi_notification.dart';

// class NotificationScreen extends StatelessWidget {
//   const NotificationScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('توقيت الصلاة اليوم', style: TextStyle(fontSize: 18)),
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Image Section
//             Container(
//               margin: const EdgeInsets.all(16),
//               height: 186,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(12),
//                 image: const DecorationImage(
//                   image: AssetImage('assets/images/sand_watch.png'), // ضع صورة هنا
//                   fit: BoxFit.fill,
//                 ),
//               ),
//             ),

//             // Prayer Times Section
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               child: Card(
//                 elevation: 2,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(16),
//                   child: Column(
//                     children: [
//                       for (var prayer in [
//                         {"name": "الفجر", "time": "05:45"},
//                         {"name": "الظهر", "time": "12:05"},
//                         {"name": "العصر", "time": "15:30"},
//                         {"name": "المغرب", "time": "18:05"},
//                         {"name": "العشاء", "time": "19:30"},
//                       ])
//                         ListTile(
//                           leading: const Icon(Icons.access_time, color: Colors.blue),
//                           title: Text(prayer['name']!,
//                               style: const TextStyle(fontSize: 16)),
//                           trailing: Text(prayer['time']!,
//                               style: const TextStyle(fontSize: 16)),
//                           onTap: () {
//                             // أضف حدث الضغط هنا
//                           },
//                         ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),

//             // Notifications Section
//             Padding(
//               padding: const EdgeInsets.all(16),
//               child: Card(
//                 elevation: 2,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: const Padding(
//                   padding: EdgeInsets.all(16),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'تنبيهات',
//                         style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       SizedBox(height: 8),
//                       Text(
//                         'لم تضف أي تنبيهات بعد',
//                         style: TextStyle(fontSize: 16, color: Colors.grey),
//                       ),
//                       SizedBox(height: 16),
//                       Text(
//                         'هنا يمكنك إضافة تنبيهات خاصة بك قبل وبعد كل صلاة مثل التذكير بالتحضر للصلاة أو إقامة الصلاة ووقت التهجد...',
//                         style: TextStyle(fontSize: 14, color: Colors.grey),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }



class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(
        child: Stack(
          children: [
             Image(width: Get.width,
              fit: BoxFit.fill,
              image: const AssetImage(AppImages.notificationScreenBackground),
            ),
            SingleChildScrollView(
              child: Padding(
                padding:  EdgeInsets.symmetric(vertical: 20,horizontal: 15.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [

                        IconButton(onPressed: () {
                          Get.back();
                        }, icon:  Icon(Icons.arrow_back,color: AppColor.primary,size: 28.w,)),
                        Expanded(
                          child: Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding:  EdgeInsets.only(left: 40.w),
                              child: Text(
                                'التنبيهات',
                                style: TextStyle(
                                    fontSize: 26.sp,
                                    fontWeight: FontWeight.w800,
                                    color: AppColor.primary),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 5.h),
                    const SalahNabiNotification(),
                     SizedBox(height: 5.h),
                    const AzkarNotification(),
                    SizedBox(height: 7.h,),
                    Container(width: Get.width,height: 1.5.h,color: AppColor.gray,),
                    SizedBox(height: 13.h,),
              
                    Text(
                      'مواقيت الصلاة',
                      style: TextStyle(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.w800,
                          color: AppColor.primary),
                    ),
                     SizedBox(height: 13.h,),
                    ParyerTimeNotificationComponent(prayerName: "الفجر",
                      
                      submitMethod: () async{
await context.read<NotificationCubit>().stopAlarmSound();

                    if(context.mounted)  { await context.read<NotificationCubit>().changeSoundFajrParyer();}
                      },),
                      SizedBox(height: 5.h,),
              
                       ParyerTimeNotificationComponent(prayerName: "الظهر",
                      
                      submitMethod: ()=>context.read<NotificationCubit>().changeSoundDuharParyer(),),
                      SizedBox(height: 5.h,),
              
                       ParyerTimeNotificationComponent(prayerName: "العصر",
                      
                      submitMethod: ()=>context.read<NotificationCubit>().changeSoundAsrParyer(),),
                      SizedBox(height: 5.h,),
              
                       ParyerTimeNotificationComponent(prayerName: "المغرب",
                      
                      submitMethod: ()=>context.read<NotificationCubit>().changeSoundMaghribParyer(),),
                      SizedBox(height: 5.h,),
              
                       ParyerTimeNotificationComponent(prayerName: "العشاء",
                      
                      submitMethod: ()=>context.read<NotificationCubit>().changeSoundIshaParyer(),),
                      // SizedBox(height: 5.h,),


                      // IconButton(onPressed: () {
                      //   Get.to( () => const AlarmApp());
                      // }, icon:const Icon( Icons.alarm))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}