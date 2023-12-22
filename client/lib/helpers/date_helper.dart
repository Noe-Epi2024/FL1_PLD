import 'package:intl/intl.dart';

class DateHelper {
  static String formatDateToFrench(DateTime date) =>
      DateFormat('d MMM y', 'fr_FR').format(date);
}
