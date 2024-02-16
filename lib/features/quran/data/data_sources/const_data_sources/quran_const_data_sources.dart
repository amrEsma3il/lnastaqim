import '../../../../../core/local_database/quran/quran_local_database.dart';
import '../../models/quran_model.dart';

class QuranConstDataSources {
  static List<QuranModel> getAllQuranSowar() => QuranDataBase.quranJsonData
      .map((quaranJson) => QuranModel.fromJson(quaranJson))
      .toList();

  static QuranModel getSoraDetails(Map<String,dynamic>quaranJson) =>
      QuranModel.fromJson(quaranJson);
}
