import 'package:flutter/material.dart';
import 'package:lnastaqim/core/constants/colors.dart';

class CalendarFooter extends StatelessWidget {
  const CalendarFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: ShapeDecoration(
            shadows: [
              BoxShadow(
                  color: AppColor.white,
                  blurRadius: 24,
                  spreadRadius: 0,
                  offset: const Offset(0, 4),
                  blurStyle: BlurStyle.inner)
            ],
            color: AppColor.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            )),
        child: const Text(
          "ما تصلي علي النبي بما انك هنا❤",
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
