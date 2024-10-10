import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../data/model/book_model.dart';

class BookItem extends StatelessWidget {
  const BookItem({super.key, required this.booksModel});
  final BooksModel booksModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: booksModel.onTap,
      child: Container(
        decoration: ShapeDecoration(
            color: booksModel.color,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(booksModel.image, width: 80.w, height: 80.h),
          ],
        ),
      ),
    );
  }
}
