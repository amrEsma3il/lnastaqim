import 'package:flutter/material.dart';
import 'package:lnastaqim/core/constants/colors.dart';
import 'package:lnastaqim/features/home/data/models/drawer_item_model.dart';

class InActiveCustomDrawerItem extends StatelessWidget {
  const InActiveCustomDrawerItem({super.key, required this.drawerItemModel});
  final DrawerItemModel drawerItemModel;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: drawerItemModel.onTap,
      child: ListTile(
        leading: Icon(
          drawerItemModel.icon,
          color: AppColor.white,
        ),
        title: Text(
          drawerItemModel.title,
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20, color: AppColor.white),
        ),
      ),
    );
  }
}

class ActiveCustomDrawerItem extends StatelessWidget {
  const ActiveCustomDrawerItem({super.key, required this.drawerItemModel});
  final DrawerItemModel drawerItemModel;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: drawerItemModel.onTap,
      child: Container(
        color: AppColor.white,
        child: ListTile(
          leading: Icon(
            drawerItemModel.icon,
            color: AppColor.primary,
          ),
          title: Text(
            drawerItemModel.title,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: AppColor.primary),
          ),
        ),
      ),
    );
  }
}
