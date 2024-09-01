class ReciterEntity {
  final String reciter;
  final String downloadUrl;
  final String arabicName;

  ReciterEntity({
    required this.arabicName,
    required this.downloadUrl,
    required this.reciter,
  });

  ReciterEntity copyWith({
    String? reciter,
    String? downloadUrl,
  
    String? arabicName,

  }) {
    return ReciterEntity(
      reciter: reciter ?? this.reciter,
      downloadUrl: downloadUrl ?? this.downloadUrl,
      arabicName: arabicName ?? this.arabicName,
  
    );
  }
}

// enum DownloadStatus{
//   complete,
//   inProgress,
//   init
// }

 List<ReciterEntity> recitersInfo = [
  ReciterEntity(arabicName: "المنشاوي",
    
   downloadUrl: "https://cdn.islamic.network/quran/audio/64/ar.minshawimujawwad/",reciter: "minshawimujawwad"
   

  ),
   ReciterEntity(arabicName: "الحصري",
    
   downloadUrl: "https://cdn.islamic.network/quran/audio/128/ar.husarymujawwad/",reciter: "husarymujawwad"
   

  ),
   ReciterEntity(
    arabicName: "عبد الباسط",
    
   downloadUrl: "https://cdn.islamic.network/quran/audio/192/ar.abdulbasitmurattal/",reciter: "abdulbasitmurattal"
   

  ),

   ReciterEntity(arabicName: "السديس",
  downloadUrl: "https://cdn.islamic.network/quran/audio/192/ar.abdurrahmaansudais/",reciter: "abdurrahmaansudais"
   

  ),

   ReciterEntity(arabicName: "المعقيلي",
  downloadUrl: "https://cdn.islamic.network/quran/audio/128/ar.mahermuaiqly/",reciter: "mahermuaiqly"
   

  ),

   ReciterEntity(arabicName: "العفاسي",
   downloadUrl: "https://cdn.islamic.network/quran/audio/128/ar.alafasy/",reciter: "alafasy"
   

  ),
   ReciterEntity(arabicName: "الشاطر",
   downloadUrl: "https://cdn.islamic.network/quran/audio/128/ar.shaatree/",reciter: "shaatree"
   

  ),
  

   ReciterEntity(arabicName: "الحذيفي",
   downloadUrl: "https://cdn.islamic.network/quran/audio/128/ar.hudhaify/",reciter: "hudhaify"
   

  ),
   ReciterEntity(arabicName: "احمد العجمي",
   downloadUrl: "https://cdn.islamic.network/quran/audio/128/ar.ahmedajamy/",reciter: "ahmedajamy"
   

  ),
   ReciterEntity(arabicName: "محمد ايوب",
   downloadUrl: "https://cdn.islamic.network/quran/audio/128/ar.muhammadayyoub/",reciter: "muhammadayyoub"
   

  ),



   ReciterEntity(arabicName: "محمد جبريل",
   downloadUrl: "https://cdn.islamic.network/quran/audio/128/ar.muhammadjibreel/",reciter: "muhammadjibreel"
   

  ),

   ReciterEntity(arabicName: "هاني الرفاعي",
   downloadUrl: "https://cdn.islamic.network/quran/audio/192/ar.hanirifai/",reciter: "hanirifai"
   

  ),


   ReciterEntity(arabicName: "ايمن سويد",
   downloadUrl: "https://cdn.islamic.network/quran/audio/64/ar.aymanswoaid/",reciter: "aymanswoaid"
   

  ),
   ReciterEntity(arabicName: "عبدالله بصفر",
   downloadUrl: "https://cdn.islamic.network/quran/audio/32/ar.abdullahbasfar/",reciter: "abdullahbasfar"
   

  ),   ReciterEntity(arabicName: "ابراهيم الاخضر",
   downloadUrl: "https://cdn.islamic.network/quran/audio/32/ar.ibrahimakhbar/",reciter: "ibrahimakhbar"
   

  )
];
