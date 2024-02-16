class QuranModel {
  int id;
  String name;
  String nameEn;
  String nameTranslation;
  int words;
  int letters;
  String type;
  String typeEn;
  String ar;
  String en;
  List<Array> array;

  QuranModel(
      {this.id,
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

  QuranModel.fromJson(Map<String, dynamic> json) 
  
  {
    id = json['id'];
    name = json['name'];
    nameEn = json['name_en'];
    nameTranslation = json['name_translation'];
    words = json['words'];
    letters = json['letters'];
    type = json['type'];
    typeEn = json['type_en'];
    ar = json['ar'];
    en = json['en'];
    if (json['array'] != null) {
      array = new List<Array>();
      json['array'].forEach((v) {
        array.add(new Array.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['name_en'] = this.nameEn;
    data['name_translation'] = this.nameTranslation;
    data['words'] = this.words;
    data['letters'] = this.letters;
    data['type'] = this.type;
    data['type_en'] = this.typeEn;
    data['ar'] = this.ar;
    data['en'] = this.en;
    if (this.array != null) {
      data['array'] = this.array.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Array {
  int id;
  String ar;
  String en;
  String filename;
  String path;
  String dir;
  int size;

  Array(
      {this.id,
      this.ar,
      this.en,
      this.filename,
      this.path,
      this.dir,
      this.size});

  Array.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ar = json['ar'];
    en = json['en'];
    filename = json['filename'];
    path = json['path'];
    dir = json['dir'];
    size = json['size'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ar'] = this.ar;
    data['en'] = this.en;
    data['filename'] = this.filename;
    data['path'] = this.path;
    data['dir'] = this.dir;
    data['size'] = this.size;
    return data;
  }
}
