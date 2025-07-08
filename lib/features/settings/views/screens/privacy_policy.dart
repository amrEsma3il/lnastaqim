

import 'dart:developer';

import 'package:flutter/material.dart';


import '../../../../core/constants/colors.dart';
import '../../../../core/utilits/functions/toast_message.dart';
import '../../../../core/utilits/services/url_launcher.dart';
import '../../../../core/utilits/widgets/custom_app_bar.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primary.withValues(alpha: 0.95),
      appBar: const CustomAppBar(title: 'سياسة الخصوصية'),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: AppColor.primary.withValues(alpha: 0.63)),
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
                      Icons.privacy_tip_rounded,
                      color: AppColor.primary,
                      size: 55,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: Text(
                      'سياسة الخصوصية',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Amiri',
                        color: AppColor.primary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Divider(color: Colors.grey.shade300),
                  const SizedBox(height: 10),

                  _sectionTitle('مقدمة'),
                  _sectionBody(
                    'تطبيق "لنستقيم" هو تطبيق إسلامي يقدم مزايا متكاملة تشمل: القرآن الكريم وتفسيره، التلاوة بأصوات شيوخ متنوعين، معاني الكلمات، الأحاديث النبوية، التذكير بالصلوات، القبلة، الأذكار، إذاعة القرآن، التقويم الهجري، التحديات، والمزيد. نحن نولي أهمية كبيرة لخصوصيتك ونسعى لحمايتها.',
                  ),

                  const SizedBox(height: 16),
                  _sectionTitle('البيانات التي نقوم بجمعها'),
                  _sectionBody(
                    'حاليًا لا نقوم بجمع أي معلومات شخصية مثل الاسم أو البريد الإلكتروني، حيث لا يحتوي التطبيق على نظام تسجيل دخول. قد نقوم بجمع بعض البيانات غير الشخصية لتحسين التجربة، مثل نوع الجهاز ونظام التشغيل.',
                  ),

                  const SizedBox(height: 16),
                  _sectionTitle('كيفية استخدام البيانات'),
                  _sectionBody(
                    'يتم استخدام البيانات فقط لتحسين الأداء، تخصيص المحتوى، وتقديم ميزات التطبيق بشكل أفضل. لا يتم مشاركة بيانات المستخدمين مع أي جهة خارجية.',
                  ),

                  const SizedBox(height: 16),
                  _sectionTitle('مشاركة البيانات'),
                  _sectionBody(
                    'لا نقوم ببيع أو تأجير أو مشاركة أي بيانات شخصية مع أطراف ثالثة. في حال أضفنا مزايا تسجيل دخول مستقبلًا، سيتم تحديث السياسة بما يتناسب مع ذلك.',
                  ),

                  const SizedBox(height: 16),
                  _sectionTitle('صلاحيات التطبيق'),
                  _sectionBody(
                    'قد يطلب التطبيق أذونات مثل الموقع لتحديد القبلة، أو الإشعارات لتنبيه الأذكار والصلاة. يتم طلب هذه الأذونات فقط عند الحاجة، ويتم استخدامها محليًا على جهاز المستخدم.',
                  ),

                  const SizedBox(height: 16),
                  _sectionTitle('أمن البيانات'),
                  _sectionBody(
                    'نحن نلتزم بحماية بياناتك. لا يتم تخزين بيانات حساسة في خوادم خارجية. جميع العمليات تحدث محليًا داخل التطبيق.',
                  ),

                  const SizedBox(height: 16),
                  _sectionTitle('الدفع والتبرع'),
                  _sectionBody(
                    'نحن نوفر وسيلة دعم وتبرع داخل التطبيق باستخدام بعض وسائل الدفع الإلكترونية، وتُدار المعاملات من خلال أطراف موثوقة وآمنة مثل (فودافون كاش، باي بال، إلخ).',
                  ),

                  const SizedBox(height: 16),
                  _sectionTitle('التعديلات على سياسة الخصوصية'),
                  _sectionBody(
                    'قد نقوم بتحديث سياسة الخصوصية من وقت لآخر. سيتم إشعار المستخدمين بأي تغييرات جوهرية داخل التطبيق.',
                  ),

                  const SizedBox(height: 16),
                  _sectionTitle('التواصل معنا'),
                  _sectionBody(
                    'لأي استفسارات حول سياسة الخصوصية أو حقوق البيانات، يُرجى التواصل معنا عبر البريد الإلكتروني:',
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
                  
                      }              },
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
                  Divider(color: Colors.grey.shade300),
                  const SizedBox(height: 8),
                  Text(
                    'آخر تحديث: 06 يوليو 2025',
                    style: const TextStyle(
                      fontSize: 14,
                      fontFamily: 'Amiri',
                      color: Colors.black54,
                    ),
                    textAlign: TextAlign.center,
                  ),
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

