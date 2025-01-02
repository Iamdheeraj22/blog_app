class CalculateReadingTime {
  final String text;

  CalculateReadingTime({
    required this.text,
  });

  int calculate() {
    final words = text.split(RegExp(r'\s+'));
    final wordCount = words.length;
    final readingTime = (wordCount / 225).ceil();
    return readingTime;
  }
}
