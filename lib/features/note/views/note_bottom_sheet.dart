import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lnastaqim/features/note/views/widgets/note_collection.dart';

import '../../../core/constants/colors.dart';
import '../../../core/utilits/functions/toast_message.dart';
import '../../quran/bussniess_logic/quran/quran_cubit.dart';
import '../../quran/data/models/surahs_model.dart';
import '../bussniess_logic/add_note_cubit/add_note_cubit.dart';
import '../bussniess_logic/note_cubit/note_cubit.dart';
import '../data/models/note_model.dart';

void showNoteBottomSheet(BuildContext context,Ayah selectedAyah) {
  TextEditingController noteController = TextEditingController();
  showModalBottomSheet(
    context: context,
    backgroundColor:AppColor.blueColor.withOpacity(0.95),
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
                         style: const TextStyle(color: Colors.white),
                        controller: noteController,
                        maxLines: 10,
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                              borderSide:
                                  const BorderSide(color: Colors.white,width: 0.5),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                              borderSide:
                                  const BorderSide(color: Colors.white,width: 0.5),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                              borderSide:
                                  const BorderSide(color: Colors.white,width: 0.5),
                            ),
                            hintText: "أضف ملاحظة...",
                            hintStyle: const TextStyle(
                                // fontFamily: "naskh",
                                fontSize: 18.5,
                                color: Colors.white)),
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(
                            height: 40,
                            width: 95,
                            child: ElevatedButton(
                                onPressed: () {

                                  if (noteController.text.isNotEmpty) {
                                       var name = QuranCubit.get(context)
                                      .getSurahNameFromAyah(selectedAyah);
                                  var note = NoteModel(ayahNumInQuran: selectedAyah.ayahUQNumber,
                                    note: noteController.text,
                                    ayahNum: selectedAyah.ayahNumber,
                                    surahName: name,
                                    pageNum: selectedAyah.page.toString(),
                                  );

                                  BlocProvider.of<AddNoteCubit>(context)
                                      .addNote(note);
                                  } else {
                                    showToast("قم باضافة ملاحظة",AppColor.lightBlue.withOpacity(0.35));
                                  }
                               
                                },
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                      Colors.white),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12.r),
                                    ))),
                                child: const Text(
                                  "حفظ",
                                  style: TextStyle(
                                      // fontFamily: "naskh",
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color:AppColor.blueColor),
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
