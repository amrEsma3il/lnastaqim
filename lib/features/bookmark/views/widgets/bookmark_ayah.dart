import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lnastaqim/core/utilits/extensions/arabic_numbers.dart';
import 'package:lnastaqim/features/bookmark/data/models/bookmark_model.dart';

import '../../bussniess_logic/bookmark_cubit/bookmark_cubit.dart';

class BookmarkAyah extends StatelessWidget {
  const BookmarkAyah({super.key, required this.bookmarkModel});

  final BookmarkModel bookmarkModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
      child: Container(
        width: double.infinity,
        decoration: ShapeDecoration(
          color: Colors.grey.withOpacity(0.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.bookmark,
                color: Color(bookmarkModel.color),
              ),
              const SizedBox(
                width: 5,
              ),
              Expanded(
                flex: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${bookmarkModel.name}  الايه  ${bookmarkModel.ayahNum.toString().toArabic} ",
                      style: const TextStyle(
                        fontFamily: 'naskh',
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      bookmarkModel.ayah,
                      softWrap: true,
                      style: const TextStyle(
                        fontFamily: 'naskh',
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Column(
                children: [
                  CircleAvatar(
                    radius: 10,
                    backgroundColor: Colors.white,
                    child: Text(
                      bookmarkModel.pageNum.toArabic,
                      style: const TextStyle(
                        fontSize: 10,
                        fontFamily: 'naskh',
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      bookmarkModel.delete();
                      BlocProvider.of<BookmarkCubit>(context).fetchBookmarks();
                    },
                    child: const Icon(
                      Icons.delete,
                      size: 15,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
