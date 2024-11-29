import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lnastaqim/core/constants/colors.dart';

import '../../../core/constants/images.dart';
import 'widget/azkar_notification.dart';
import 'widget/salah_nabi_notification.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
             Image(width: Get.width,
              fit: BoxFit.cover,
              image: const AssetImage(AppImages.notificationScreenBackground),
            ),
            Padding(
              padding:  EdgeInsets.symmetric(vertical: 20,horizontal: 10.w),
              child: Column(
                children: [
                  Text(
                    'التنبيهات',
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w800,
                        color: AppColor.primary),
                  ),
                  const SalahNabiNotification(),
                   SizedBox(height: 5.h),
                  const AzkarNotification(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
