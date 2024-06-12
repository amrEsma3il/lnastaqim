import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lnastaqim/core/utilits/extensions/arabic_numbers.dart';

import '../../bussniess_logic/note_cubit/note_cubit.dart';
import '../../data/models/note_model.dart';

class NoteAyah extends StatelessWidget {
  const NoteAyah({super.key, required this.noteModel});

  final NoteModel noteModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
      child: Container(
        width: double.infinity,
        decoration: ShapeDecoration(
          color: Colors.grey.withOpacity(0.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${noteModel.surahName}  الايه  ${noteModel.ayahNum.toString().toArabic} ",
                      style: const TextStyle(
                        fontFamily: 'naskh',
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      noteModel.note,
                      softWrap: true,
                      style: const TextStyle(),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Column(
                children: [
                  CircleAvatar(
                    radius: 10,
                    backgroundColor: Colors.white,
                    child: Text(
                      noteModel.pageNum.toArabic,
                      style: const TextStyle(
                        fontSize: 10,
                        fontFamily: 'naskh',
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      noteModel.delete();
                      BlocProvider.of<NoteCubit>(context).fetchNotes();
                    },
                    child: const Icon(
                      Icons.delete,
                      size: 15,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
