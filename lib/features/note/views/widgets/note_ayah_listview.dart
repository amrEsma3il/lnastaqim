import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../quran/view/screens/moshaf_view.dart';
import '../../bussniess_logic/note_cubit/note_cubit.dart';
import '../../data/models/note_model.dart';
import 'note_ayah.dart';

class NoteAyahListView extends StatelessWidget {
  const NoteAyahListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NoteCubit, NoteState>(
      listener: (context, state) {},
      builder: (context, state) {
        List<NoteModel> notes = BlocProvider.of<NoteCubit>(context).notes ?? [];
        return ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: notes.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => MoshafView(
                          indexP: 604 - int.parse(notes[index].pageNum),
                        ),
                      ));
                },
                child: NoteAyah(
                  noteModel: notes[index],
                ),
              );
            });
      },
    );
  }
}
