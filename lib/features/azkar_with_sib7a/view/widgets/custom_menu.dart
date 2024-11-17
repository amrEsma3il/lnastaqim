import 'package:flutter/material.dart';
import 'package:lnastaqim/core/constants/colors.dart';
import 'package:lnastaqim/core/constants/images.dart';
import 'package:lnastaqim/features/azkar_with_sib7a/view/widgets/show_azkar_options_menu.dart';

class CustomMenu extends StatelessWidget {
  const CustomMenu({
    super.key,
    required this.isZekr,
  });

  final bool isZekr;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, bottom: 15, left: 10, right: 10),
      child: GestureDetector(
        onTap: () {
          showAzkarOptionsMenu(context, isZekr);
        },
        child: Image.asset(
          AppImages.menu,
          color: AppColor.white,
          height: 27,
        ),
      ),
    );
  }
}
