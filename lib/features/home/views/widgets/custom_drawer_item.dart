import 'package:flutter/material.dart';
import 'package:lnastaqim/features/home/data/models/drawer_item_model.dart';
import 'package:lnastaqim/features/home/views/widgets/inactive_active_drawer_item.dart';


class CustomDrawerItem extends StatelessWidget {
  const CustomDrawerItem(
      {super.key, required this.drawerItemModel, required this.isActive});
  final DrawerItemModel drawerItemModel;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return isActive
        ? ActiveCustomDrawerItem(drawerItemModel: drawerItemModel)
        : InActiveCustomDrawerItem(drawerItemModel: drawerItemModel);
  }
}
