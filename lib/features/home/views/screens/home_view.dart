import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';
import 'package:lnastaqim/core/constants/images.dart';
import 'package:lnastaqim/features/home/data/models/prayer_time_model.dart';

import '../widgets/carousel_slider_ayah.dart';
import '../widgets/features_grid_view.dart';
import '../widgets/prayer_time_item.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  static List<PrayerTimeModel> items = [
    PrayerTimeModel(icon: Icons.sunny_snowing, text: "الضهر", time: "11:50"),
    PrayerTimeModel(icon: Icons.sunny, text: "العصر", time: "3:30"),
    PrayerTimeModel(icon: Icons.sunny, text: "المغرب", time: "5:30"),
    PrayerTimeModel(
        icon: Icons.nights_stay_outlined, text: "العشاء", time: "7:00"),
    PrayerTimeModel(
        icon: Icons.nightlight_outlined, text: "الفجر", time: "5:00"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff2f4f9),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Stack(
              children: [
                Image(
                  width: Get.width,
                  fit: BoxFit.cover,
                  image: const AssetImage(AppImages.homeBackground),
                ),
                 Padding(
                  padding: EdgeInsets.only(top: 55.h, left: 20.w),
                  child:
                      const Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Icon(
                        Icons.notifications_none_outlined,
                        color: Colors.white,
                      ),
                    ),
                    Icon(
                      Icons.wb_sunny_outlined,
                      color: Colors.white,
                    )
                  ]),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "مواعيد الصلاوات",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                      children: List.generate(items.length, (index) {
                    return Expanded(
                        child: PrayerTimeItem(
                      prayerTimeModel: items[index],
                    ));
                  })),
                ],
              ),
            ),
            const CarouselSliderAyah(),
            const Padding(
              padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "المميزات",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  FeaturesGridView(),
                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
