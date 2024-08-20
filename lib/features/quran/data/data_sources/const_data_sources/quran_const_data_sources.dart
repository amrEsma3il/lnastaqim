import '../../../../../core/local_database/quran/quran_local_database.dart';
import '../../../../../core/local_database/quran/quran_transition_json.dart';
import '../../models/quran_model.dart';

class QuranConstDataSources {
  static MoshafIndexModel getAllQuranIndex() =>
      MoshafIndexModel.fromJson( QuranTransition.moshafSurahIndexList) ;

}
