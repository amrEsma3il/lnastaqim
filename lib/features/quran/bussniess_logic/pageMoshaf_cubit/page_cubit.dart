import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'page_state.dart';

class MoshafPageCubit extends Cubit<MoshafPageState> {
  MoshafPageCubit() : super(MoshafPageState.initial());
static MoshafPageCubit get(BuildContext context)=>BlocProvider.of<MoshafPageCubit>(context);
  // Method to update the page and its ayahs
changeAyaIndex(int ayaIndex){
    emit(state.copyWith(ayahIndex: ayaIndex));

}
  initPage(){
      emit(state.copyWith( pageNum: 603));
  }
  void updatePage( int newPageNum) {
    emit(state.copyWith( pageNum: newPageNum));
  }
}
