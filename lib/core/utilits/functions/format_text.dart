class FormatText {
  static String ayaW3braShareText({
    required String ayah,
    required String tafsir,
  }) {
    final formattedText = '''
🌿 آية اليوم 🌿

"$ayah"

💡 العبرة:
$tafsir

#لنستقيم
''';
    return formattedText;
  }

  static String surahShareText({
    required String surahName,
    required String reciterName,
    required String url,
  }) {
    final formattedText = '''
📖 $surahName
🗣️ القارئ: $reciterName

🎧 رابط الاستماع والتحميل:
$url

#لنستقيم
''';
    return formattedText;
  }


   static String appShareText(String storeUrl) {
    return '''
🌟 *تطبيق لنستقيم* 🌟

📱 *تطبيق إسلامي يساعدك على الاستقامة في حياتك اليومية*.

🔹 تنبيهات بالأذكار، الأذان، الصلاة على النبي ﷺ، تكبيرات، والمزيد...
🔹 محتوى ديني مميز يساعدك في السير على الطريق الصحيح.

⬇️ *حمّله الآن من المتجر:*
$storeUrl

#لنستقيم #تطبيق_إسلامي
''';
  }
}
