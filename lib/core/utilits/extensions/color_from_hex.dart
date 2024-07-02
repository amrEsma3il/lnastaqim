import 'package:flutter/material.dart';


extension HexColor on String {
  Color get toColor => _toColor();

  Color _toColor() {
    final hexCode = replaceAll('#', '');
    return Color(int.parse('FF$hexCode', radix: 16));
  }
}



 
