import '../data_sources/const_data_sources/quran_const_data_sources.dart';
import '../models/quran_model.dart';


class QuranRepository {
  static List<QuranModel> getAllQuranSowar() =>QuranConstDataSources.getAllQuranSowar();
      

  static QuranModel getSoraDetails( Map<String,dynamic>quaranJson) =>QuranConstDataSources.getSoraDetails(quaranJson);
   
}
