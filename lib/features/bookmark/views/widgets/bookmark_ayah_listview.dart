import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        return ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: bookmarks.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => MoshafView(
                          indexP: 604 - int.parse(bookmarks[index].pageNum),
                        ),
                      ));
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
