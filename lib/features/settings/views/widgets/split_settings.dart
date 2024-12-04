import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lnastaqim/core/constants/colors.dart';

class SplitSetting extends StatelessWidget {
  const SplitSetting({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 16.0.w, right: 16.w, bottom: 16.h),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(fontSize: 14, color: AppColor.grey),
            ),
          ),
          const Expanded(
            flex: 6,
            child: SizedBox(
                height: 1,
                width: double.infinity,
                child: Divider(
                  thickness: 1,
                )),
          ),
        ],
      ),
    );
  }
}

