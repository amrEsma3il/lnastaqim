import 'package:hive/hive.dart';

part 'note_model.g.dart';

@HiveType(typeId: 1)
class NoteModel extends HiveObject {
  @HiveField(0)
  String note;
  @HiveField(1)
  int ayahNum;
  @HiveField(2)
  String pageNum;
  @HiveField(3)
  String surahName;
  @HiveField(4)
  int ayahNumInQuran;

  NoteModel({
    required this.ayahNumInQuran,
    required this.note,
    required this.ayahNum,
    required this.pageNum,
    required this.surahName,
  });
}
//flutter packages pub run build_runner build
