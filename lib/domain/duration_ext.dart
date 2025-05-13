extension DurationExt on Duration {
  String get clockFormat {
    return '$inHours : ${inMinutes%60} : ${inSeconds%60}';
  }
}