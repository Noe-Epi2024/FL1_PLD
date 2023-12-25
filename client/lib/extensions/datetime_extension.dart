import 'package:hyper_tools/helpers/date_helper.dart';

extension FormatDateToFrench on DateTime {
  String get toFrench => DateHelper.formatDateToFrench(this);
}
