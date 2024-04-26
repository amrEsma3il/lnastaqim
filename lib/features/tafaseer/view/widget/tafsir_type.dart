import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TafsirType extends StatelessWidget {
  const TafsirType({super.key, required this.name, required this.onPressed});

  final String name;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TextButton(
          onPressed: onPressed,
          child: Text(
            name,
            style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 15.sp,
                color: Colors.white),
          ),
        ),
        SizedBox(
          width: 15.w,
        ),
      ],
    );
  }
}
