import 'package:flutter/material.dart';

import 'note_ayah_listview.dart';

class NoteViewBody extends StatelessWidget {
  const NoteViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("الملاحظات"),
          centerTitle: true,
          elevation: 0,
        ),
        body: const NoteAyahListView());
  }
}
