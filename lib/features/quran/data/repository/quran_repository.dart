import '../data_sources/const_data_sources/quran_const_data_sources.dart';
import '../models/quran_model.dart';


class QuranRepository {
  static List<SoraModel> getAllQuranSowar() =>QuranConstDataSources.getAllQuranSowar();
      

  // static SoraModel getSoraDetails( SoraModel quaranJson) =>QuranConstDataSources.getSoraDetails(quaranJson);
   
}
