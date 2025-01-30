import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lnastaqim/core/constants/colors.dart';
import 'package:lnastaqim/features/favourite/data/models/favourite_model.dart';
import 'package:lnastaqim/features/favourite/views/widgets/favourite_item.dart';

class FavListView extends StatelessWidget {
  const FavListView({
    super.key,
    required this.isZekr,
    required this.favourite,
  });

  final bool isZekr;
  final List<FavouriteModel> favourite;

  @override
  Widget build(BuildContext context) {
    return favourite.isEmpty
        ? Center(
            child: Text(
            isZekr == true
                ? "لا توجد اذكار في المفضلة!"
                : "لا يوجد احاديث في المفضلة!",
            style:  TextStyle(
              color: AppColor.primary,
              fontSize: 21.sp,
              fontFamily: "naskh",
              fontWeight: FontWeight.w600,
            ),
          ))
        : ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: favourite.length,
            itemBuilder: (BuildContext context, int index) {
              return FavouriteItem(
                isZekr: isZekr,
                favouriteModel: favourite[index],
              );
            });
  }
}
