import 'package:hive/hive.dart';

import '../reciter_model/reciters_model.dart';

part 'surah_favorite_model.g.dart'; // This will be generated

@HiveType(typeId: 3) 
class SurahFavoriteModel extends HiveObject {
  @HiveField(0)
  final int surahNumber;
  
  @HiveField(1)
  final String surahName;
  
  @HiveField(2)
  final Reciter reciter;

  
  @HiveField(3)
  final DateTime timestamp;

  SurahFavoriteModel({
    required this.surahNumber,
    required this.surahName,
    required this.reciter,
  
    required this.timestamp,
  });
}