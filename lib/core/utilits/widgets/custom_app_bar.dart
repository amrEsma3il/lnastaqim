import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lnastaqim/core/constants/colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar(
      {super.key,
      required this.title,
      this.isZekr,
      this.actions,
      this.isLayout});

  final String title;

  final bool? isZekr;

  final List<Widget>? actions;

  final bool? isLayout;

  @override
  Widget build(BuildContext context) {
    return AppBar(
        leading: isLayout == true
            ? null
            : GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 25,
                ),
              ),
        automaticallyImplyLeading: false,
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
        actions: actions);
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
