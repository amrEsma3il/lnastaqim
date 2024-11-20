import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lnastaqim/features/favourite/bussniess_logic/add_to_fav_cubit/add_to_fav_cubit.dart';
import 'package:lnastaqim/features/favourite/bussniess_logic/add_to_fav_cubit/add_to_fav_state.dart';
import 'package:lnastaqim/features/favourite/bussniess_logic/favourites_cubit/favourite_cubit.dart';
import 'package:lnastaqim/features/favourite/data/models/favourite_model.dart';
import 'package:lnastaqim/features/share/views/widgets/share_bottom_sheet.dart';
import 'package:lnastaqim/features/share/views/widgets/share_hadis_checkbox.dart';
import 'package:screenshot/screenshot.dart';

import '../../../../core/constants/colors.dart';
import '../../bussiness_logic/a7adith_cubit.dart';
import '../../bussiness_logic/a7adiths_state.dart';
import '../../data/model/a7adith_model.dart';

class A7adithDetails extends StatefulWidget {
  const A7adithDetails({super.key, required this.id});
  final int id;

  @override
  State<A7adithDetails> createState() => _A7adithDetailsState();
}

class _A7adithDetailsState extends State<A7adithDetails> {
  final ScreenshotController screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HadithCubit, HadithState>(
      builder: (context, state) {
        if (state is HadithLoaded) {
          List<Hadiths> filteredHadiths = state.hadiths[0].hadiths!
              .where((hadith) => hadith.chapterId == widget.id)
              .toList();

          return Scaffold(
            appBar: AppBar(
              foregroundColor: Colors.white,
              backgroundColor: AppColor.primary.withOpacity(0.8),
              title: Text(
                '  ${state.hadiths[0].metadata!.arabic!.title}  |  ${state.hadiths[0].chapters![widget.id - 1].arabic}  ',
                style: const TextStyle(
                    fontFamily: 'Authmanic',
                    color: Colors.white,
                    fontWeight: FontWeight.w600),
              ),
            ),
            body: Column(
              children: [
                // Padding(
                //   padding:
                //       const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                //   child: Container(
                //     height: 30,
                //     width: double.infinity,
                //     decoration: BoxDecoration(
                //       color: AppColor.primary.withOpacity(0.8),
                //       borderRadius: BorderRadius.circular(10),
                //     ),
                //     child: Center(
                //       child: Text(
                //         '  ${state.hadiths[0].metadata!.arabic!.title}  |  ${state.hadiths[0].chapters![widget.id - 1].arabic}  ',
                //         style: const TextStyle(
                //             fontFamily: 'Authmanic',
                //             color: Colors.white,
                //             fontWeight: FontWeight.w600),
                //       ),
                //     ),
                //   ),
                // ),
                Expanded(
                  child: ListView.separated(
                    itemCount: filteredHadiths.length,
                    itemBuilder: (context, index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Container(
                              decoration: ShapeDecoration(
                                  shadows: [
                                    BoxShadow(
                                        blurRadius: 3,
                                        blurStyle: BlurStyle.outer,
                                        color: AppColor.primary)
                                  ],
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      side:
                                          BorderSide(color: AppColor.primary))),
                              child: Column(
                                children: [
                                  ListTile(
                                    title: Text(
                                      filteredHadiths[index].arabic ??
                                          'No text available',
                                      style: const TextStyle(
                                          fontSize: 18, wordSpacing: -0.9),
                                      textAlign: TextAlign.justify,
                                    ),
                                  ),
                                  Container(
                                    decoration: ShapeDecoration(
                                        color:
                                            AppColor.primary.withOpacity(0.8),
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(8),
                                                bottomRight:
                                                    Radius.circular(8)))),
                                    child: Padding(
                                      padding: EdgeInsets.fromLTRB(
                                          10.w, 10.h, 10.w, 10.h),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: CircleAvatar(
                                              radius: 20,
                                              backgroundColor: AppColor.white,
                                              child: IconButton(
                                                  onPressed: () async {
                                                    showShareBottomSheet(
                                                        context,
                                                        ShareHadisCheckbox(
                                                          hadis:
                                                              filteredHadiths[
                                                                          index]
                                                                      .arabic ??
                                                                  '',
                                                          category:
                                                              '  ${state.hadiths[0].metadata!.arabic!.title}  |  ${state.hadiths[0].chapters![widget.id - 1].arabic}  ',
                                                        ));
                                                  },
                                                  icon: Icon(
                                                    Icons.share,
                                                    size: 18,
                                                    color: AppColor.primary,
                                                  )),
                                            ),
                                          ),
                                          BlocConsumer<AddToFavouriteCubit,
                                              AddToFavouriteState>(
                                            listener: (context, stateC) {
                                              if (stateC
                                                  is AddToFavouriteSuccessState) {
                                                BlocProvider.of<FavouriteCubit>(
                                                        context)
                                                    .fetch7adisFavourite();
                                              }
                                            },
                                            builder: (context, stateC) {
                                              var favouriteCubit = BlocProvider
                                                  .of<FavouriteCubit>(context);
                                              bool isFavourite = favouriteCubit
                                                      .favourites7adis
                                                      ?.any((fav) =>
                                                          fav.name ==
                                                          (filteredHadiths[
                                                                      index]
                                                                  .arabic ??
                                                              '')) ??
                                                  false;

                                              return Expanded(
                                                child: CircleAvatar(
                                                  radius: 20,
                                                  backgroundColor:
                                                      AppColor.white,
                                                  child: IconButton(
                                                    onPressed: () {
                                                      add7adisToFav(
                                                          context,
                                                          isFavourite,
                                                          '${state.hadiths[0].metadata!.arabic!.title}  |  ${state.hadiths[0].chapters![widget.id - 1].arabic}',
                                                          filteredHadiths[index]
                                                                  .arabic ??
                                                              "");
                                                    },
                                                    icon: Icon(
                                                      isFavourite
                                                          ? Icons.favorite
                                                          : Icons
                                                              .favorite_border,
                                                      size: 18,
                                                      color: isFavourite
                                                          ? AppColor.red
                                                          : AppColor.primary,
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                          Expanded(
                                            child: CircleAvatar(
                                              radius: 20,
                                              backgroundColor: AppColor.white,
                                              child: IconButton(
                                                  onPressed: () {
                                                    Clipboard.setData(ClipboardData(
                                                            text: filteredHadiths[
                                                                        index]
                                                                    .arabic ??
                                                                ""))
                                                        .then((_) {
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                        const SnackBar(
                                                            content: Center(
                                                                child: Text(
                                                                    'تم النسخ إلى الحافظه'))),
                                                      );
                                                    });
                                                  },
                                                  icon: Icon(
                                                    Icons.copy,
                                                    size: 18,
                                                    color: AppColor.primary,
                                                  )),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox();
                    },
                  ),
                ),
              ],
            ),
          );
        }
        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  void add7adisToFav(
      BuildContext context, bool isFavourite, String category, String name) {
    var favourites = BlocProvider.of<FavouriteCubit>(context).favourites7adis;

    if (!isFavourite) {
      BlocProvider.of<AddToFavouriteCubit>(context).add7adisToFavourite(
        FavouriteModel(
          name: name,
          category: category,
        ),
      );
      setState(() {
        isFavourite = true;
      });
    } else {
      for (var fav in favourites!) {
        if (fav.name == name) {
          fav.delete();
          break;
        }
      }
      BlocProvider.of<FavouriteCubit>(context).fetch7adisFavourite();
      setState(() {
        isFavourite = false;
      });
    }
  }
}
