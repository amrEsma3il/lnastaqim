Map<String, int> preprocessPattern(String pattern) {
  int patternLength = pattern.length;
  Map<String, int> badCharacter = {};

  for (int i = 0; i < patternLength - 1; i++) {
    String char = pattern[i];
    badCharacter[char] = patternLength - i - 1;
  }

  return badCharacter;
}

List<int> searchPattern(String text, String pattern) {
  int textLength = text.length;
  int patternLength = pattern.length;
  Map<String, int> badCharacter = preprocessPattern(pattern);
  List<int> matches = [];

  int i = patternLength - 1; // Index for the end of the pattern in the text

  while (i < textLength) {
    int j = patternLength - 1; // Index for the end of the pattern
    int k = i; // Index for the current position in the text

    while (j >= 0 && text[k] == pattern[j]) {
      j -= 1;
      k -= 1;
    }

    if (j == -1) {
      matches.add(k + 1); // Match found at position k+1
      i += patternLength;
    } else {
      String char = text[k];
      if (badCharacter.containsKey(char)) {
        i += (badCharacter[char]! > patternLength - j)
            ? badCharacter[char]!
            : patternLength - j;
      } else {
        i += patternLength;
      }
    }
  }

  return matches;
}