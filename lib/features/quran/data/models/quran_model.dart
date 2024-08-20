class MoshafIndexModel {
  final List<SurahIndex> sowarIndex;
  final List<ChapterIndex> chapterIndex;

  final List<HizbIndex> hizbIndex;

  // Constructor
  MoshafIndexModel({
    required this.sowarIndex,
    required this.chapterIndex,
    required this.hizbIndex,
  });

  // Factory constructor for creating a new Surah instance from a map.
  factory MoshafIndexModel.fromJson(Map<String, dynamic> json) {
    List<SurahIndex> sowarIndex = (json["sower"] as List)
        .map((surah) => SurahIndex.fromJson(surah))
        .toList();

    List<ChapterIndex> chapterIndex = (json["chapters"] as List)
        .map((chapter) => ChapterIndex.fromJson(chapter))
        .toList();
    List<HizbIndex> hizbIndex =
        (json["hizb"] as List).map((hizb) => HizbIndex.fromJson(hizb)).toList();
    return MoshafIndexModel(
        sowarIndex: sowarIndex,
        chapterIndex: chapterIndex,
        hizbIndex: hizbIndex);
  }

  // Method to convert Surah instance to a map.
  Map<String, dynamic> toJson() {
    return {
      "sower": sowarIndex.map((surah) => surah.toJson()).toList(),
      "chapters": chapterIndex.map((chapter) => chapter.toJson()).toList(),
      "hizb": hizbIndex.map((hizb) => hizb.toJson()).toList()
    };
  }
}

class SurahIndex {
  final int id;
  final String name;
  final int startPage;
  final int endPage;
  final int makkia;
  final int type;

  // Constructor
  SurahIndex({
    required this.id,
    required this.name,
    required this.startPage,
    required this.endPage,
    required this.makkia,
    required this.type,
  });

  // Factory constructor for creating a new Surah instance from a map.
  factory SurahIndex.fromJson(Map<String, dynamic> json) {
    return SurahIndex(
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

class ChapterIndex {
  final int id;
  final String name;
  final String surahName;
  final int startPage;

  ChapterIndex({
    required this.id,
    required this.name,
    required this.surahName,
    required this.startPage,
  });

  // Factory constructor to create a ChapterIndex from a JSON map
  factory ChapterIndex.fromJson(Map<String, dynamic> json) {
    return ChapterIndex(
      id: json['id'],
      name: json['name'],
      surahName: json['surah_name'],
      startPage: json['start_page'],
    );
  }

  // Method to convert a ChapterIndex instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'surah_name': surahName,
      'start_page': startPage,
    };
  }
}

class HizbIndex {
 final int id;
 final String name;
  final int startPage;

  HizbIndex({
    required this.startPage,
    required this.id,
    required this.name,
  });

  // Factory constructor to create a Chapter instance from a JSON map
  factory HizbIndex.fromJson(Map<String, dynamic> json) {
    return HizbIndex(
      id: json['id'],
      name: json['name'],
           startPage: json['start_page'],
    );
  }

  // Method to convert a Chapter instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'start_page':startPage
    };
  }
}
