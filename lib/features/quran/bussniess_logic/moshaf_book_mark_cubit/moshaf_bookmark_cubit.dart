


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:shared_preferences/shared_preferences.dart';

import 'moshaf_bookmark_state.dart';

class MoshafBookmarkCubit extends Cubit<MoshafBookmarkState> {
  MoshafBookmarkCubit() : super(MoshafBookmarkState.initial()) {
    // _loadBookmark();
  }

  // Load bookmark from cache
  // Future<void> _loadBookmark() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final isMark = prefs.getBool('isMark') ?? false;
  //   final pageNumber = prefs.getInt('pageNumber') ?? 0;

  //   emit(state.copyWith(isMark: isMark, pageNumber: pageNumber));
  // }
static MoshafBookmarkCubit get(BuildContext context)=>BlocProvider.of<MoshafBookmarkCubit>(context);
  // Update bookmark and save to cache
  Future<void> updateBookmark( int pageNumber) async {
    // final prefs = await SharedPreferences.getInstance();
    // await prefs.setBool('isMark', isMark);
    // await prefs.setInt('pageNumber', pageNumber);

    emit(state.copyWith(isMark: !state.isMark, pageNumber: pageNumber));

    // if (p) {
      
    // }
  }
}
