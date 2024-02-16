class QuranModel {
  final int id;
  final String name;
  final String nameEn;
  final String nameTranslation;
  final int words;
  final int letters;
  final String type;
  final String typeEn;
  final String ar;
  final String en;
  final List<Array> array;

  QuranModel(
      {required this.id,
      required this.name,
      required this.nameEn,
      required this.nameTranslation,
      required this.words,
      required this.letters,
      required this.type,
      required this.typeEn,
      required this.ar,
      required this.en,
      required this.array});

  factory QuranModel.fromJson(Map<String, dynamic> json) => QuranModel(
      id: json['id'],
      name: json['name'],
      nameEn: json['name_en'],
      nameTranslation: json['name_translation'],
      words: json['words'],
      letters: json['letters'],
      type: json['type'],
      typeEn: json['type_en'],
      ar: json['ar'],
      en: json['en'],
      array: json['array']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'name_en': nameEn,
        'name_translation': nameTranslation,
        'words': words,
        'letters': letters,
        'type': type,
        'type_en': typeEn,
        'ar': ar,
        'en': en,
        'array': array.map((aya) => aya.toJson()).toList(),
      };
}

class Array {
  final int id;
  final String ar;
  final String en;
  final String filename;
  final String path;
  final String dir;
  final int size;

  Array(
      {required this.id,
      required this.ar,
      required this.en,
      required this.filename,
      required this.path,
      required this.dir,
      required this.size});

  factory Array.fromJson(Map<String, dynamic> json) => Array(
      id: json['id'],
      ar: json['ar'],
      en: json['en'],
      filename: json['filename'],
      path: json['path'],
      dir: json['dir'],
      size: json['size']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'ar': ar,
        'en': en,
        'filename': filename,
        'path': path,
        'dir': dir,
        'size': size,
      };
}