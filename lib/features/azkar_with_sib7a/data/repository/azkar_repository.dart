import 'package:lnastaqim/features/azkar_with_sib7a/data/models/AzkarModel.dart';

import '../data_sources/const_data_sources/azkar_const_data_sources.dart';

class AzkarRepository {
  static List<AzkarModel> getAzkarCategory() =>
      AzkarConstDataSources.getAzkarCategory();
}
