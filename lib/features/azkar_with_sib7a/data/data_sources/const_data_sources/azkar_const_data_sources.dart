import 'package:lnastaqim/core/local_database/azkar/azkar_local_database.dart';
import 'package:lnastaqim/features/azkar_with_sib7a/data/models/AzkarModel.dart';

class AzkarConstDataSources {
  static List<AzkarModel> getAzkarCategory() => AzkarDataBase.azkarJsonData
      .map((azkarJson) => AzkarModel.fromJson(azkarJson))
      .toList();
}
