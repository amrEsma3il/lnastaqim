import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lnastaqim/core/constants/images.dart';
import 'package:lnastaqim/features/azkar_with_sib7a/data/models/AzkarModel.dart';
import 'package:lnastaqim/features/azkar_with_sib7a/view/widgets/item_drop_menu.dart';
import 'package:lnastaqim/features/azkar_with_sib7a/view/widgets/other_category_list_view.dart';

import '../../../../core/constants/colors.dart';
import '../../../adi3a/views/widgets/adi3a_category_list_view.dart';
import '../../business_logic/azkar_category_cubit/azkar_category_cubit.dart';
import '../widgets/azkar_category_list_view.dart';

class AzkarView extends StatefulWidget {
  const AzkarView({super.key});

  @override
  State<AzkarView> createState() => _AzkarViewState();
}

class _AzkarViewState extends State<AzkarView> {
  bool isAzkarListViewVisible = false;

  bool isAdi3aListViewVisible = false;

  bool isOtherListViewVisible = false;

  bool isSibhaVisible = false;

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
                      ItemDropMenu(
                        category: "azkar",
                        text: "الأذكار",
                        widget: AzkarCategoryListView(items: state),
                      ),
                      ItemDropMenu(
                        category: "adi3a",
                        text: "الأدعية",
                        widget: Adi3aCategoryListView(items: state),
                      ),
                      ItemDropMenu(
                        category: "other",
                        text: "أخرى",
                        widget: OtherCategoryListView(items: state),
                      ),
                      ItemDropMenu(
                        category: "sibha",
                        text: "السبحه",
                        widget: Container(
                          height: 250,
                          width: double.infinity,
                          decoration: ShapeDecoration(
                              color: AppColor.blueColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20))),
                        ),
                      ),
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
