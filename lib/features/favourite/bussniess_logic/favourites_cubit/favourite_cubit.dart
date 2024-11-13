import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:lnastaqim/core/constants/constants.dart';
import 'package:lnastaqim/features/favourite/data/models/favourite_model.dart';

part 'favourite_state.dart';

class FavouriteCubit extends Cubit<FavouriteState> {
  FavouriteCubit() : super(FavouriteInitial());

  List<FavouriteModel>? favouritesAzkar;
  fetchAzkarFavourite() {
    var favouritesBox = Hive.box<FavouriteModel>(kAzkarFavouriteBox);
    favouritesAzkar = favouritesBox.values.toList();
    emit(FavouriteSuccessState());
  }
  List<FavouriteModel>? favourites7adis;

  fetch7adisFavourite() {
    var favouritesBox = Hive.box<FavouriteModel>(k7adisFavouriteBox);
    favourites7adis = favouritesBox.values.toList();
    emit(FavouriteSuccessState());
  }
}
