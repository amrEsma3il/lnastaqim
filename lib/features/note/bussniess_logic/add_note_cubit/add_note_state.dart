part of 'add_note_cubit.dart';

abstract class AddNoteState {}

class NoteInitial extends AddNoteState {}

class AddNoteLoadingState extends AddNoteState {}

class AddNoteSuccessState extends AddNoteState {}

class AddNoteErrorState extends AddNoteState {
  final String error;

  AddNoteErrorState({required this.error});
}
