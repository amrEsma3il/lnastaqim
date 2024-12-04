import 'package:flutter/material.dart';
import 'package:lnastaqim/core/utilits/widgets/custom_app_bar.dart';
import 'package:lnastaqim/features/settings/views/widgets/setting_item.dart';
import 'package:lnastaqim/features/settings/views/widgets/split_settings.dart';

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
                  onTap: () {},
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
                  onTap: () {},
                ),
                SettingItem(
                  icon: Icons.share,
                  text: "مشاركة التطبيق",
                  onTap: () {},
                ),
                const SplitSetting(
                  title: "المزيد",
                ),
                SettingItem(
                  icon: Icons.file_open_outlined,
                  text: "حقوق الملكية",
                  onTap: () {},
                ),
                SettingItem(
                  icon: Icons.privacy_tip,
                  text: "سياسه الخصوصية",
                  onTap: () {},
                ),
                SettingItem(
                  icon: Icons.info,
                  text: "من نحن",
                  onTap: () {},
                ),
              ],
            ),
          ),
        ));
  }
}
