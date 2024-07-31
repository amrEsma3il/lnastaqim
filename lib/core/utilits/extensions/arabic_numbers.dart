extension ArabicNumbersConverter on String {



  String get toArabic=>_replacedText();
  
  String _replacedText() {
    return replaceAll('0', "٠")
        .replaceAll('1', "١")
        .replaceAll('2', "٢")
        .replaceAll('3', "٣")
        .replaceAll('4', "٤")
        .replaceAll('5', "٥")
        .replaceAll('6', "٦")
        .replaceAll('7', "٧")
        .replaceAll('8', "٨")
        .replaceAll('9', "٩").replaceAll("(", "").replaceAll(")", "").replaceAll("  ", " ").replaceAll("   ", " ").replaceAll("ا۟", "اْ").replaceAll("و۟", "وْ");
  }

    String get toEnglish => _replacedTextToEnglish();

  String _replacedTextToEnglish() {
    return replaceAll('٠', "0")
        .replaceAll('١', "1")
        .replaceAll('٢', "2")
        .replaceAll('٣', "3")
        .replaceAll('٤', "4")
        .replaceAll('٥', "5")
        .replaceAll('٦', "6")
        .replaceAll('٧', "7")
        .replaceAll('٨', "8")
        .replaceAll('٩', "9")
        .replaceAll("(", "")
        .replaceAll(")", "")
        .replaceAll("  ", " ")
        .replaceAll("   ", " ")
        .replaceAll("ا۟", "اْ")
        .replaceAll("و۟", "وْ");
  }
}