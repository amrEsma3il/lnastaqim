

import 'package:hive/hive.dart';

import '../../../../core/constants/keys.dart';
import '../../../../core/local_database/ibtihal/ibtihalat_data.dart';
import '../models/ibtihal_fav_model/ibtihal_fav_model.dart';
import '../models/ibtihal_info.dart';
import '../models/reciter_ibtihal_model/reciter_ibtihal_model.dart';

class IbtihalatPlayerRepo {
  final List<ReciterIbtihalModel> reciters = IbtihalatData.reciters["reciters"]!
      .map((reciterObject) => ReciterIbtihalModel.fromJson(reciterObject))
      .toList();

  List<ReciterIbtihalModel> getAllReciters() {
    return reciters;
  }

  List<ReciterIbtihalModel> filterReciters(String nationality, String query) {
    return reciters
        .where((reciter) =>
            (nationality == "كل الدول" ? true : reciter.nationality == nationality) &&
            reciter.nameArabic.contains(query))
        .toList();
  }

  List<IbtihalInfo> getIbtihalatForReciter(int reciterId) {
    final reciter = reciters.firstWhere((r) => r.id == reciterId, orElse: () => reciters.first);
    return reciter.info;
  }

  Box<IbtihalFavoriteModel> get _box =>
      Hive.box<IbtihalFavoriteModel>(AppKeys.favoriteIbtihalBoxName);

  List<IbtihalFavoriteModel> get favorites {
    return _box.values.toList();
  }

  Future<void> addFavorite({
    required int ibtihalNumber,
    required String ibtihalName,
    required ReciterIbtihalModel reciter,
  }) async {
    final box = _box;
    final favorite = IbtihalFavoriteModel(
      ibtihalNumber: ibtihalNumber,
      ibtihalName: ibtihalName,
      reciter: reciter,
      timestamp: DateTime.now(),
    );
    await box.add(favorite);
  }

  Future<void> removeFavorite({
    required int ibtihalNumber,
    required int reciterId,
  }) async {
    final box = _box;
    final favorites = box.values.toList();
    for (var i = 0; i < favorites.length; i++) {
      if (favorites[i].ibtihalNumber == ibtihalNumber &&
          favorites[i].reciter.id == reciterId) {
        await box.deleteAt(i);
        break;
      }
    }
  }

  bool isFavorite({
    required int ibtihalNumber,
    required int reciterId,
  }) {
    return _box.values.any((fav) =>
        fav.ibtihalNumber == ibtihalNumber && fav.reciter.id == reciterId);
  }





static final List<IbtihalInfo> ibtahalInfoInitList = 
  (IbtihalatData.reciters["reciters"]!.first["info"] as List)
    .map((e) => IbtihalInfo.fromJson(e))
    .toList();

}