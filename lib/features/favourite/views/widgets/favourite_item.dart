import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lnastaqim/features/favourite/data/models/favourite_model.dart';

import '../../../../core/constants/colors.dart';
import '../../bussniess_logic/favourites_cubit/favourite_cubit.dart';

class FavouriteItem extends StatelessWidget {
  const FavouriteItem({super.key, required this.favouriteModel});

  final FavouriteModel favouriteModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Container(
        width: double.infinity,
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(11),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 10, 16, 0),
          child: Column(
            children: [
              Column(children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 10,
                  ),
                  child: Container(
                    height: 30,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColor.primary.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        favouriteModel.category,
                        style: const TextStyle(
                            fontFamily: 'Authmanic',
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
              ]),
              Text(
                favouriteModel.name,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: AppColor.blueColor,
                  fontSize: 15.8,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'naskh',
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      const CircleAvatar(
                        backgroundColor: Color.fromARGB(255, 220, 177, 177),
                        radius: 14,
                      ),
                      IconButton(
                          onPressed: () {
                            favouriteModel.delete();
                            BlocProvider.of<FavouriteCubit>(context)
                                .fetchFavourite();
                          },
                          icon: const Icon(
                            Icons.delete_outlined,
                            color: Color.fromARGB(255, 202, 56, 45),
                            size: 18,
                          )),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
