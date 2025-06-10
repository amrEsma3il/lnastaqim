import 'package:hive/hive.dart';
import 'package:lnastaqim/features/ibtihal/data/models/ibtihal_info.dart';
part 'reciter_ibtihal_model.g.dart';

@HiveType(typeId: 6)
class ReciterIbtihalModel {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String nameArabic;
  @HiveField(3)
  final String nationality;
  @HiveField(4)
  final List<IbtihalInfo> info;

  ReciterIbtihalModel({
    required this.id,
    required this.name,
    required this.nameArabic,
    required this.nationality,
    required this.info,
  });

  factory ReciterIbtihalModel.fromJson(Map<String, dynamic> json) {
    return ReciterIbtihalModel(
      id: json['id'] as int,
      name: json['name'] as String,
      nameArabic: json['name_arabic'] as String,
      nationality: json['nationality'] as String,
      info: (json['info'] as List<dynamic>)
          .map((item) => IbtihalInfo.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}
