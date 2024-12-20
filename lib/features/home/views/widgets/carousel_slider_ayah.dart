import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'ayah_w_3bra.dart';

class CarouselSliderAyah extends StatefulWidget {
  const CarouselSliderAyah({super.key});

  @override
  State<CarouselSliderAyah> createState() => _CarouselSliderAyahState();
}

class _CarouselSliderAyahState extends State<CarouselSliderAyah> {
  int activeIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
         boxShadow: [
     
         BoxShadow(
            color: Colors.grey.withOpacity(0.1), // ظل رمادي خفيف
            offset: const Offset(0, 2),          // الاتجاه
            blurRadius: 5,                      // نعومة الظل
            spreadRadius: 0.5,                     // امتداد الظل
          ),
      
        ],
      ),
      child: CarouselSlider(
          items: List.generate(6, (index) {
            return AyahW3bra(
              activeIndex: activeIndex,
            );
          }),
          options: CarouselOptions(
            onPageChanged: (int index, reason) {
              setState(() {
                activeIndex = index;
              });
            },
            height: 220,
            aspectRatio: 16 / 9,
            initialPage: 0,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 3),
            autoPlayAnimationDuration: const Duration(seconds: 1),
            autoPlayCurve: Curves.fastOutSlowIn,
            scrollDirection: Axis.horizontal,
            viewportFraction: 1,
          )),
    );
  }
}
