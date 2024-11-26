import 'package:flutter/material.dart';
import 'package:lnastaqim/core/constants/colors.dart';

class GeneralFavouriteHeader extends StatelessWidget {
  const GeneralFavouriteHeader({
    super.key,
    this.onTap,
    required this.title,
    required this.isVisible,
  });

  final void Function()? onTap;
  final String title;
  final bool isVisible;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Text(
            title,
            style: TextStyle(fontSize: 13,fontWeight: FontWeight.w600,color: AppColor.primary),
          ),
        ),
        const Spacer(),
        Visibility(
          visible: isVisible,
          child:  SizedBox(
            width: 120,
            height: 0,
            child: Divider(
              height: 9,
              thickness: 3,
              color: AppColor.primary,
            ),
          ),
        ),
      ],
    );
  }
}
