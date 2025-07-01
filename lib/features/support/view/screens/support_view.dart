import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lnastaqim/core/utilits/widgets/custom_app_bar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:developer' as dev;
import '../../../../core/constants/colors.dart';
import '../../../../core/utilits/functions/toast_message.dart';
import '../../../../core/utilits/services/url_launcher.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "دعم التطبيق"),
      backgroundColor: AppColor.primary.withOpacity(0.96),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: AppColor.primary, width: 1.3),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'ساهم في استمرار تطوير التطبيق من خلال دعمك 🙏',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 17.5,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Amiri',
                ),
              ),
              const SizedBox(height: 25),
              _buildSupportCard(
                shortLink: "01012345678",
                context: context,
                title: 'Vodafone Cash',
                description: '01006539084',
                icon: Icons.phone_android,
                onTapCard: () async {
                  try {
                    await UrlLauncher.launchToUrl(
                      'tel:%2A9%2A7%2A01006539084%2A25%23',
                      isExternal: true,
                    );
                  } catch (e) {
                    dev.log("Error opening Vodafone Cash: $e");
                    showToast(
                      'تعذر فتح الهاتف. تأكد من وجود التطبيق على جهازك.',
                      AppColor.primary.withValues(alpha: 0.9),
                    );
                  }
                },
              ),
              const SizedBox(height: 15),
              _buildSupportCard(
                shortLink: "paypal.me/lnastaqim",
                context: context,
                title: 'PayPal',
                description: 'https://paypal.me/lnastaqim',
                icon: Icons.payment,
                onTapCard: () async {
                  try {
                    await UrlLauncher.launchToUrl(
                      'https://paypal.me/lnastaqim',
                      isExternal: true,
                    );
                  } catch (e) {
                    showToast(
                      'تعذر فتح paypal. تأكد من وجود التطبيق على جهازك.',
                      AppColor.primary.withValues(alpha: 0.9),
                    );
                  }
                },
              ),
              const SizedBox(height: 15),
              _buildSupportCard(
                shortLink: "ipn.eg/S/ismail20.galal/instapay",
                context: context,
                title: 'InstaPay',
                description: 'https://ipn.eg/S/ismail20.galal/instapay/8usBet',
                icon: Icons.qr_code_2,
                onTapCard: () async {

                     try {
                   await   UrlLauncher.launchToUrl(
                    'https://ipn.eg/S/ismail20.galal/instapay/8usBet',
                    isExternal: true,
                  );
                  } catch (e) {
                    showToast(
                      'تعذر فتح insta pay. تأكد من وجود التطبيق على جهازك.',
                      AppColor.primary.withValues(alpha: 0.9),
                    );
                  }
               
                },
              ),

              const SizedBox(height: 30),
              const Text(
                'شكرًا لدعمك وبارك الله فيك 💙',
                style: TextStyle(
                  fontFamily: 'Amiri',
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSupportCard({
    required BuildContext context,
    required String title,
    required String description,
    required IconData icon,
    required VoidCallback onTapCard,
    required String shortLink,
  }) {
    return InkWell(
      onTap: onTapCard,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 12),
        decoration: BoxDecoration(
          border: Border.all(color: AppColor.primary, width: 1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(icon, color: AppColor.primary),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Amiri',
                      fontSize: 15.5,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    shortLink,
                    style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 14,
                      fontFamily: 'Amiri',
                    ),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                copyToClipboard(description);
                showSnackbar('تم نسخ $title');
              },
              child: const Padding(
                padding: EdgeInsets.all(6.0),
                child: Icon(Icons.copy, size: 20, color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
  }

  void showSnackbar(String message) {
    Get.snackbar(
      '',
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColor.primary.withOpacity(0.9),
      colorText: Colors.white,
      margin: const EdgeInsets.all(12),
    );
  }
}
