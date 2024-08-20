import '../data_sources/const_data_sources/quran_const_data_sources.dart';
import '../models/quran_model.dart';

class QuranRepository {
  static  List<SurahIndex> getSowarIndex() =>
      QuranConstDataSources.getAllQuranIndex().sowarIndex;

  static List<ChapterIndex> getChaptersIndex() =>
      QuranConstDataSources.getAllQuranIndex().chapterIndex;

  static List<HizbIndex> getHizpIndex() =>
      QuranConstDataSources.getAllQuranIndex().hizbIndex;
}
