import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bussniess_logic/favourites_cubit/favourite_cubit.dart';
import '../../data/models/favourite_model.dart';
import 'favourite_item.dart';

class FavouritesAzkarListView extends StatelessWidget {
  const FavouritesAzkarListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FavouriteCubit, FavouriteState>(
      listener: (context, state) {},
      builder: (context, state) {
        List<FavouriteModel> favourites =
            BlocProvider.of<FavouriteCubit>(context).favourites ?? [];
        return favourites.isEmpty
            ? const Center(
                child: Text(
                "لا توجد اذكار مفضلة!",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontFamily: "naskh",
                  fontWeight: FontWeight.bold,
                ),
              ))
            : ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: favourites.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //       builder: (BuildContext context) => const MoshafView(
                      //         // indexP: 604 - int.parse(Favourites[index].pageNum),
                      //       ),
                      //     ));
                    },
                    child: FavouriteItem(
                      favouriteModel: favourites[index],
                    ),
                  );
                });
      },
    );
  }
}
