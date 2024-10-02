import '../data_sources/const_data_sources/quran_const_data_sources.dart';
import '../models/quran_model.dart';

class QuranRepository {

  final quranDataSourse=QuranConstDataSources();
      static List<SurahModel> getQuranSurah() =>
    QuranConstDataSources.getQuranSurah();


        static List<JuzModel> getQuranJuz() =>
     QuranConstDataSources.getQuranJuz();
}
