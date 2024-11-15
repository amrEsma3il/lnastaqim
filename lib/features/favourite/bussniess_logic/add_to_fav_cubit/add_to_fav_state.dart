
abstract class AddToFavouriteState {}

class ToFavouriteInitial extends AddToFavouriteState {}

class AddToFavouriteLoadingState extends AddToFavouriteState {}

class AddToFavouriteSuccessState extends AddToFavouriteState {}

class AddToFavouriteErrorState extends AddToFavouriteState {
  final String error;

  AddToFavouriteErrorState({required this.error});
}
