import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'memorized_verse_state.dart';

class MemorizedVerseCubit extends Cubit<MemorizedVerseState> {
  MemorizedVerseCubit() : super(MemorizedVerseState.initial());
 
static MemorizedVerseCubit get(BuildContext context)=>BlocProvider.of<MemorizedVerseCubit>(context);
  void toggleVisibility(List<int> verses) {
    // Create a new list based on the current state
    final updatedVerses = List<int>.from(state.versesNum);

    if (state.isVisible) {
      updatedVerses.clear();
      updatedVerses.addAll(verses);
    } else {
      updatedVerses.clear();
    }
    emit(state.copyWith(isVisible: !state.isVisible, versesNum: updatedVerses));
  }

  void updateVerseNum(int verse) {
    // Create a new list to avoid modifying the original state directly
    final updatedVerses = List<int>.from(state.versesNum);

    if (updatedVerses.contains(verse)) {
      updatedVerses.remove(verse);
    } else {
      updatedVerses.add(verse);
    }
    emit(state.copyWith(versesNum: updatedVerses));
  }
}
