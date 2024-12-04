import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lnastaqim/config/routing/app_routes_info/app_routes_name.dart';
import 'package:lnastaqim/features/home/data/models/drawer_item_model.dart';
import 'package:lnastaqim/features/home/views/widgets/custom_drawer_item.dart';

class CustomDrawerItemListView extends StatefulWidget {
  const CustomDrawerItemListView({super.key, required this.scaffoldKey});

  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  State<CustomDrawerItemListView> createState() =>
      _CustomDrawerItemListViewState();
}

class _CustomDrawerItemListViewState extends State<CustomDrawerItemListView> {
  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    final items = [
      DrawerItemModel(
          icon: Icons.favorite,
          title: "المفضلة",
          onTap: () {
            widget.scaffoldKey.currentState!.closeEndDrawer();
            Get.toNamed(AppRouteName.generalFav);
          }),
      DrawerItemModel(
        onTap: () {
          widget.scaffoldKey.currentState!.closeEndDrawer();
          Get.toNamed(AppRouteName.setting);
        },
        icon: Icons.settings,
        title: "الاعدادات",
      ),
      DrawerItemModel(
        icon: Icons.info,
        title: "الدعم",
        onTap: () {
          widget.scaffoldKey.currentState!.closeEndDrawer();

          Get.toNamed(AppRouteName.support);
        },
      ),
    ];

    return SizedBox(
      height: MediaQuery.sizeOf(context).height,
      child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                if (selectedIndex != index) {
                  setState(() {
                    selectedIndex = index;
                  });
                }
              },
              child: CustomDrawerItem(
                drawerItemModel: items[index],
              ),
            );
          }),
    );
  }
}
