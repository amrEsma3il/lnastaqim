import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lnastaqim/features/note/views/widgets/note_collection.dart';

import '../../quran/bussniess_logic/quran/quran_cubit.dart';
import '../bussniess_logic/add_note_cubit/add_note_cubit.dart';
import '../bussniess_logic/note_cubit/note_cubit.dart';
import '../data/models/note_model.dart';

void showNoteBottomSheet(BuildContext context, selectedAyah) {
  TextEditingController noteController = TextEditingController();
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.grey.shade400,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(48.r), topLeft: Radius.circular(48.r))),
    builder: (context) => SizedBox(
      height: 600.h,
      width: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const NoteCollection(),
              BlocConsumer<AddNoteCubit, AddNoteState>(
                listener: (context, state) {
                  if (state is AddNoteSuccessState) {
                    BlocProvider.of<NoteCubit>(context).fetchNotes();
                    Navigator.pop(context);
                  }
                },
                builder: (context, state) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      TextFormField(
                        controller: noteController,
                        maxLines: 10,
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                              borderSide:
                                  const BorderSide(color: Color(0xff10355b)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                              borderSide:
                                  const BorderSide(color: Color(0xff10355b)),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                              borderSide:
                                  const BorderSide(color: Color(0xff10355b)),
                            ),
                            hintText: "أضف ملاحظه",
                            hintStyle: const TextStyle(
                                fontFamily: "naskh",
                                fontSize: 22,
                                color: Colors.grey)),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(
                            height: 50,
                            width: 100,
                            child: ElevatedButton(
                                onPressed: () {
                                  var name = QuranCubit.get(context)
                                      .getSurahNameFromAyah(selectedAyah);
                                  var note = NoteModel(
                                    note: noteController.text,
                                    ayahNum: selectedAyah.ayahNumber,
                                    surahName: name,
                                    pageNum: selectedAyah.page.toString(),
                                  );

                                  BlocProvider.of<AddNoteCubit>(context)
                                      .addNote(note);
                                },
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        const Color(0xff10355b)),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6.0),
                                    ))),
                                child: const Text(
                                  "حفظ",
                                  style: TextStyle(
                                      fontFamily: "naskh",
                                      fontSize: 15,
                                      color: Colors.white),
                                )),
                          )
                        ],
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
