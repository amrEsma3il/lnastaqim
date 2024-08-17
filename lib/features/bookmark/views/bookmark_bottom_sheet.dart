import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lnastaqim/features/bookmark/bussniess_logic/add_bookmark_cubit/add_bookmark_cubit.dart';
import 'package:lnastaqim/features/bookmark/views/widgets/bookmark_collection.dart';
import 'package:lnastaqim/features/bookmark/views/widgets/bookmark_item.dart';

import '../../../core/constants/colors.dart';
import '../bussniess_logic/bookmark_cubit/bookmark_cubit.dart';

void showBookmarkBottomSheet(BuildContext context, pageAyahs, moshafPageState) {
  showModalBottomSheet(
    context: context,
    backgroundColor: AppColor.blueColor.withOpacity(.95),
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(48.r), topLeft: Radius.circular(48.r))),
    builder: (context) => SizedBox(
      height: 400.h,
      width: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const BookMarkCollection(),
              BlocConsumer<AddBookmarkCubit, AddBookmarkState>(
                listener: (context, state) {
                  if (state is AddBookmarkSuccessState) {
                    BlocProvider.of<BookmarkCubit>(context).fetchBookmarks();
                    Navigator.pop(context);
                  }
                },
                builder: (context, state) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      BookmarkItem(
                        moshafPageState: moshafPageState,
                        pageAyahs: pageAyahs,
                        text: "علامه حمراء",
                        color: Colors.red,
                      ),
                      BookmarkItem(
                        moshafPageState: moshafPageState,
                        pageAyahs: pageAyahs,
                        text: "علامه زرقاء",
                        color: Colors.blue,
                      ),
                      BookmarkItem(
                        moshafPageState: moshafPageState,
                        pageAyahs: pageAyahs,
                        text: "علامه بنفسجيه",
                        color: Colors.purple,
                      ),
                      BookmarkItem(
                        moshafPageState: moshafPageState,
                        pageAyahs: pageAyahs,
                        text: "علامه خضراء",
                        color: Colors.green,
                      )
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
