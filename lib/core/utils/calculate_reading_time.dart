int calculateReadingTime(String content) {
  final wordCount = content.split(RegExp(r'\s+')).length;

  final speed = (wordCount / 200).ceil();

  return speed;
}
