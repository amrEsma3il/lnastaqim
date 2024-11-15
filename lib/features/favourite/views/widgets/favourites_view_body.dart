import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/constants/colors.dart';
import 'favourites_azkar_7adis_lisview.dart';

class Favouritesviewbody extends StatelessWidget {
  const Favouritesviewbody({super.key, required this.isZekr});

  final bool isZekr;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Container(
                decoration:
                    BoxDecoration(color: AppColor.blueColor.withOpacity(0.85)),
                height: Get.height,
                width: Get.width,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          IconButton(
                              onPressed: () {
                                Get.back();
                              },
                              icon: const Icon(
                                Icons.arrow_back,
                                size: 20,
                                color: Colors.white,
                              )),
                          Expanded(
                            child: Center(
                              child: Padding(
                                  padding: EdgeInsets.only(left: 36.w),
                                  child: const Text(
                                    "المفضلة",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 25,
                                        fontWeight: FontWeight.w500),
                                  )),
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: Padding(
                            padding: EdgeInsets.only(bottom: 20.h),
                            child: FavouritesAzkar7adisListView(
                              isZekr: isZekr,
                            )),
                      ),
                    ],
                  ),
                ))));
  }
}
