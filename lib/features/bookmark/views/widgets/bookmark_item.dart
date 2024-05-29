import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lnastaqim/features/bookmark/bussniess_logic/bookmark_cubit/bookmark_cubit.dart';

import '../../../quran/bussniess_logic/quran/quran_cubit.dart';
import '../../../quran/data/models/select_aya_model.dart';
import '../../../quran/data/models/surahs_model.dart';
import '../../bussniess_logic/add_bookmark_cubit/add_bookmark_cubit.dart';
import '../../data/models/bookmark_model.dart';

class BookmarkItem extends StatelessWidget {
  const BookmarkItem(
      {super.key,
      required this.text,
      required this.color,
      required this.pageAyahs,
      required this.moshafPageState});

  final String text;
  final Color color;
  final List<List<Ayah>> pageAyahs;
  final SelectAyaModel moshafPageState;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final selectedAyah = pageAyahs
            .expand((ayahList) => ayahList)
            .firstWhere(
                (ayah) => ayah.ayahUQNumber == moshafPageState.ayaNumber);

        var name = QuranCubit.get(context).getSurahNameFromAyah(selectedAyah);
        var bookmark = BookmarkModel(
          color: color.value,
          ayah: selectedAyah.text,
          ayahNum: selectedAyah.ayahNumber,
          name: name,
          pageNum: selectedAyah.page.toString(),
        );

        var bookmarks = BlocProvider.of<BookmarkCubit>(context).bookmarks;

        bool isBookmarked = false;

        for (var bookmark in bookmarks!) {
          if (bookmark.ayah == selectedAyah.text) {
            isBookmarked = true;
            break;
          }
        }

        if (!isBookmarked) {
          BlocProvider.of<AddBookmarkCubit>(context).addBookmark(bookmark);
        } else {
          Fluttertoast.showToast(
              msg: "Already found !",
              backgroundColor: Colors.grey.withOpacity(0.5));
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: Row(
          children: [
            Icon(
              Icons.bookmark_add_outlined,
              color: color,
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              text,
              style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
