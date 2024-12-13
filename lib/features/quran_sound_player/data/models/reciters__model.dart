class Reciter {
  final String name;
  final String nameArabic;
  final String nationality;

  Reciter({
    required this.name,
    required this.nameArabic,
    required this.nationality,
  });

  factory Reciter.fromJson(Map<String, dynamic> json) {
    return Reciter(
      name: json['name'],
      nameArabic: json['name_arabic'],
      nationality: json['nationality'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'name_arabic': nameArabic,
      'nationality': nationality,
    };
  }
}
