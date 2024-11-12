import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lnastaqim/config/routing/app_routes_info/app_routes_name.dart';
import 'package:lnastaqim/core/constants/colors.dart';

void showAzkarOptionsMenu(BuildContext context) {
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
                  Get.toNamed(AppRouteName.favAzkar);
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
              const SizedBox(
                height: 100,
              )
            ],
          ),
        ),
      );
    },
  );
}
