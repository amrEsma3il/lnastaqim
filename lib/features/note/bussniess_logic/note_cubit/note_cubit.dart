import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import '../../../../core/constants/constants.dart';
import '../../data/models/note_model.dart';

part 'note_state.dart';

class NoteCubit extends Cubit<NoteState> {
  NoteCubit() : super(NoteInitial());

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

}
