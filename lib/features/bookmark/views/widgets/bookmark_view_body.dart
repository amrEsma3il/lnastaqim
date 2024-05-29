import 'package:flutter/material.dart';

import 'bookmark_ayah_listview.dart';

class BookMarkViewBody extends StatelessWidget {
  const BookMarkViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("المرجعيات"),
          centerTitle: true,
          elevation: 0,
        ),
        body: const BookmarksAyahListView());
  }
}
