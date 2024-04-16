

import 'package:lnastaqim/core/local_database/tafseer.dart';

import '../model/tafseer_model.dart';

class TafseerConstDataSources {
  static List<TafseerModel> getTafseerData() => TafaseerDataBase.tafaseerJasonData.map((tafseerJson) => TafseerModel.fromJson(tafseerJson))
      .toList();
}