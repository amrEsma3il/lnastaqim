import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:lnastaqim/features/favourite/bussniess_logic/add_to_fav_cubit/add_to_fav_state.dart';
import 'package:lnastaqim/features/favourite/data/models/favourite_model.dart';

import '../../../../core/constants/constants.dart';

class AddToFavouriteCubit extends Cubit<AddToFavouriteState> {
  AddToFavouriteCubit() : super(ToFavouriteInitial());

  addAzkarToFavourite(FavouriteModel favouriteModel) async {
    emit(AddToFavouriteLoadingState());
    try {
      var favouriteBox = Hive.box<FavouriteModel>(kAzkarFavouriteBox);

      await favouriteBox.add(favouriteModel);
      emit(AddToFavouriteSuccessState());
    } catch (error) {
      emit(AddToFavouriteErrorState(error: error.toString()));
    }
  }

  add7adisToFavourite(FavouriteModel favouriteModel) async {
    emit(AddToFavouriteLoadingState());
    try {
      var favouriteBox = Hive.box<FavouriteModel>(k7adisFavouriteBox);

      await favouriteBox.add(favouriteModel);
      emit(AddToFavouriteSuccessState());
    } catch (error) {
      emit(AddToFavouriteErrorState(error: error.toString()));
    }
  }
}
