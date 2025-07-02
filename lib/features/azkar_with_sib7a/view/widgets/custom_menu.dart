import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lnastaqim/core/constants/colors.dart';
import 'package:lnastaqim/core/constants/images.dart';
import 'package:lnastaqim/features/azkar_with_sib7a/view/widgets/show_azkar_options_menu.dart';

import '../../../../config/routing/app_routes_info/app_routes_name.dart';

class CustomMenu extends StatelessWidget {
  const CustomMenu({
    super.key,
    required this.isZekr,
  });

  final bool isZekr;
  @override
  Widget build(BuildContext context) {
    return IconButton(onPressed: () {
              Get.toNamed(AppRouteName.favAzkar);
       }, icon: const Icon(Icons.favorite,color: Colors.white,));
  }
}
