import 'package:lnastaqim/core/utilits/extensions/arabic_numbers.dart';

extension DoubleIntParserExtension on double {
  String get parseInt {
    // Check if the number has a fractional part
    if (this == toInt()) {
      return toInt().toString().toArabic; // Convert to int and then to String
    }
    return toString().toArabic; // Return the original double as String
  }


  
}