import 'package:flutter/material.dart';

int calculateMaxWordsPerScreen(BuildContext context, double fontSize, double lineHeight) {
  double screenHeight = MediaQuery.of(context).size.height;
  
  int maxLines = (screenHeight / lineHeight).floor();
  
  double screenWidth = MediaQuery.of(context).size.width;
  int averageWordsPerLine = (screenWidth / (fontSize * 0.6)).floor(); // Adjust 0.6 based on average word width
  
  return maxLines * averageWordsPerLine;
}

List<String> splitStringByWords(String input, int maxWords) {
  List<String> words = input.split(RegExp(r'\s+'));
  List<String> result = [];
  StringBuffer temp = StringBuffer();

  for (int i = 0; i < words.length; i++) {
    temp.write(words[i]);
    if ((i + 1) % maxWords == 0) {
      result.add(temp.toString());
      temp.clear();
    } else {
      temp.write(' ');
    }
  }

  if (temp.isNotEmpty) {
    result.add(temp.toString().trim());
  }

  return result;
}

