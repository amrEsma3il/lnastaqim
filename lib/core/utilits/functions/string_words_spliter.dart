List<String> splitStringByWords(String input, int maxWords) {
  // Split the input string into a list of words
  List<String> words = input.split(RegExp(r'\s+'));
  
  // Initialize the result list
  List<String> result = [];
  
  // Create a temporary list to hold words for each chunk
  List<String> temp = [];

  for (String word in words) {
    temp.add(word);
    if (temp.length == maxWords) {
      // Add the chunk to the result and reset the temp list
      result.add(temp.join(' '));
      temp.clear();
    }
  }

  // Add the remaining words as the last chunk if any
  if (temp.isNotEmpty) {
    result.add(temp.join(' '));
  }

  return result;
}
