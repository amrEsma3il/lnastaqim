// class MoshafIndexModel {
//   final List<SurahIndex> sowarIndex;
//   final List<ChapterIndex> chapterIndex;

//   final List<HizbIndex> hizbIndex;

//   // Constructor
//   MoshafIndexModel({
//     required this.sowarIndex,
//     required this.chapterIndex,
//     required this.hizbIndex,
//   });

//   // Factory constructor for creating a new Surah instance from a map.
//   factory MoshafIndexModel.fromJson(Map<String, dynamic> json) {
//     List<SurahIndex> sowarIndex = (json["sower"] as List)
//         .map((surah) => SurahIndex.fromJson(surah))
//         .toList();

//     List<ChapterIndex> chapterIndex = (json["chapters"] as List)
//         .map((chapter) => ChapterIndex.fromJson(chapter))
//         .toList();
//     List<HizbIndex> hizbIndex =
//         (json["hizb"] as List).map((hizb) => HizbIndex.fromJson(hizb)).toList();
//     return MoshafIndexModel(
//         sowarIndex: sowarIndex,
//         chapterIndex: chapterIndex,
//         hizbIndex: hizbIndex);
//   }

//   // Method to convert Surah instance to a map.
//   Map<String, dynamic> toJson() {
//     return {
//       "sower": sowarIndex.map((surah) => surah.toJson()).toList(),
//       "chapters": chapterIndex.map((chapter) => chapter.toJson()).toList(),
//       "hizb": hizbIndex.map((hizb) => hizb.toJson()).toList()
//     };
//   }
// }

// class SurahIndex {
//   final int id;
//   final String name;
//   final int startPage;
//   final int endPage;
//   final int makkia;
//   final int type;

//   // Constructor
//   SurahIndex({
//     required this.id,
//     required this.name,
//     required this.startPage,
//     required this.endPage,
//     required this.makkia,
//     required this.type,
//   });

//   // Factory constructor for creating a new Surah instance from a map.
//   factory SurahIndex.fromJson(Map<String, dynamic> json) {
//     return SurahIndex(
//       id: json['id'],
//       name: json['name'],
//       startPage: json['start_page'],
//       endPage: json['end_page'],
//       makkia: json['makkia'],
//       type: json['type'],
//     );
//   }

//   // Method to convert Surah instance to a map.
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'name': name,
//       'start_page': startPage,
//       'end_page': endPage,
//       'makkia': makkia,
//       'type': type,
//     };
//   }
// }

// class ChapterIndex {
//   final int id;
//   final String name;
//   final String surahName;
//   final int startPage;

//   ChapterIndex({
//     required this.id,
//     required this.name,
//     required this.surahName,
//     required this.startPage,
//   });

//   // Factory constructor to create a ChapterIndex from a JSON map
//   factory ChapterIndex.fromJson(Map<String, dynamic> json) {
//     return ChapterIndex(
//       id: json['id'],
//       name: json['name'],
//       surahName: json['surah_name'],
//       startPage: json['start_page'],
//     );
//   }

//   // Method to convert a ChapterIndex instance to a JSON map
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'name': name,
//       'surah_name': surahName,
//       'start_page': startPage,
//     };
//   }
// }

// class HizbIndex {
//  final int id;
//  final String name;
//   final int startPage;

//   HizbIndex({
//     required this.startPage,
//     required this.id,
//     required this.name,
//   });

//   // Factory constructor to create a Chapter instance from a JSON map
//   factory HizbIndex.fromJson(Map<String, dynamic> json) {
//     return HizbIndex(
//       id: json['id'],
//       name: json['name'],
//            startPage: json['start_page'],
//     );
//   }

//   // Method to convert a Chapter instance to a JSON map
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'name': name,
//       'start_page':startPage
//     };
//   }
// }





class VerseModel {
  final int surahNumber;
  final String surahName;
  final String surahEnglishName;
  final String surahEnglishTranslation;
  final String revelationType;
  final int number;
  final String text;
  final String ayaTextEmlaey;
  final int numberInSurah;
  final int juz;
  final int manzil;
  final int page;
  final int pageInSurah;
  final int ruku;
  final int hizbQuarter;
  final bool sajda;
  final String codeV2;

  VerseModel({
    required this.surahNumber,
    required this.surahName,
    required this.surahEnglishName,
    required this.surahEnglishTranslation,
    required this.revelationType,
    required this.number,
    required this.text,
    required this.ayaTextEmlaey,
    required this.numberInSurah,
    required this.juz,
    required this.manzil,
    required this.page,
    required this.pageInSurah,
    required this.ruku,
    required this.hizbQuarter,
    required this.sajda,
    required this.codeV2,
  });

  factory VerseModel.fromJson(Map<String, dynamic> json) {
    return VerseModel(
      surahNumber: json['surah_number'],
      surahName: json['surah_name'],
      surahEnglishName: json['surah_english_name'],
      surahEnglishTranslation: json['surah_english_translation'],
      revelationType: json['revelation_type'],
      number: json['number'],
      text: json['text'],
      ayaTextEmlaey: json['aya_text_emlaey'],
      numberInSurah: json['number_in_surah'],
      juz: json['juz'],
      manzil: json['manzil'],
      page: json['page'],
      pageInSurah: json['page_in_surah'],
      ruku: json['ruku'],
      hizbQuarter: json['hizbQuarter'],
      sajda: json['sajda'],
      codeV2: json['code_v2'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'surah_number': surahNumber,
      'surah_name': surahName,
      'surah_english_name': surahEnglishName,
      'surah_english_translation': surahEnglishTranslation,
      'revelation_type': revelationType,
      'number': number,
      'text': text,
      'aya_text_emlaey': ayaTextEmlaey,
      'number_in_surah': numberInSurah,
      'juz': juz,
      'manzil': manzil,
      'page': page,
      'page_in_surah': pageInSurah,
      'ruku': ruku,
      'hizbQuarter': hizbQuarter,
      'sajda': sajda,
      'code_v2': codeV2,
    };
  }
}

class JuzModel {
  final int juz;
  final List<VerseModel> verses;

  JuzModel({
    required this.juz,
    required this.verses,
  });

  factory JuzModel.fromJson(Map<String, dynamic> json) {
    return JuzModel(
      juz: json['juz'],
      verses: (json['verses'] as List).map((e) => VerseModel.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'juz': juz,
      'verses': verses.map((e) => e.toJson()).toList(),
    };
  }
}




class SurahModel {
  final int id;
  final String name;
  final int startPage;
  final int endPage;
  final int makkia;
  final int type;

  SurahModel({
    required this.id,
    required this.name,
    required this.startPage,
    required this.endPage,
    required this.makkia,
    required this.type,
  });

  factory SurahModel.fromJson(Map<String, dynamic> json) {
    return SurahModel(
      id: json['id'],
      name: json['name'],
      startPage: json['start_page'],
      endPage: json['end_page'],
      makkia: json['makkia'],
      type: json['type'],
    );
  }

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


