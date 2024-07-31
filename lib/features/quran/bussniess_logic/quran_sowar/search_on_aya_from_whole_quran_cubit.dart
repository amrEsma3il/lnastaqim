import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/search_ayah_entity.dart';
import '../quran/quran_cubit.dart';


class SearchOnAyaCubit extends Cubit< List<SearchAyahEntity>> {
  SearchOnAyaCubit() : super([]);
  static SearchOnAyaCubit get(BuildContext context) =>
      BlocProvider.of<SearchOnAyaCubit>(context);
  TextEditingController searchController=TextEditingController();
  LayerLink layerLink=LayerLink();

  searchEvent(BuildContext context){
if (searchController.text.isEmpty) {
  emit([]);
} else {
  
List<SearchAyahEntity> result=  QuranCubit.get(context).searchInMoshaf(searchText: searchController.text);

if (result.isEmpty) {
  emit([]);
} else {
  emit(result);
}
}
  
  }

clearSearchEvent(){
searchController.text="";
  emit([]);
}
  

}





enum SearchState{
  noSearch,
  searchNoResults,
  searchHasResults
}