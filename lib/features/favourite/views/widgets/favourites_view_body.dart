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
            child: SizedBox(
              
                height: Get.height,
                width: Get.width,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                       width: Get.width,
                          height: 70.h,
                          color: AppColor.primary.withOpacity(0.8),
                      child: Row(
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
                                  child:  const Text(
                                    "المفضلة",
                                    style:  TextStyle(
                                        color: Colors.white,
                                        fontSize: 25,
                                        fontWeight: FontWeight.w500),
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Padding(
                          padding: EdgeInsets.only(bottom: 20.h,right: 15.w,left: 15.w),
                          child: FavouritesAzkar7adisListView(
                            isZekr: isZekr,
                          )),
                    ),
                  ],
                ))));
  }
}
