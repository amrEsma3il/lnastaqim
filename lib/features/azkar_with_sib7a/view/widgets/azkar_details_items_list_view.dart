import 'package:flutter/material.dart';
import 'package:lnastaqim/features/azkar_with_sib7a/data/models/AzkarModel.dart';
import 'package:lnastaqim/features/azkar_with_sib7a/view/widgets/azkar_details_item.dart';

class AzkarDetailsItemsListView extends StatelessWidget {
  const AzkarDetailsItemsListView({
    super.key,
    required this.items,
    required this.category,
  });

  final List<AzkarModel> items;
  final String category;

  @override
  Widget build(BuildContext context) {
    final filteredItems =
        items.where((item) => item.category == category).toList();
    return ListView.builder(
        itemCount: filteredItems.length,
        itemBuilder: (BuildContext context, int index) {
          return AzkarDetailsItem(azkarModel: filteredItems[index]);
        });
  }
}
