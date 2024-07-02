import 'package:hive/hive.dart';

part 'note_model.g.dart';

@HiveType(typeId: 1)
class NoteModel extends HiveObject {
  @HiveField(0)
  String note;
  @HiveField(1)
  int ayahNum;
  @HiveField(3)
  String pageNum;
  @HiveField(4)
  String surahName;

  NoteModel({
    required this.note,
    required this.ayahNum,
    required this.pageNum,
    required this.surahName,
  });
}
//flutter packages pub run build_runner build
