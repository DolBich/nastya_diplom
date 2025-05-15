extension DurationExt on Duration {
  String get clockFormat {
    return '${inHours.toString().padLeft(2, '0')} : ${(inMinutes%60).toString().padLeft(2, '0')} : ${(inSeconds%60).toString().padLeft(2, '0')}';
  }
}