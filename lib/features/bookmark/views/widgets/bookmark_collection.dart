import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../config/routing/app_routes_info/app_routes_name.dart';
import '../../../../core/constants/colors.dart';

class BookMarkCollection extends StatelessWidget {
  const BookMarkCollection({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.offNamed(AppRouteName.bookmark);
      },
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(top: 20, bottom: 33),
        padding: const EdgeInsets.symmetric(horizontal: 15),
        height: 50,
        decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20))),
        child: const Row(
          children: [
            Text(
              "المرجعيات",
              style: TextStyle(fontSize: 22, 
              color:AppColor.blueColor, fontWeight:  FontWeight.w600),
            ),
            Spacer(),
            Icon(Icons.bookmark,color: AppColor.blueColor,size: 26,),
          ],
        ),
      ),
    );
  }
}
