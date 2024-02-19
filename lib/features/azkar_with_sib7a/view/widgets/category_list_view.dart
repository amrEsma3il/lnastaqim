import 'package:flutter/material.dart';
import 'package:lnastaqim/features/azkar_with_sib7a/view/widgets/category_item.dart';

import '../../data/models/AzkarModel.dart';

class AzkarCategoryListView extends StatelessWidget {
  const AzkarCategoryListView({super.key, required this.items});

  final List<AzkarModel> items;
  @override
  Widget build(BuildContext context) {
    Set<String> uniqueCategories = {};
    for (var item in items) {
      uniqueCategories.add(item.category ?? "");
    }

    List<String> categoriesList = uniqueCategories.toList();

    return ListView.builder(
        itemCount: categoriesList.length,
        itemBuilder: (BuildContext context, int index) {
          List<AzkarModel> filteredItems = items
              .where((item) => item.category == categoriesList[index])
              .toList();

          return CategoryItem(
            azkarModels: filteredItems,
          );
        });
  }
}
