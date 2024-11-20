import 'package:flutter/material.dart';

class DrawerItemModel {
  final IconData icon;
  final String title;
  final void Function()? onTap;

  DrawerItemModel({
    required this.icon,
    required this.title,
    this.onTap,
  });
}
