

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






static final List<IbtihalInfo> ibtahalInfoInitList= [
        IbtihalInfo(
          name: "في الليل يارب وفي الأسحار",
          url: "https://archive.org/download/20230916_20230916_0318/001%20%20-%20%D9%81%D9%89%20%D8%A7%D9%84%D9%84%D9%8A%D9%84%20%D9%8A%D8%A7%D8%B1%D8%A8%20%D9%88%D9%81%D9%89%20%D8%A7%D9%84%D8%A3%D8%B3%D8%AD%D8%A7%D8%B1%20%20%D8%A7%D9%84%D8%B4%D9%8A%D8%AE%20%D9%85%D8%AD%D9%85%D8%AF%20%D8%B9%D9%85%D8%B1%D8%A7%D9%86%20%20%D8%AC%D9%88%D8%AF%D8%A9%20%D8%B9%D8%A7%D9%84%D9%8A%D8%A9%20HD.mp3",
        ),
        IbtihalInfo(
          name: "من أروع ما يكون",
          url: "https://archive.org/download/20230916_20230916_0318/002%20%20%D8%A7%D8%A8%D8%AA%D9%87%D8%A7%D9%84%D8%A7%D8%AA%20%D8%A7%D9%84%D8%B4%D9%8A%D8%AE%20%D9%85%D8%AD%D9%85%D8%AF%20%D8%B9%D9%85%D8%B1%D8%A7%D9%86%20%D9%85%D9%86%20%D8%A3%D8%B1%D9%88%D8%B9%20%D9%85%D8%A7%20%D9%8A%D9%83%D9%88%D9%86.mp3",
        ),
        IbtihalInfo(
          name: "ابتهالات نادرة جدًا",
          url: "https://dn721908.ca.archive.org/0/items/20230916_20230916_0318/003%20%20%D8%A7%D9%84%D8%B4%D9%8A%D8%AE%20%D9%85%D8%AD%D9%85%D8%AF%20%D8%B9%D9%85%D8%B1%D8%A7%D9%86%20%20%D8%A7%D8%A8%D8%AA%D9%87%D8%A7%D9%84%D8%A7%D8%AA%20%D9%86%D8%A7%D8%AF%D8%B1%D8%A9%20%D8%AC%D8%AF%D9%8B%D8%A7%20%20%D9%85%D9%86%20%D8%A3%D8%AD%D8%AF%20%D9%85%D8%B3%D8%A7%D8C%D8%AF%20%D8%A8%D9%88%D8%B1%D8%B3%D8%B9%D9%8A%D8%AF%201987%20_.%20%D8%AD%D8%B5%D8%B1%D9%8A%D9%8B%D8%A7.mp3",
        ),
        IbtihalInfo(
          name: "ساعة من أجمل ابتهالات إذاعة القرآن الكريم",
          url: "https://www.archive.org/download/20230916_20230916_0318/004%20%20%D8%B3%D8%A7%D8%B9%D8%A9%20%D9%85%D9%86%20%D8%A7%D8%AC%D9%85%D9%84%20%D9%88%20%D8%A7%D8%B1%D9%88%D8%B9%20%D8%A7%D8%A8%D8%AA%D9%87%D8%A7%D9%84%D8%A7%D8%AA%20%D8%A7%D8%B0%D8%A7%D8%B9%D8%A9%20%D8%A7%D9%84%D9%82%D8%B1%D8%A2%D9%86%20%D8%A7%D9%84%D9%83%D8%B1%D9%8A%D9%85%20-%20%D8%A7%D9%84%D8%B4%D9%8A%D8%AE%20%D9%85%D8%AD%D9%85%D8%AF%20%D8%B9%D9%85%D8%B1%D8%A7%D9%86%20-%20%D8%AC%D9%88%D8%AF%D8%A9%20%D8%B9%D8%A7%D9%84%D9%8A%D8%A9.mp3",
        ),
        IbtihalInfo(
          name: "سبحان من عنت الوجوه لوجهه",
          url: "https://archive.org/download/20230916_20230916_0318/005%20%20%D8%B3%D8%A8%D8%AD%D8%A7%D9%86%20%D9%85%D9%86%20%D8%B9%D9%86%D8%AA%20%D8%A7%D9%84%D9%88%D8C%D9%88%D8%A9%20%D9%84%D9%88%D8C%D9%87%D9%87%20-%20%D8%A7%D9%84%D8%B4%D9%8A%D8%AE%20%D9%85%D8%AD%D9%85%D8%AF%20%D8%B9%D9%85%D8%B1%D8%A7%D9%86%20-%20%D9%81%D9%8A%D8%AF%D9%8A%D9%88%20%D9%86%D8%A7%D8%AF%D8%B1%20%D8%B9%D8%A7%D9%85%201993.mp3",
        ),
        IbtihalInfo(
          name: "فكم لله من لطف خفي",
          url: "https://archive.org/download/20230916_20230916_0318/006%20%20%D9%81%D9%83%D9%85%20%D9%84%D9%84%D9%87%20%D9%85%D9%86%20%D9%84%D8%B7%D9%81%20%D8%AE%D9%81%D9%8A%D9%91%D9%8D%20%D8%A5%D8%A8%D8%AA%D9%87%D8%A7%D9%84%20%D9%84%D9%84%D8%B4%D9%8A%D8%AE%20%D9%85%D8%AD%D9%85%D8%AF%20%D8%B9%D9%85%D8%B1%D8%A7%D9%86.mp3",
        ),
        IbtihalInfo(
          name: "يا سلام على النوادر",
          url: "https://archive.org/download/20230916_20230916_0318/008%20%20%D9%8A%D8%A7%20%D8%B3%D9%84%D8%A7%D9%85%20%D8%B9%D9%84%D9%89%20%D8%A7%D9%84%D9%86%D9%88%D8%A7%D8%AF%D8%B1%20%20%D9%81%D9%8A%D8%AF%D9%8A%D9%88%20%D9%84%D9%84%D8%B4%D9%8A%D8%AE%20%D9%85%D8%AD%D9%85%D8%AF%20%D8%B9%D9%85%D8%B1%D8%A7%D9%86%20%D8%A7%D8%A8%D8%AA%D9%87%D8%A7%D9%84%20%D9%86%D8%A7%D8%AF%D8%B1%20%D9%8A%D8%A7%D8%B3%D9%8A%D8%AF%20%D8%A7%D9%84%D9%83%D9%88%D9%86%D9%8A%D9%86%20%D8%B9%D8%A7%D9%85%201993%20%D8%B1%D9%88%D8%A7%D8%A6%D8%B9%20%D9%88%D9%86%D9%88%D8%A7%D8%AF%D8%B1.mp3",
        ),
      ];
}