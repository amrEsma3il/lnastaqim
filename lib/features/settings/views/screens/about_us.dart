import 'dart:developer';

import 'package:flutter/material.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/images.dart';
import '../../../../core/utilits/functions/toast_message.dart';
import '../../../../core/utilits/services/url_launcher.dart';
import '../../../../core/utilits/widgets/custom_app_bar.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primary.withValues(alpha: 0.95),
      appBar: const CustomAppBar(title: 'من نحن'),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColor.primary, width: 1.5),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 12,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // ✅ شعار التطبيق
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      AppImages.splash,
                      height: 80,
                      width: 80,
                      fit: BoxFit.cover,
                      color: AppColor.primary.withValues(alpha: 0.95),
                    ),
                  ),
                  const SizedBox(height: 15),

                  // ✅ اسم التطبيق
                  Text(
                    'تطبيق لنستقيم',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Amiri',
                      color: AppColor.primary,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // ✅ الوصف
                  Text(
                    '''تطبيق "لنستقيم" هو رفيقك اليومي للاستقامة والثبات على الطاعة. يقدم لك أدوات إيمانية متكاملة تشمل:

📖 القرآن الكريم - أذكار المسلم - الأحاديث النبوية  
🕋 القبلة - أوقات الصلاة - المسبحة - الإذاعة  
🌙 التقويم الهجري - تحديات الحفظ - مجتمع تفاعلي

بُني هذا التطبيق بعناية ليكون دافعًا عمليًا لكل من يسعى للتقرب إلى الله في زمن الفتن.''',
                    style: TextStyle(
                      fontSize: 15.5,
                 
                      height: 1.8,
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.justify,
                  ),

                  const SizedBox(height: 30),

                  // ✅ الفريق
                  Divider(thickness: 1, color: Colors.grey[300]),
                  const SizedBox(height: 10),
                  Text(
                    'فريق العمل',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Amiri',
                      color: AppColor.primary,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'هذا العمل نتاج تعاون فريق متميز من ٦ مطورين، عملوا بشغف واحتساب لخدمة هذا الهدف النبيل.\nنسأل الله أن ينفع به.',
                    style: TextStyle(
                      fontSize: 14.5,
                    
                      height: 1.7,
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 30),

                  // ✅ للتواصل
                  Divider(thickness: 1, color: Colors.grey[300]),
                  const SizedBox(height: 10),
                  Text(
                    '📩 للتواصل أو الدعم الفني',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Amiri',
                      color: AppColor.primary,
                    ),
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () async {
                      try {
                        await UrlLauncher.launchToUrl(
                          "https://wa.me/201006539084", // <-- الرقم بصيغة دولية بدون +
                          isExternal: true,
                        );
                      } catch (e) {
                        showToast(
                          'تعذر فتح واتساب. تأكد من وجود التطبيق على جهازك.',
                          AppColor.primary.withValues(alpha: 0.9),
                        );
                      }
                    },
                    child: Text(
                      'اضغط هنا للتواصل عبر واتساب',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () async {
                      try {
                        await UrlLauncher.launchEmail(
                          toEmail: 'lnastaqim@gmail.com',
                          subject: 'استفسار',
                        );
                      } catch (e) {
                              showToast(
                          'تعذر فتح البريد. تأكد من وجود التطبيق على جهازك.',
                          AppColor.primary.withValues(alpha: 0.9),
                        );
                  
                      }
                    },
                    child: Text(
                      'أو عبر البريد: lnastaqim@gmail.com',
                      style: TextStyle(
                        fontSize: 13.5,
                     
                        color: Colors.black87,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
