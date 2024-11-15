import 'package:hive/hive.dart';

part 'favourite_model.g.dart';

@HiveType(typeId: 2)
class FavouriteModel extends HiveObject {
  @HiveField(0)
  String name;
  @HiveField(1)
  String category;

  FavouriteModel({
    required this.name,
    required this.category,
  });
}
//flutter packages pub run build_runner build
