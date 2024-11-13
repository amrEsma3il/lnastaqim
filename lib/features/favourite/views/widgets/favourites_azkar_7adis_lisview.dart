import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lnastaqim/features/favourite/views/widgets/fav_listview.dart';

import '../../bussniess_logic/favourites_cubit/favourite_cubit.dart';
import '../../data/models/favourite_model.dart';

class FavouritesAzkar7adisListView extends StatelessWidget {
  const FavouritesAzkar7adisListView({
    super.key,
    required this.isZekr,
  });

  final bool isZekr;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavouriteCubit, FavouriteState>(
      builder: (context, state) {
        List<FavouriteModel> favouritesAzkar =
            BlocProvider.of<FavouriteCubit>(context).favouritesAzkar ?? [];
        List<FavouriteModel> favourites7adis =
            BlocProvider.of<FavouriteCubit>(context).favourites7adis ?? [];
        return isZekr == true
            ? FavListView(
                isZekr: isZekr,
                favourite: favouritesAzkar,
              )
            : FavListView(
                isZekr: isZekr,
                favourite: favourites7adis,
              );
      },
    );
  }
}
