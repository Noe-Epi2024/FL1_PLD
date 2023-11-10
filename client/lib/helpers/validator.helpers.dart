class ValidatorHelper {
  /// If [value] is null or empty, returns [message]. Else returns null.
  static String? isNullOrEmptyValidator(String? value, String message) =>
      value == null || value.isEmpty ? message : null;
}
