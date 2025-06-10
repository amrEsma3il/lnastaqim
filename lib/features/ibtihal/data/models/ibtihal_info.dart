
import 'package:hive/hive.dart';

part 'ibtihal_info.g.dart';

@HiveType(typeId: 7)
class IbtihalInfo {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String url;

  IbtihalInfo({
    required this.name,
    required this.url,
  });

  factory IbtihalInfo.fromJson(Map<String, dynamic> json) {
    return IbtihalInfo(
      name: json['name'] as String,
      url: json['url'] as String,
    );
  }
}