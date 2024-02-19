class AzkarModel {

  String? category;
  String? count;
  String? description;
  String? reference;
  String? zekr;

  AzkarModel({
    this.category,
    this.count,
    this.description,
    this.reference,
    this.zekr,
  });

  factory AzkarModel.fromJson(Map<String, dynamic> json){
    return AzkarModel(
      category: json['category'],
      count: json['count'],
      description: json['description'],
      reference: json['reference'],
      zekr: json['zekr'],
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['category'] = category;
    map['count'] = count;
    map['description'] = description;
    map['reference'] = reference;
    map['zekr'] = zekr;
    return map;
  }
}
