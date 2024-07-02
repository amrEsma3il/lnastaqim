import '../../../../../core/local_database/quran/quran_local_database.dart';
import '../../models/quran_model.dart';

class QuranConstDataSources {
  static List<SoraModel> getAllQuranSowar() => QuranDataBase.quranJsonData
      .map((quaranJson) => SoraModel.fromJson(quaranJson))
      .toList();

  static SoraModel getSoraDetails(Map<String,dynamic>quaranJson) =>
      SoraModel.fromJson(quaranJson);
}
