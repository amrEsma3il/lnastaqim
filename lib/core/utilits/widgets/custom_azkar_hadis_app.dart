import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lnastaqim/core/constants/colors.dart';
import 'package:lnastaqim/features/azkar_with_sib7a/view/widgets/custom_menu.dart';

class CustomAzkarHadisApp extends StatelessWidget
    implements PreferredSizeWidget {
  const CustomAzkarHadisApp(
      {super.key, required this.title, required this.isZekr});

  final String title;

  final bool isZekr;

  @override
  Widget build(BuildContext context) {
    return AppBar(
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: const Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 25,
          ),
        ),
        centerTitle: true,
        title: Text(
          title,
          style: const TextStyle(
              fontFamily: 'Authmanic',
              color: Colors.white,
              fontWeight: FontWeight.w600),
        ),
        backgroundColor: isZekr == true
            ? AppColor.primary
            : AppColor.primary.withOpacity(0.8),
        actions: [
          CustomMenu(
            isZekr: isZekr,
          ),
        ]);
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
