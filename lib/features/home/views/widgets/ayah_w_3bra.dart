import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lnastaqim/core/utilits/extensions/arabic_numbers.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/images.dart';
import '../../../share/views/widgets/share_fun.dart';

class AyahW3bra extends StatelessWidget {
  const AyahW3bra({
    super.key,
    required this.activeIndex,
    required this.ayah,
    required this.tafsir,
  });

  final int activeIndex;
  final String ayah;
  final String tafsir;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 20.0,
        bottom: 15,
        left: 15,
        right: 15,
      ),
      child: Container(
        height: 120,
        width: double.infinity,
        decoration: ShapeDecoration(
          color: Colors.white,
          shadows: const [BoxShadow(color: Colors.grey)],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(11),
          ),
        ),
        child: Column(
          children: [
            // العنوان والرموز
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 10, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Text("آية وعبرة"),
                      const SizedBox(width: 5),
                      SvgPicture.asset(
                        'assets/svgs/surah-number.svg',
                        width: 20,
                        height: 20,
                        colorFilter: const ColorFilter.mode(
                          Color.fromARGB(255, 14, 10, 58),
                          BlendMode.srcIn,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          shareAyahW3bra(ayah:  ayah.toArabicNums, tafsir: tafsir);
                        },

                        child: SvgPicture.asset(AppImages.forwardIcon),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 5, bottom: 15),
              child: Divider(),
            ),
            // الآية
            Text(
              ayah.toArabicNums,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w600,
                color: AppColor.primary,
              ),
            ),
            // التفسير
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                tafsir,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: AppColor.primary,
                ),
              ),
            ),
            const SizedBox(height: 25),
            AnimatedSmoothIndicator(
              activeIndex: activeIndex,
              count: 7,
              effect: ExpandingDotsEffect(
                activeDotColor: AppColor.primary,
                dotColor: AppColor.softGray,
                dotHeight: 6,
                dotWidth: 6,
                expansionFactor: 2,
                spacing: 5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
