import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lnastaqim/core/utilits/widgets/custom_app_bar.dart';
import 'package:lnastaqim/features/settings/views/widgets/setting_item.dart';
import 'package:lnastaqim/features/settings/views/widgets/split_settings.dart';
import '../../../../config/routing/app_routes_info/app_routes_name.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/links.dart';
import '../../../../core/utilits/functions/format_text.dart';
import '../../../../core/utilits/functions/toast_message.dart';
import '../../../../core/utilits/services/url_launcher.dart';
import '../../../share/views/widgets/share_fun.dart';


class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "الاعدادات"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 25.0),
          child: Column(
            children: [
              SettingItem(
                icon: Icons.email,
                text: "تواصل معنا",
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
              ),
              const SplitSetting(title: "المظهر"),
              SettingItem(
                isTheme: true,
                icon: Icons.wb_sunny_outlined,
                text: "الوضع الليلي",
                onTap: () {},
              ),
              const SplitSetting(title: "تفاعل"),
              SettingItem(
                icon: Icons.rate_review,
                text: "تقييم التطبيق",
                onTap: () {
                  UrlLauncher.launchToUrl(AppLinks.storeUrl, isExternal: true);
                },
              ),
              SettingItem(
                icon: Icons.share,
                text: "مشاركة التطبيق",
                onTap: () async {
                  await shareText(
                    FormatText.appShareText(AppLinks.storeUrl),
                    subject: "مشاركة التطبيق",
                  );
                },
              ),
              const SplitSetting(title: "المزيد"),
              SettingItem(
                icon: Icons.file_open_outlined,
                text: "حقوق الملكية",
                onTap: () {
                          Get.toNamed(AppRouteName.copyRight);
                },
              ),
              SettingItem(
                icon: Icons.privacy_tip_outlined,
                text: "سياسة الخصوصية",
                onTap: () {
                        Get.toNamed(AppRouteName.privacyPolicy);
                },
              ),
              SettingItem(
                icon: Icons.info,
                text: "من نحن",
                onTap: () {
                            Get.toNamed(AppRouteName.aboutUs);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
