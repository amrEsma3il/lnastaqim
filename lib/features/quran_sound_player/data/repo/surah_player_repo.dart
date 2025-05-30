import '../../../../core/constants/keys.dart';
import '../../../../core/local_database/quran_surah_player/surah_player_database.dart';
import '../models/reciter_model/reciters_model.dart';
import '../models/surah_favorite_model/surah_favorite_model.dart';
import 'package:hive/hive.dart';

class SurahPlayerRepo {
  final List<Reciter> reciters = QuranSurahPlayer.reciters["reciters"]!
      .map(
        (reciterObject) => Reciter.fromJson(reciterObject),
      )
      .toList();
  List<Reciter> getAllReciters() {
    return reciters;
  }

//TODO:check if nationality first in database before searsh
  List<Reciter> filterReciters(String nationality,String query) {
    return reciters
        .where((reciter) =>( nationality=="كل الدول"?true: (reciter.nationality == nationality) )&&( reciter.nameArabic.contains(query)) )
        .toList();
  }

  // List<Reciter> filterRecitersBySearch(String query) {
  //   final List<Reciter> filteredReciters = reciters
  //       .where((reciter) => reciter.nameArabic.contains(query))
  //       .toList();
  //   return filteredReciters;
  // }









  //! surah favorite


   Box<SurahFavoriteModel> get _box => Hive.box<SurahFavoriteModel>(AppKeys.favoriteSurahBoxName);
   List<SurahFavoriteModel> get favorites {
    return _box.values.toList();
  }

  Future<void> addFavorite({
    required int surahNumber,
    required String surahName,
    required Reciter reciter,
  }) async {
    final box =  _box;
    final favorite = SurahFavoriteModel(
      surahNumber: surahNumber,
      surahName: surahName,
     reciter: reciter,
      timestamp: DateTime.now(),
    );
    await box.add(favorite);
  }

  Future<void> removeFavorite({required int surahNumber,required int reciterId,
  }) async {
    final box =  _box;
    final favorites = box.values.toList();
    for (var i = 0; i < favorites.length; i++) {
      if (favorites[i].surahNumber == surahNumber && favorites[i].reciter.id == reciterId) {
        await box.deleteAt(i);
        break;
      }
    }
  }

  bool isFavorite({required int surahNumber,required int reciterId,
  } ) {
    return _box.values.any((fav) => fav.surahNumber == surahNumber && fav.reciter.id == reciterId,
    );
  }


}
