import '../../../../core/local_database/quran_surah_player/surah_player_database.dart';
import '../models/reciters__model.dart';

class RecitersRepository {
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
}
