import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lnastaqim/core/constants/images.dart';
import 'package:lnastaqim/features/azkar_with_sib7a/data/models/AzkarModel.dart';

import '../../../../core/constants/colors.dart';
import '../../business_logic/azkar_category_cubit/azkar_category_cubit.dart';
import '../widgets/category_list_view.dart';

class AzkarView extends StatefulWidget {
  const AzkarView({super.key});

  @override
  State<AzkarView> createState() => _AzkarViewState();
}

class _AzkarViewState extends State<AzkarView> {
  bool isListViewVisible = false;
  void toggleVisibility() {
    setState(() {
      isListViewVisible = !isListViewVisible;
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
                child: Column(
                  children: [
                    const Image(
                      image: AssetImage(AppImages.azkar),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    isListViewVisible
                        ? Container(
                            height: 41,
                            decoration: ShapeDecoration(
                                shadows: [
                                  BoxShadow(
                                      offset: const Offset(0, -1),
                                      color: const Color(0xff000000)
                                          .withOpacity(0.25),
                                      blurRadius: 16,
                                      blurStyle: BlurStyle.outer,
                                      spreadRadius:
                                          BorderSide.strokeAlignInside)
                                ],
                                color: AppColor.white2,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                    onPressed: toggleVisibility,
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                    onPressed: toggleVisibility,
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
                        visible: isListViewVisible,
                        child: Expanded(
                            child: AzkarCategoryListView(items: state))),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
