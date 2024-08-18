import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../quran/bussniess_logic/quran/quran_cubit.dart';
import '../../../quran/bussniess_logic/screen_tap_Visibility/screen_tap_visability.dart';
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
     
                      QuranCubit.get(context).clearScreen(context);
                 
                                    Get.back();
                             QuranCubit.get(context).pageController.jumpToPage(604 - int.parse(notes[index].pageNum));

                  QuranCubit.get(context).searchAya(notes[index].ayahNumInQuran);
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
