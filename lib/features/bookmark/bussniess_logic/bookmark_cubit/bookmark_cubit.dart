import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:lnastaqim/core/constants/constants.dart';
import 'package:lnastaqim/features/bookmark/data/models/bookmark_model.dart';

part 'bookmark_state.dart';

class BookmarkCubit extends Cubit<BookmarkState> {
  BookmarkCubit() : super(BookmarkInitial());

  List<BookmarkModel>? bookmarks;
  fetchBookmarks() {
    var bookmarkBox = Hive.box<BookmarkModel>(kBookmarkBox);
    bookmarks = bookmarkBox.values.toList();
    emit(BookmarkSuccessState());
  }
}
