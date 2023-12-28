class ValidatorHelper {
  /// If [value] is null or empty, returns [message]. Else returns null.
  static String? isNullOrEmpty(String? value, String message) =>
      value == null || value.isEmpty ? message : null;

  /// If [value] doesn't match [other], returns [message]. Else returns null.
  static String? match(String? value, String? other, String message) =>
      value != other ? message : null;
}
