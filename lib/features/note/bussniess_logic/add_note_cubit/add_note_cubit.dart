import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import '../../../../core/constants/constants.dart';
import '../../data/models/note_model.dart';

part 'add_note_state.dart';

class AddNoteCubit extends Cubit<AddNoteState> {
  AddNoteCubit() : super(NoteInitial());

  addNote(NoteModel noteModel) async {
    emit(AddNoteLoadingState());
    try {
      var notes = Hive.box<NoteModel>(kNoteBox);

      await notes.add(noteModel);
      emit(AddNoteSuccessState());
    } catch (error) {
      emit(AddNoteErrorState(error: error.toString()));
    }
  }
}
