import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lnastaqim/core/constants/colors.dart';

class CustomBottomNavigationBarItem extends StatelessWidget {
  const CustomBottomNavigationBarItem({
    super.key,
    required this.isSelected,
    required this.index,
    required this.pageController,
    required this.icon,
    required this.onTap,
  });

  final int index;
  final PageController pageController;
  final IconData icon;
  final bool isSelected;
  final Function(int index) onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(index),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 40.h,
            width: 40.w,
            decoration: ShapeDecoration(
              shape: const CircleBorder(),
              color:
                  isSelected == true ? AppColor.lightBlue : AppColor.lightGrey,
            ),
            child: Center(
              child: Icon(
                icon,
                size: 24.h,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
