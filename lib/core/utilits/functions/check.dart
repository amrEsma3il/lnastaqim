bool isNumeric(String s) {
  if (s.isEmpty) {
    return false;
  }
  final number = num.tryParse(s);
  return number != null;
}