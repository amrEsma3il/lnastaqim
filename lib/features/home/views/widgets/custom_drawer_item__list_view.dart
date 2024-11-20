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
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final items = [
      DrawerItemModel(
          icon: Icons.home,
          title: "الصفحه الرئيسيه",
          onTap: () {
            widget.scaffoldKey.currentState!.closeEndDrawer();
          }),
      DrawerItemModel(
          icon: Icons.favorite,
          title: "المفضلة",
          onTap: () {
            widget.scaffoldKey.currentState!.closeEndDrawer();
            Get.toNamed(AppRouteName.fav7adis);
          }),
      DrawerItemModel(
        onTap: () {
          widget.scaffoldKey.currentState!.closeEndDrawer();
        },
        icon: Icons.settings,
        title: "الاعدادات",
      ),
      DrawerItemModel(
        onTap: () {
          widget.scaffoldKey.currentState!.closeEndDrawer();
        },
        icon: Icons.help,
        title: "مساعدة",
      ),
      DrawerItemModel(
        onTap: () {
          widget.scaffoldKey.currentState!.closeEndDrawer();
        },
        icon: Icons.share,
        title: "مشاركة التطبيق",
      ),
      DrawerItemModel(
        onTap: () {
          widget.scaffoldKey.currentState!.closeEndDrawer();
        },
        icon: Icons.rate_review,
        title: "تقييم التطبيق",
      ),
      DrawerItemModel(
        icon: Icons.info,
        title: "من نحن ",
        onTap: () {},
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
                isActive: selectedIndex == index,
              ),
            );
          }),
    );
  }
}
