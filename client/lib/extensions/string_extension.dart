extension NullOrEmptyString on String? {
  String or(String replacement) {
    if (this == null || this!.isEmpty) return replacement;
    return this!;
  }
}
