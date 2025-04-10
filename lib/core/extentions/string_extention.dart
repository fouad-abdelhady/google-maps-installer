extension StringExtention on String? {
  bool get nullOrEmpty => this == null || this!.isEmpty;
}
