import 'package:hive/hive.dart';

part 'bookmark_model.g.dart';

@HiveType(typeId: 0)
class BookmarkModel extends HiveObject {
  @HiveField(0)
  String name;
  @HiveField(1)
  int ayahNum;
  @HiveField(2)
  String ayah;
  @HiveField(3)
  String pageNum;
  @HiveField(4)
  int color;

  BookmarkModel({
    required this.ayah,
    required this.ayahNum,
    required this.color,
    required this.name,
    required this.pageNum,
  });
}
//flutter packages pub run build_runner build
