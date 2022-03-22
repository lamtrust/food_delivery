extension TumaiStrings on String {
  /// Get your string returned as title cased.
  /// For example hello
  /// Will be returned as Hello
  String get titleCase {
    if (length <= 1) return toUpperCase();

    return '${this[0].toUpperCase()}${substring(1)}';
  }

  String get headingCase {
    List<String> words = split(' ');
    words.forEach((word) {
      words[words.indexOf(word)] = word.titleCase;
    });

    return words.join(' ');
  }

  String get phoneFormat => replaceAll("+", "");
}
