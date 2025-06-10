import 'package:hive/hive.dart';


import '../reciter_ibtihal_model/reciter_ibtihal_model.dart';
part 'ibtihal_fav_model.g.dart';
@HiveType(typeId: 5)
class IbtihalFavoriteModel extends HiveObject {
  @HiveField(0)
  final int ibtihalNumber;
  @HiveField(1)
  final String ibtihalName;
  @HiveField(2)
  final ReciterIbtihalModel reciter;
  @HiveField(3)
  final DateTime timestamp;

  IbtihalFavoriteModel({
    required this.ibtihalNumber,
    required this.ibtihalName,
    required this.reciter,
    required this.timestamp,
  });
}