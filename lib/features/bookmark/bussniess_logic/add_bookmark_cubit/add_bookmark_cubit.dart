import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:lnastaqim/features/bookmark/data/models/bookmark_model.dart';

import '../../../../core/constants/constants.dart';

part 'add_bookmark_state.dart';

class AddBookmarkCubit extends Cubit<AddBookmarkState> {
  AddBookmarkCubit() : super(BookmarkInitial());

  addBookmark(BookmarkModel bookmarkModel) async {
    emit(AddBookmarkLoadingState());
    try {
      var bookmarkBox = Hive.box<BookmarkModel>(kBookmarkBox);

      await bookmarkBox.add(bookmarkModel);
      emit(AddBookmarkSuccessState());
    } catch (error) {
      emit(AddBookmarkErrorState(error: error.toString()));
    }
  }
}
