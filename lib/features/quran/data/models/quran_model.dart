class SoraModel {
  final int ?id;
  final String? name;
  final String? nameEn;
  final String? nameTranslation;
  final int? words;
  final int ?letters;
  final String? type;
  final String ?typeEn;
  final String ?ar;
  final String ?en;
  final List<AyatOfSora>? array;

  SoraModel(
      { this.id,
       this.name,
       this.nameEn,
       this.nameTranslation,
       this.words,
       this.letters,
       this.type,
       this.typeEn,
       this.ar,
       this.en,
       this.array});

  factory SoraModel.fromJson(Map<String, dynamic> json) => SoraModel(
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
      array: (json['array'] as List<Map<String, dynamic>>)
          .map(
            (e) => AyatOfSora.fromJson(e),
          )
          .toList());

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
        'array': array!.map((aya) => aya.toJson()).toList(),
      };
}

class AyatOfSora {
  final int? id;
  final String? ar;
  final String ?en;
  final String ?filename;
  final String ?path;
  final String ?dir;
  final int ?size;

  AyatOfSora(
      { this.id,
       this.ar,
       this.en,
       this.filename,
       this.path,
       this.dir,
       this.size});

  factory AyatOfSora.fromJson(Map<String, dynamic> json) => AyatOfSora(
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
