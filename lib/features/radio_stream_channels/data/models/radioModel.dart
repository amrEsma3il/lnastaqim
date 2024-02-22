class RadioModel {
  RadioModel({
    this.quran,
    this.reciters,
    this.other,
  });

  RadioModel.fromJson(dynamic json) {
    if (json['quran'] != null) {
      quran = [];
      json['quran'].forEach((v) {
        quran?.add(Channel.fromJson(v));
      });
    }
    if (json['reciters'] != null) {
      reciters = [];
      json['reciters'].forEach((v) {
        reciters?.add(Channel.fromJson(v));
      });
    }
    if (json['other'] != null) {
      other = [];
      json['other'].forEach((v) {
        other?.add(Channel.fromJson(v));
      });
    }
  }
  List<Channel>? quran;
  List<Channel>? reciters;
  List<Channel>? other;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (quran != null) {
      map['quran'] = quran?.map((v) => v.toJson()).toList();
    }
    if (reciters != null) {
      map['reciters'] = reciters?.map((v) => v.toJson()).toList();
    }
    if (other != null) {
      map['other'] = other?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Channel {
  Channel({
    this.name,
    this.description,
    this.image,
    this.url,
  });

  Channel.fromJson(dynamic json) {
    name = json['name'];
    description = json['description'];
    image = json['image'];
    url = json['url'];
  }
  String? name;
  String? description;
  String? image;
  String? url;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['description'] = description;
    map['image'] = image;
    map['url'] = url;
    return map;
  }
}
