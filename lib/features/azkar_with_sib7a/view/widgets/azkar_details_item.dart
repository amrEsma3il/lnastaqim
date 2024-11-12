import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lnastaqim/core/constants/colors.dart';
import 'package:lnastaqim/features/azkar_with_sib7a/data/models/AzkarModel.dart';
import 'package:lnastaqim/features/favourite/bussniess_logic/add_to_fav_cubit/add_to_fav_cubit.dart';
import 'package:lnastaqim/features/favourite/bussniess_logic/add_to_fav_cubit/add_to_fav_state.dart';
import 'package:lnastaqim/features/favourite/bussniess_logic/favourites_cubit/favourite_cubit.dart';
import 'package:lnastaqim/features/favourite/data/models/favourite_model.dart';
import 'package:lnastaqim/features/share/views/widgets/share_zekr_checkbox.dart';
import 'package:screenshot/screenshot.dart';

import '../../../share/views/widgets/share_bottom_sheet.dart';

class AzkarDetailsItem extends StatefulWidget {
  const AzkarDetailsItem({
    super.key,
    required this.azkarModel,
  });

  final AzkarModel azkarModel;

  @override
  State<AzkarDetailsItem> createState() => _AzkarDetailsItemState();
}

class _AzkarDetailsItemState extends State<AzkarDetailsItem> {
  final ScreenshotController screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 15.w, left: 15.w, bottom: 25.h),
      child: Container(
        decoration: ShapeDecoration(
            color: AppColor.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.r))),
        child: Column(
          children: [
            Screenshot(
              controller: screenshotController,
              child: Container(
                width: double.infinity,
                decoration: ShapeDecoration(
                    color: AppColor.primary,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.r))),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(15.w, 12.h, 15.w, 10.h),
                  child: Center(
                    child: Text(
                      widget.azkarModel.zekr ?? "",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(15.w, 15.h, 15.w, 15.h),
              child: Row(
                children: [
                  Expanded(
                    child: CircleAvatar(
                      radius: 25,
                      backgroundColor: AppColor.primary.withOpacity(0.3),
                      child: IconButton(
                          onPressed: () async {
                            var image = await screenshotController.capture();
                            if (image != null) {
                              showShareBottomSheet(
                                  context,
                                  ShareZekrCheckBox(
                                      zekr: widget.azkarModel.zekr ?? "",
                                      image: image));
                            }
                          },
                          icon: const Icon(
                            Icons.share,
                            size: 24,
                            color: Colors.white,
                          )),
                    ),
                  ),
                  Expanded(
                    child: CircleAvatar(
                      radius: 25,
                      backgroundColor: AppColor.primary.withOpacity(0.3),
                      child: Text(
                        widget.azkarModel.count ?? "",
                        style: const TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  BlocConsumer<AddToFavouriteCubit, AddToFavouriteState>(
                    listener: (context, state) {
                      if (state is AddToFavouriteSuccessState) {
                        BlocProvider.of<FavouriteCubit>(context)
                            .fetchFavourite();
                      }
                    },
                    builder: (context, state) {
                      var favouriteCubit =
                          BlocProvider.of<FavouriteCubit>(context);
                      bool isFavourite = favouriteCubit.favourites?.any(
                              (fav) => fav.name == widget.azkarModel.zekr) ??
                          false;
                      return BlocBuilder<FavouriteCubit, FavouriteState>(
                        builder: (context, state) {
                          return Expanded(
                            child: CircleAvatar(
                              radius: 25,
                              backgroundColor: isFavourite
                                  ? AppColor.primary
                                  : AppColor.primary.withOpacity(0.3),
                              child: IconButton(
                                onPressed: () {
                                  addToFav(context, isFavourite);
                                },
                                icon: Icon(
                                  isFavourite
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  size: 24,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                  Expanded(
                    child: CircleAvatar(
                      radius: 25,
                      backgroundColor: AppColor.primary.withOpacity(0.3),
                      child: IconButton(
                          onPressed: () {
                            Clipboard.setData(ClipboardData(
                                    text: widget.azkarModel.zekr ?? ""))
                                .then((_) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Center(
                                        child: Text('تم النسخ إلى الحافظه'))),
                              );
                            });
                          },
                          icon: const Icon(
                            Icons.copy,
                            size: 24,
                            color: Colors.white,
                          )),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void addToFav(BuildContext context, bool isFavourite) {
    var favourites = BlocProvider.of<FavouriteCubit>(context).favourites;

    if (!isFavourite) {
      BlocProvider.of<AddToFavouriteCubit>(context).addToFavourite(
        FavouriteModel(
          name: widget.azkarModel.zekr ?? "",
          category: widget.azkarModel.category ?? "",
        ),
      );
      setState(() {
        isFavourite = true;
      });
    } else {
      for (var fav in favourites!) {
        if (fav.name == widget.azkarModel.zekr) {
          fav.delete();
          break;
        }
      }
      BlocProvider.of<FavouriteCubit>(context).fetchFavourite();
      setState(() {
        isFavourite = false;
      });
    }
  }
}
