import 'package:flutter/material.dart';
import 'package:lnastaqim/features/home/data/models/drawer_item_model.dart';

class CustomDrawerItem extends StatelessWidget {
  const CustomDrawerItem({super.key, required this.drawerItemModel});
  final DrawerItemModel drawerItemModel;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: drawerItemModel.onTap,
          child: ListTile(
            leading: Icon(
              drawerItemModel.icon,
              color: const Color(0xff112351),
            ),
            title: Text(
              drawerItemModel.title,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Color(0xff112351)),
            ),
          ),
        ),
        const Divider(),
      ],
    );
  }
}
