import 'package:flutter/material.dart';
import 'package:lnastaqim/core/constants/colors.dart';

class CalenderHeader extends StatelessWidget {
  const CalenderHeader(
      {super.key, required this.text, required this.isSelected, this.onTap});

  final String text;
  final bool isSelected;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? AppColor.primary : Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            text,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ));
  }
}
