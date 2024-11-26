import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lnastaqim/core/constants/images.dart';
import 'package:lnastaqim/core/utilits/widgets/custom_app_bar.dart';
import 'package:lnastaqim/features/azkar_with_sib7a/data/models/AzkarModel.dart';
import 'package:lnastaqim/features/azkar_with_sib7a/view/widgets/custom_menu.dart';
import 'package:lnastaqim/features/azkar_with_sib7a/view/widgets/item_drop_menu.dart';
import 'package:lnastaqim/features/azkar_with_sib7a/view/widgets/other_category_list_view.dart';

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
      appBar:  const CustomAppBar(
        actions: [
          CustomMenu(
            isZekr: true,
          ),
        ],
        title: "الاذكار",
        isZekr: true,
      ),
      body: BlocBuilder<AzkarCategoryCubit, List<AzkarModel>>(
        builder: (context, state) {
          return Container(
            height: MediaQuery.of(context).size.height, 
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppImages.azkarBackground),
                fit: BoxFit.cover,
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(30, 30, 30, 0),
                    child: Image(
                      image: AssetImage(AppImages.azkar),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
                    child: Column(
                      children: [
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
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
