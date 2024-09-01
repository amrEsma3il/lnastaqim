import 'package:flutter/material.dart';
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
            const Image(
              fit: BoxFit.fill,
              image: AssetImage(AppImages.notificationScreenBackground),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
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
                  const SizedBox(height: 20),
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
