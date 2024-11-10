class A7adithModel {
  Metadata? metadata;
  List<Chapters>? chapters;
  List<Hadiths>? hadiths;

  A7adithModel({this.metadata, this.chapters, this.hadiths});

  A7adithModel.fromJson(Map<String, dynamic> json) {
    metadata =
        json['metadata'] != null ? Metadata.fromJson(json['metadata']) : null;
    if (json['chapters'] != null) {
      chapters = <Chapters>[];
      json['chapters'].forEach((v) {
        chapters!.add(Chapters.fromJson(v));
      });
    }
    if (json['hadiths'] != null) {
      hadiths = <Hadiths>[];
      json['hadiths'].forEach((v) {
        hadiths!.add(Hadiths.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    if (metadata != null) {
      data['metadata'] = metadata!.toJson();
    }
    if (chapters != null) {
      data['chapters'] = chapters!.map((v) => v.toJson()).toList();
    }
    if (hadiths != null) {
      data['hadiths'] = hadiths!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Metadata {
  int? id;
  Arabic? arabic;
  Arabic? english;

  Metadata({this.id, this.arabic, this.english});

  Metadata.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    arabic = json['arabic'] != null ? Arabic.fromJson(json['arabic']) : null;
    english = json['english'] != null ? Arabic.fromJson(json['english']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['id'] = id;

    if (arabic != null) {
      data['arabic'] = arabic!.toJson();
    }
    if (english != null) {
      data['english'] = english!.toJson();
    }
    return data;
  }
}

class Arabic {
  String? title;
  String? author;

  Arabic({
    this.title,
    this.author,
  });

  Arabic.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    author = json['author'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['author'] = author;

    return data;
  }
}

class Chapters {
  int? id;
  int? bookId;
  String? arabic;
  String? english;

  Chapters({this.id, this.bookId, this.arabic, this.english});

  Chapters.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bookId = json['bookId'];
    arabic = json['arabic'];
    english = json['english'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['bookId'] = bookId;
    data['arabic'] = arabic;
    data['english'] = english;
    return data;
  }
}

class Hadiths {
  int? id;
  int? idInBook;
  int? chapterId;
  int? bookId;
  String? arabic;
  Arabic? english;

  Hadiths(
      {this.id,
      this.idInBook,
      this.chapterId,
      this.bookId,
      this.arabic,
      this.english});

  Hadiths.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idInBook = json['idInBook'];
    chapterId = json['chapterId'];
    bookId = json['bookId'];
    arabic = json['arabic'];
    english = json['english'] != null ? Arabic.fromJson(json['english']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['idInBook'] = idInBook;
    data['chapterId'] = chapterId;
    data['bookId'] = bookId;
    data['arabic'] = arabic;
    if (english != null) {
      data['english'] = english!.toJson();
    }
    return data;
  }
}

class English {
  String? narrator;
  String? text;

  English({this.narrator, this.text});

  English.fromJson(Map<String, dynamic> json) {
    narrator = json['narrator'];
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['narrator'] = narrator;
    data['text'] = text;
    return data;
  }
}
