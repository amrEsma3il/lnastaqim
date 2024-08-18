class MoshafSurahIndexModel {
  final int id;
  final String name;
  final int startPage;
  final int endPage;
  final int makkia;
  final int type;

  // Constructor
  MoshafSurahIndexModel({
    required this.id,
    required this.name,
    required this.startPage,
    required this.endPage,
    required this.makkia,
    required this.type,
  });

  // Factory constructor for creating a new Surah instance from a map.
  factory MoshafSurahIndexModel.fromJson(Map<String, dynamic> json) {
    return MoshafSurahIndexModel(
      id: json['id'],
      name: json['name'],
      startPage: json['start_page'],
      endPage: json['end_page'],
      makkia: json['makkia'],
      type: json['type'],
    );
  }

  // Method to convert Surah instance to a map.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'start_page': startPage,
      'end_page': endPage,
      'makkia': makkia,
      'type': type,
    };
  }
}
