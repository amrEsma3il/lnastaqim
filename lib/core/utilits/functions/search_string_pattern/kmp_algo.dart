List<int> calculateFailureFunction(String pattern) {
  List<int> failure = List<int>.filled(pattern.length, 0);
  int i = 0;
  int j = 1;

  while (j < pattern.length) {
    if (pattern[i] == pattern[j]) {
      failure[j] = i + 1;
      i++;
      j++;
    } else {
      if (i != 0) {
        i = failure[i - 1];
      } else {
        failure[j] = 0;
        j++;
      }
    }
  }

  return failure;
}

List<int> searchPattern(String text, String pattern) {
  List<int> matches = [];
  List<int> failure = calculateFailureFunction(pattern);

  int i = 0; 
  int j = 0; 

  while (i < text.length) {
    if (pattern[j] == text[i]) {
      i++;
      j++;

      if (j == pattern.length) {
        matches.add(i - j);
        j = failure[j - 1];
      }
    } else {
      if (j != 0) {
        j = failure[j - 1];
      } else {
        i++;
      }
    }
  }

  return matches;
}