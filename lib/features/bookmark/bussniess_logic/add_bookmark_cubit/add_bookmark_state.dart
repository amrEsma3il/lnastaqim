part of 'add_bookmark_cubit.dart';

abstract class AddBookmarkState {}

class BookmarkInitial extends AddBookmarkState {}

class AddBookmarkLoadingState extends AddBookmarkState {}

class AddBookmarkSuccessState extends AddBookmarkState {}

class AddBookmarkErrorState extends AddBookmarkState {
  final String error;

  AddBookmarkErrorState({required this.error});
}
