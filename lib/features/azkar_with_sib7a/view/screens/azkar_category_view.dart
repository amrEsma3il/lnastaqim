import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lnastaqim/core/constants/images.dart';
import 'package:lnastaqim/features/azkar_with_sib7a/data/models/AzkarModel.dart';
import 'package:lnastaqim/features/azkar_with_sib7a/view/widgets/other_category_list_view.dart';

import '../../../../core/constants/colors.dart';
import '../../business_logic/azkar_category_cubit/azkar_category_cubit.dart';
import '../widgets/adi3a_category_list_view.dart';
import '../widgets/azkar_category_list_view.dart';

class AzkarView extends StatefulWidget {
  const AzkarView({super.key});

  @override
  State<AzkarView> createState() => _AzkarViewState();
}

class _AzkarViewState extends State<AzkarView> {
  bool isAzkarListViewVisible = false;
  void toggleAzkarVisibility() {
    setState(() {
      isAzkarListViewVisible = !isAzkarListViewVisible;
    });
  }

  bool isAdi3aListViewVisible = false;
  void toggleAdi3aVisibility() {
    setState(() {
      isAdi3aListViewVisible = !isAdi3aListViewVisible;
    });
  }

  bool isOtherListViewVisible = false;
  void toggleOtherVisibility() {
    setState(() {
      isOtherListViewVisible = !isOtherListViewVisible;
    });
  }

  bool isSibhaVisible = false;
  void toggleSibhaVisibility() {
    setState(() {
      isSibhaVisible = !isSibhaVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<AzkarCategoryCubit, List<AzkarModel>>(
          builder: (context, state) {
            return Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AppImages.azkarBackground),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const Image(
                        image: AssetImage(AppImages.azkar),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      isAzkarListViewVisible
                          ? Container(
                              height: 41,
                              decoration: ShapeDecoration(
                                  shadows: [
                                    BoxShadow(
                                        offset: const Offset(0, -1),
                                        color: const Color(0xff000000)
                                            .withOpacity(0.25),
                                        blurRadius: 5,
                                        blurStyle: BlurStyle.outer,
                                        spreadRadius:
                                            BorderSide.strokeAlignInside)
                                  ],
                                  color: AppColor.white2,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15))),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10.0),
                                    child: Text(
                                      "الاذكار",
                                      style: TextStyle(
                                          color: AppColor.primary,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: toggleAzkarVisibility,
                                      icon: Icon(
                                        Icons.arrow_drop_down,
                                        color: AppColor.primary,
                                      )),
                                ],
                              ),
                            )
                          : Container(
                              height: 41,
                              decoration: ShapeDecoration(
                                  color: AppColor.primary,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15))),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(right: 10.0),
                                    child: Text(
                                      "الاذكار",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: toggleAzkarVisibility,
                                      icon: const Icon(
                                        Icons.arrow_drop_up,
                                        color: Colors.white,
                                      )),
                                ],
                              ),
                            ),
                      const SizedBox(
                        height: 20,
                      ),
                      Visibility(
                          visible: isAzkarListViewVisible,
                          child: SizedBox(
                              height: 400,
                              child: AzkarCategoryListView(items: state))),
                      isAdi3aListViewVisible
                          ? Container(
                              height: 41,
                              decoration: ShapeDecoration(
                                  shadows: [
                                    BoxShadow(
                                        offset: const Offset(0, -1),
                                        color: const Color(0xff000000)
                                            .withOpacity(0.25),
                                        blurRadius: 5,
                                        blurStyle: BlurStyle.outer,
                                        spreadRadius:
                                            BorderSide.strokeAlignInside)
                                  ],
                                  color: AppColor.white2,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15))),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10.0),
                                    child: Text(
                                      "الادعيه",
                                      style: TextStyle(
                                          color: AppColor.primary,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: toggleAdi3aVisibility,
                                      icon: Icon(
                                        Icons.arrow_drop_down,
                                        color: AppColor.primary,
                                      )),
                                ],
                              ),
                            )
                          : Container(
                              height: 41,
                              decoration: ShapeDecoration(
                                  color: AppColor.primary,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15))),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(right: 10.0),
                                    child: Text(
                                      "الادعيه",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: toggleAdi3aVisibility,
                                      icon: const Icon(
                                        Icons.arrow_drop_up,
                                        color: Colors.white,
                                      )),
                                ],
                              ),
                            ),
                      const SizedBox(
                        height: 20,
                      ),
                      Visibility(
                          visible: isAdi3aListViewVisible,
                          child: SizedBox(
                              height: 400,
                              child: Adi3aCategoryListView(items: state))),
                      isOtherListViewVisible
                          ? Container(
                              height: 41,
                              decoration: ShapeDecoration(
                                  shadows: [
                                    BoxShadow(
                                        offset: const Offset(0, -1),
                                        color: const Color(0xff000000)
                                            .withOpacity(0.25),
                                        blurRadius: 5,
                                        blurStyle: BlurStyle.outer,
                                        spreadRadius:
                                            BorderSide.strokeAlignInside)
                                  ],
                                  color: AppColor.white2,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15))),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10.0),
                                    child: Text(
                                      "اخرى",
                                      style: TextStyle(
                                          color: AppColor.primary,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: toggleOtherVisibility,
                                      icon: Icon(
                                        Icons.arrow_drop_down,
                                        color: AppColor.primary,
                                      )),
                                ],
                              ),
                            )
                          : Container(
                              height: 41,
                              decoration: ShapeDecoration(
                                  color: AppColor.primary,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15))),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(right: 10.0),
                                    child: Text(
                                      "اخرى",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: toggleOtherVisibility,
                                      icon: const Icon(
                                        Icons.arrow_drop_up,
                                        color: Colors.white,
                                      )),
                                ],
                              ),
                            ),
                      const SizedBox(
                        height: 20,
                      ),
                      Visibility(
                          visible: isOtherListViewVisible,
                          child: SizedBox(
                              height: 400,
                              child: OtherCategoryListView(items: state))),
                      isSibhaVisible
                          ? Container(
                              height: 41,
                              decoration: ShapeDecoration(
                                  shadows: [
                                    BoxShadow(
                                        offset: const Offset(0, -1),
                                        color: const Color(0xff000000)
                                            .withOpacity(0.25),
                                        blurRadius: 5,
                                        blurStyle: BlurStyle.outer,
                                        spreadRadius:
                                            BorderSide.strokeAlignInside)
                                  ],
                                  color: AppColor.white2,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15))),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10.0),
                                    child: Text(
                                      "السبحه",
                                      style: TextStyle(
                                          color: AppColor.primary,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: toggleSibhaVisibility,
                                      icon: Icon(
                                        Icons.arrow_drop_down,
                                        color: AppColor.primary,
                                      )),
                                ],
                              ),
                            )
                          : Container(
                              height: 41,
                              decoration: ShapeDecoration(
                                  color: AppColor.primary,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15))),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(right: 10.0),
                                    child: Text(
                                      "السبحه",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: toggleSibhaVisibility,
                                      icon: const Icon(
                                        Icons.arrow_drop_up,
                                        color: Colors.white,
                                      )),
                                ],
                              ),
                            ),
                      const SizedBox(
                        height: 20,
                      ),
                      Visibility(
                          visible: isSibhaVisible,
                          child: Container(
                            height: 250,
                            width: double.infinity,
                            decoration: ShapeDecoration(
                                color: AppColor.blueColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20))),
                          )),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
