import 'package:flutter/material.dart';
import 'package:lnastaqim/features/favourite/views/widgets/favourites_view_body.dart';

class FavouritesView extends StatelessWidget {
  const FavouritesView({super.key, required this.isZekr});

final bool isZekr;
  @override
  Widget build(BuildContext context) {
    return  Favouritesviewbody(isZekr: isZekr,);
  }
}
