import 'package:flutter/material.dart';
import 'package:lnastaqim/features/favourite/data/models/favourite_model.dart';
import 'package:lnastaqim/features/favourite/views/widgets/favourite_item.dart';

class FavListView extends StatelessWidget {
  const FavListView({
    super.key,
    required this.isZekr,
    required this.favourite,
  });

  final bool isZekr;
  final List<FavouriteModel> favourite;

  @override
  Widget build(BuildContext context) {
    return favourite.isEmpty
        ? Center(
            child: Text(
            isZekr == true
                ? "لا توجد اذكار في المفضلة!"
                : "لا يوجد احاديث في المفضلة!",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontFamily: "naskh",
              fontWeight: FontWeight.bold,
            ),
          ))
        : ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: favourite.length,
            itemBuilder: (BuildContext context, int index) {
              return FavouriteItem(
                isZekr: isZekr,
                favouriteModel: favourite[index],
              );
            });
  }
}
