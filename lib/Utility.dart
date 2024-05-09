class Utility {
  static int getTimestamp() {
    DateTime now = DateTime.now();
    int millisecondsSinceEpoch = now.millisecondsSinceEpoch;
    int unixTimestamp = (millisecondsSinceEpoch / 1000).round();
    return unixTimestamp;
  }
}
