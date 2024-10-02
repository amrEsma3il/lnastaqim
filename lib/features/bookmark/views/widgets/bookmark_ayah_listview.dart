import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';

import '../../../../core/constants/images.dart';
import '../../../quran/bussniess_logic/quran/quran_cubit.dart';
import '../../../quran/view/screens/moshaf_view.dart';
import '../../bussniess_logic/bookmark_cubit/bookmark_cubit.dart';
import '../../data/models/bookmark_model.dart';
import 'bookmark_ayah.dart';

class BookmarksAyahListView extends StatelessWidget {
  const BookmarksAyahListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BookmarkCubit, BookmarkState>(
      listener: (context, state) {},
      builder: (context, state) {
        List<BookmarkModel> bookmarks =
            BlocProvider.of<BookmarkCubit>(context).bookmarks ?? [];
        return bookmarks.isEmpty?Center(child: Image.asset(AppImages.ayaMark)): ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: bookmarks.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //       builder: (BuildContext context) => const MoshafView(
                  //         // indexP: 604 - int.parse(bookmarks[index].pageNum),
                  //       ),
                  //     ));
                       QuranCubit.get(context).clearScreen(context);
                       Get.back();

                             QuranCubit.get(context).pageController.jumpToPage( 604 - int.parse(bookmarks[index].pageNum));
                },
                child: BookmarkAyah(
                  bookmarkModel: bookmarks[index],
                ),
              );
            });
      },
    );
  }
}
