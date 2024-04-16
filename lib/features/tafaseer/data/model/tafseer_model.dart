class TafseerModel {
  List<Tabari>? tabari;

  TafseerModel({this.tabari});

  TafseerModel.fromJson(Map<String, dynamic> json) {
    if (json['tabari'] != null) {
      tabari = <Tabari>[];
      json['tabari'].forEach((v) {
        tabari!.add( Tabari.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    if (this.tabari != null) {
      data['tabari'] = this.tabari!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Tabari {
  int? index;
  int? sura;
  int? aya;
  String? text;
  int? pageNum;

  Tabari({this.index, this.sura, this.aya, this.text, this.pageNum});

  Tabari.fromJson(Map<String, dynamic> json) {
    index = json['index'];
    sura = json['sura'];
    aya = json['aya'];
    text = json['text'];
    pageNum = json['PageNum'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['index'] = this.index;
    data['sura'] = this.sura;
    data['aya'] = this.aya;
    data['text'] = this.text;
    data['PageNum'] = this.pageNum;
    return data;
  }
}