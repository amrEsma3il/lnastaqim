import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:lnastaqim/config/routing/app_routes_info/app_routes_name.dart';
import 'package:lnastaqim/features/azkar_with_sib7a/view/widgets/category_item.dart';

import '../../data/models/AzkarModel.dart';

class OtherCategoryListView extends StatefulWidget {
  const OtherCategoryListView({super.key, required this.items});

  final List<AzkarModel> items;

  @override
  State<OtherCategoryListView> createState() => _OtherCategoryListViewState();
}

class _OtherCategoryListViewState extends State<OtherCategoryListView>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    animation = Tween<double>(begin: 0, end: 1).animate(controller);
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Set<String> uniqueCategories = {};
    for (var item in widget.items) {
      uniqueCategories.add(item.category ?? "");
    }

    List<String> categoriesList = uniqueCategories
        .where((category) =>
            !category.contains("دعاء") &&
            !category.contains("الدعاء") &&
            !category.contains("من أدعية") &&
            !category.contains("أذكار") &&
            !category.contains("الذكر") &&
            !category.contains("الأذكار") &&
            !category.contains("ذكر"))
        .toList();

    return AnimationLimiter(
      child: ListView.builder(
          itemCount: categoriesList.length,
          itemBuilder: (BuildContext context, int index) {
            List<AzkarModel> filteredItems = widget.items
                .where((item) => item.category == categoriesList[index])
                .toList();

            return AnimationConfiguration.staggeredList(
              position: index,
              duration: const Duration(milliseconds: 500),
              child: SlideAnimation(
                verticalOffset: 50,
                child: FadeInAnimation(
                  child: GestureDetector(
                    onTap: () {
                      Get.toNamed(AppRouteName.azkarDetails,
                          arguments: categoriesList[index]);
                    },
                    child: CategoryItem(
                      azkarModels: filteredItems,
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}