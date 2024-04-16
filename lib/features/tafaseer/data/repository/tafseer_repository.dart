
import 'package:lnastaqim/features/tafaseer/data/data_sources/const_data_source.dart';

import '../model/tafseer_model.dart';

class TafseerRepository {
  static List<TafseerModel> getTafseereDataRepo() =>
      TafseerConstDataSources.getTafseerData();

}