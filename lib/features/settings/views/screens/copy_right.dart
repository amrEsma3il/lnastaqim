
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/utilits/functions/toast_message.dart';
import '../../../../core/utilits/services/url_launcher.dart';
import '../../../../core/utilits/widgets/custom_app_bar.dart';
import 'privacy_policy.dart';

class CopyrightScreen extends StatelessWidget {
  const CopyrightScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primary.withValues(alpha: 0.95),
      appBar: const CustomAppBar(title: 'حقوق الملكية'),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: AppColor.primary.withValues(alpha: 0.63),
              width: 1.2,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 24),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Icon(
                      Icons.verified_user_rounded,
                      color: AppColor.primary,
                      size: 55,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: Text(
                      'حقوق الملكية الفكرية',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Amiri',
                        color: AppColor.primary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  Divider(color: Colors.grey.shade300),
                  const SizedBox(height: 8),

                  /// مقدمة
                  _sectionTitle('الملكية الفكرية'),
                  _sectionBody(
                    'جميع حقوق الملكية الفكرية لتطبيق "لنستقيم" محفوظة. يمنع نسخ أو نشر أو توزيع أي جزء من التطبيق، بما في ذلك الأكواد البرمجية، المحتوى النصي، الصوتيات، الصور، أو أي عناصر تصميمية، دون إذن خطي مسبق من إدارة التطبيق.',
                  ),

                  const SizedBox(height: 16),

                  /// الاستخدام الشخصي فقط
                  _sectionTitle('الاستخدام الشخصي فقط'),
                  _sectionBody(
                    'يُسمح باستخدام التطبيق فقط لأغراض شخصية وغير تجارية. يُمنع استخدامه في أي مشروع أو نظام تجاري دون تصريح رسمي.',
                  ),

                  const SizedBox(height: 16),

                  /// التعديلات
                  _sectionTitle('التعديلات والمحتوى'),
                  _sectionBody(
                    'لا يجوز تعديل أو إنشاء أعمال مشتقة من التطبيق أو مكوناته. كما يُمنع إعادة بيع أو دمج أي جزء من التطبيق في خدمات أو تطبيقات أخرى.',
                  ),

                  const SizedBox(height: 16),

                  /// عدم الضمان
                  _sectionTitle('عدم الضمان'),
                  _sectionBody(
                    'يتم تقديم التطبيق كما هو دون أي ضمانات صريحة أو ضمنية. لا تتحمل إدارة التطبيق أي مسؤولية عن أي خسائر أو أضرار ناتجة عن استخدام التطبيق أو الاعتماد عليه.',
                  ),

                  const SizedBox(height: 16),

                  /// التحديثات والتغييرات
                  _sectionTitle('التحديثات والتغييرات'),
                  _sectionBody(
                    'نحتفظ بحق تعديل شروط حقوق الملكية في أي وقت دون إشعار مسبق. ننصح بمراجعتها بشكل دوري.',
                  ),

                  const SizedBox(height: 16),

                  /// التواصل
                  _sectionTitle('التواصل'),
                  _sectionBody(
                    'لأي استفسارات قانونية أو طلبات ترخيص، يُرجى التواصل عبر البريد الإلكتروني:',
                  ),
                  const SizedBox(height: 6),
                  GestureDetector(
                              onTap: () async{
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
                  
                      }           },
                    child: Text(
                      'lnastaqim@gmail.com',
                      style: TextStyle(
                        fontSize: 16,
                 
                        color: AppColor.primary,
                        decoration: TextDecoration.underline,
                      ),
                      textDirection: TextDirection.ltr,
                      textAlign: TextAlign.left,
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// السياسة
                  Center(
                    child: TextButton(
                      onPressed: () {
                        // TODO: Navigate to PrivacyPolicyScreen
                        Get.to(() => PrivacyPolicyScreen());
                      },
                      child: Text(
                        'عرض سياسة الخصوصية',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Amiri',
                          color: AppColor.primary,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  Divider(color: Colors.grey.shade300),
                  const SizedBox(height: 8),

                  /// التحذير
                  Text(
                    '⚠️ يُعد انتهاك أي من هذه الشروط سببًا لاتخاذ إجراءات قانونية.',
                    style: const TextStyle(
                      fontSize: 15,
                     
                      color: Colors.redAccent,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  // const SizedBox(height: 12),
                  // Text(
                  //   'آخر تحديث: 09 يونيو 2025',
                  //   style: const TextStyle(
                  //     fontSize: 14,
                  //     fontFamily: 'Amiri',
                  //     color: Colors.black54,
                  //   ),
                  //   textAlign: TextAlign.center,
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _sectionTitle(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.bold,
        fontFamily: 'Amiri',
        color: AppColor.primary,
      ),
      textAlign: TextAlign.right,
    );
  }

  Widget _sectionBody(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 16,
        height: 1.6,
       
        color: Colors.black87,
      ),
      textAlign: TextAlign.justify,
    );
  }
}

