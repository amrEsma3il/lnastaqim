import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/constants.dart';
import '../../data/models/note_model.dart';

part 'note_state.dart';

class NoteCubit extends Cubit<NoteState> {
  NoteCubit() : super(NoteInitial());

  TextEditingController noteEditController = TextEditingController();
  static NoteCubit get(BuildContext context) =>
      BlocProvider.of<NoteCubit>(context);
  List<NoteModel>? notes;
  fetchNotes() {
    var notesBox = Hive.box<NoteModel>(kNoteBox);
    notes = notesBox.values.toList();
    emit(NoteSuccessState());
  }

  static updateNote(NoteModel note, String newNote) {
    note.note = newNote;
    // Save the updated note
    note.save();
  }

  showEditNoteDialog(BuildContext context, NoteModel note) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        noteEditController.text = note.note;
        return AlertDialog(
          backgroundColor: AppColor.blueColor.withOpacity(0.89),
          contentPadding: const EdgeInsets.all(20),
          title: const Text(
            "تعديل الملاحظة",
            style: TextStyle(color: Colors.white, fontSize: 25),
            textAlign: TextAlign.right,
          ),
          content: SizedBox(
            width: Get.width,
            height: Get.height / 7 * 2.9,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 5.h,
                ),

                // text field here

                TextFormField(
                  style: const TextStyle(color: Colors.white),
                  controller: noteEditController,
                  maxLines: 10,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide:
                            const BorderSide(color: Colors.white, width: 0.5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide:
                            const BorderSide(color: Colors.white, width: 0.5),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide:
                            const BorderSide(color: Colors.white, width: 0.5),
                      ),
                      // hintText: "أضف ملاحظة...",
                      hintStyle: const TextStyle(
                          // fontFamily: "naskh",
                          fontSize: 18.5,
                          color: Colors.white)),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: 40,
                      width: 85,
                      child: ElevatedButton(
                          onPressed: () {
                            Get.back();
                          },
                          style: ButtonStyle(
                              backgroundColor:
                                  WidgetStateProperty.all(Colors.white),
                              shape: WidgetStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.r),
                              ))),
                          child: const Text(
                            "الغاء",
                            style: TextStyle(
                                // fontFamily: "naskh",
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                                color: AppColor.blueColor),
                          )),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      height: 40,
                      width: 85,
                      child: ElevatedButton(
                          onPressed: () {
                            updateNote(note, noteEditController.text);
                            fetchNotes();
                            Get.back();
                          },
                          style: ButtonStyle(
                              backgroundColor:
                                  WidgetStateProperty.all(Colors.white),
                              shape: WidgetStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.r),
                              ))),
                          child: const Text(
                            "حفظ",
                            style: TextStyle(
                                // fontFamily: "naskh",
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                                color: AppColor.blueColor),
                          )),
                    ),
                  ],
                )
              ],
            ),
          ),

          // actions: [

          //   TextButton(
          //     onPressed: () {
          //       Get.back();
          //     },
          //     child: const Text(
          //       'الغاء',
          //       style: TextStyle(color: Colors.white),
          //     ),
          //   ),
          //    TextButton(
          //     onPressed: () {
          //       // implement edit/update note here

          //       updateNote(note, noteEditController.text);
          //       fetchNotes();
          //       Get.back();
          //     },
          //     child: const Text(
          //       'حفظ',
          //       style: TextStyle(color: Colors.white),
          //     ),
          //   ),
          // ],
        );
      },
    );
  }
}
