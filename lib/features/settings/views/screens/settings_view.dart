import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lnastaqim/core/utilits/widgets/custom_app_bar.dart';
import 'package:lnastaqim/features/settings/views/widgets/setting_item.dart';
import 'package:lnastaqim/features/settings/views/widgets/split_settings.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/links.dart';
import '../../../../core/utilits/functions/format_text.dart';
import '../../../../core/utilits/services/url_launcher.dart';
import '../../../share/views/widgets/share_fun.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(
          title: "الاعدادات",
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 25.0),
            child: Column(
              children: [
                SettingItem(
                  icon: Icons.email,
                  text: "تواصل معنا",
                  onTap: () {

                    UrlLauncher.launchToUrl(
  'mailto:contact@lnastaqim.com',
  isExternal: true,
);

                  },
                ),
                const SplitSetting(
                  title: "المظهر",
                ),
                SettingItem(
                  isTheme: true,
                  icon: Icons.wb_sunny_outlined,
                  text: "الوضع الليلي",
                  onTap: () {},
                ),
                const SplitSetting(
                  title: "تفاعل",
                ),
                SettingItem(
                  icon: Icons.rate_review,
                  text: "تقييم التطبيق",
                  onTap: () {
                    UrlLauncher.launchToUrl(AppLinks.storeUrl,isExternal: true);
                  },
                ),
                SettingItem(
                  icon: Icons.share,
                  text: "مشاركة التطبيق",
                  onTap: () async{
                      await shareText(
           FormatText.appShareText(AppLinks.storeUrl) ,
          subject:"مشاركة التطبيق" ,
        );
                   
                  },
                ),
                const SplitSetting(
                  title: "المزيد",
                ),
                SettingItem(
                  icon: Icons.file_open_outlined,
                  text: "حقوق الملكية",
                  onTap: () {
                    Get.to(CopyrightScreen());
                  },
                ),
        
                SettingItem(
                  icon: Icons.info,
                  text: "من نحن",
                  onTap: () {
                    Get.to(AboutUsScreen());
                  },
                ),
              ],
            ),
          ),
        ));
  }
}




class CopyrightScreen extends StatelessWidget {
  const CopyrightScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primary.withOpacity(0.85),
      appBar: const CustomAppBar(
        title: 'حقوق الملكية',
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: AppColor.primary.withOpacity(0.6),
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
                    child: Icon(Icons.verified_user_rounded,
                        color: AppColor.primary, size: 55),
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
                  Text(
                    'support@lnastaqim.app',
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Amiri',
                      color: AppColor.primary,
                      decoration: TextDecoration.underline,
                    ),
                    textDirection: TextDirection.ltr,
                    textAlign: TextAlign.left,
                  ),

                  const SizedBox(height: 20),

                  /// السياسة
                  Center(
                    child: TextButton(
                      onPressed: () {

                        // TODO: Navigate to PrivacyPolicyScreen
                        Get.to(()=>PrivacyPolicyScreen());
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
                      fontFamily: 'Amiri',
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
        fontFamily: 'Amiri',
        color: Colors.black87,
      ),
      textAlign: TextAlign.justify,
    );
  }
}


class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: AppColor.primary.withValues(alpha: 0.8),
      appBar: const CustomAppBar(
          title: 'من نحن',
        ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColor.primary, width: 1.2),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:  [
                  Center(
                    child: Icon(Icons.account_circle_rounded,
                        color: AppColor.primary, size: 50),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'تطبيق لنستقيم',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Amiri',
                      color: AppColor.primary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 12),
                  Text(
                    'تطبيق إسلامي متكامل يساعدك على الثبات والاستقامة، يحتوي على القرآن الكريم وتفسيره ومعاني الكلمات، أحاديث نبوية، تحديد القبلة، مواقيت الصلاة، أذكار يومية، المسبحة الإلكترونية، إذاعة القرآن، تقويم هجري، تحديات دينية، مجتمع للمشاركة، مزايا إضافية كالتصحيح الإملائي والترتيلي، وسلاسل كن داعية.',
                    style: TextStyle(
                      fontSize: 16,
                      height: 1.6,
                      fontFamily: 'Amiri',
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}







class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primary.withOpacity(0.85),
      appBar: const CustomAppBar(title: 'سياسة الخصوصية'),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: AppColor.primary.withOpacity(0.6)),
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
                    child: Icon(Icons.privacy_tip_rounded,
                        color: AppColor.primary, size: 55),
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
                  Text(
                    'support@lnastaqim.app',
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Amiri',
                      color: AppColor.primary,
                      decoration: TextDecoration.underline,
                    ),
                    textDirection: TextDirection.ltr,
                    textAlign: TextAlign.left,
                  ),

                  const SizedBox(height: 20),
                  Divider(color: Colors.grey.shade300),
                  const SizedBox(height: 8),
                  Text(
                    'آخر تحديث: 09 يونيو 2025',
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
        fontFamily: 'Amiri',
        color: Colors.black87,
      ),
      textAlign: TextAlign.justify,
    );
  }
}
