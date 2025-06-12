import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lnastaqim/core/utilits/widgets/custom_app_bar.dart';
import 'package:lnastaqim/features/favourite/views/widgets/favourites_azkar_7adis_lisview.dart';
import 'package:lnastaqim/features/favourite/views/widgets/general_favourite_header.dart';

import 'quran_favourite_sound_player.dart';

class GeneralFavouriteView extends StatefulWidget {
  const GeneralFavouriteView({super.key});

  @override
  State<GeneralFavouriteView> createState() => _GeneralFavouriteViewState();
}

class _GeneralFavouriteViewState extends State<GeneralFavouriteView> {
  bool _isAzkar = true;
  bool _is7adis = false;
  bool _isQuran= false;

  void _toggleFavAzkar() {
    setState(() {
      _isAzkar = true;
      _is7adis = false;
      _isQuran=false;
    });
  }

  void _toggleFav7adis() {
    setState(() {
      _isAzkar = false;
      _is7adis = true;
      _isQuran=false;
    });
  }
  void _toggleFavQuran() {
    setState(() {
      _isAzkar = false;
      _is7adis = false;
      _isQuran=true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "المفضلة",
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 60.h,
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: GeneralFavouriteHeader(
                            title: "الاذكار",
                            onTap: _toggleFavAzkar,
                            isVisible: _isAzkar)),
                    Expanded(
                        child: GeneralFavouriteHeader(
                            title: "الاحاديث",
                            onTap: _toggleFav7adis,
                            isVisible: _is7adis)),

                        //           Expanded(
                        // child: GeneralFavouriteHeader(
                        //     title: "القرآن",
                        //     onTap: _toggleFavQuran,
                        //     isVisible: _isQuran)),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                 padding: EdgeInsets.only(bottom: 20.h),
                child: Visibility(
                  visible: _isAzkar,
                  replacement: const FavouritesAzkar7adisListView(
                    isZekr: false,
                  ),
                  child: const FavouritesAzkar7adisListView(
                    isZekr: true,
                  ),
                ),
              ),
            ),    ],
        ),
      ),
    );
  }
}
