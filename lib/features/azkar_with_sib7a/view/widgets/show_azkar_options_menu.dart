import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lnastaqim/config/routing/app_routes_info/app_routes_name.dart';
import 'package:lnastaqim/core/constants/colors.dart';

void showAzkarOptionsMenu(BuildContext context, bool isZekr) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: AppColor.primary,
        insetPadding: const EdgeInsets.only(right: 20, left: 180, bottom: 470),
        titlePadding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 15),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  if (isZekr == true) {
                    Get.toNamed(AppRouteName.favAzkar);
                  } else {
                    Get.toNamed(AppRouteName.fav7adis);
                  }
                },
                child: const Row(
                  children: [
                    Text(
                      "المفضلة",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: "naskh",
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                    Icon(
                      Icons.favorite,
                      color: Colors.white,
                      size: 15,
                    ),
                  ],
                ),
              ),
               SizedBox(
                height: 20.h,
              ),
               GestureDetector(
                onTap: () {
                Get.toNamed(AppRouteName.sibhaView);
                },
                child: const Row(
                  children: [
                    Text(
                      "السبحة",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: "naskh",
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                    Icon(
                      Icons.pending_sharp,
                      color: Colors.white,
                      size: 15,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
    },
  );
}
