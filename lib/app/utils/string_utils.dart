String capitalizeFirstOfEach(String input) {
  if (input.isEmpty) {
    return '';
  }
  return input.split(' ').map((word) {
    if (word.isEmpty) return word;
    return word[0].toUpperCase() + word.substring(1).toLowerCase();
  }).join(' ');
}

String capitalizeAndReplace(String? input) {
  if (input == null) return '';

  String processedString = input.replaceAll('_', ' ');

  List<String> words = processedString.toLowerCase().split(' ');
  for (int i = 0; i < words.length; i++) {
    if (words[i].isNotEmpty) {
      words[i] = '${words[i][0].toUpperCase()}${words[i].substring(1)}';
    }
  }
  processedString = words.join(' ');

  return processedString;
}
