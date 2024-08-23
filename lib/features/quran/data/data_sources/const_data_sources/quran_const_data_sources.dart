
import '../../../../../core/local_database/quran/index/quran_index_json.dart';
import '../../models/quran_model.dart';

class QuranConstDataSources {
        static List<SurahModel> getQuranSurah() =>
     (moshafIndexJson['surah'] as List).map((e) => SurahModel.fromJson(e)).toList();


        static List<JuzModel> getQuranJuz() =>
     (moshafIndexJson['juz'] as List).map((e) => JuzModel.fromJson(e)).toList();


}
