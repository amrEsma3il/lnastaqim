import 'package:flutter/material.dart';

class BooksModel {
  final int id;
  final String name;
  final Color color;
  final String image;
  final void Function()? onTap;

  BooksModel(
      {required this.id,
      required this.name,
      required this.color,
      required this.image,
      required this.onTap});
}
