import 'package:hyper_tools/components/provider/provider_base.dart';

class DatePickerProvider extends ProviderBase {
  DatePickerProvider({DateTime? initialDate}) : _date = initialDate;

  DateTime? _date;

  DateTime? get date => _date;

  set date(DateTime? value) {
    _date = value;
    notifyListeners();
  }

  bool _isOpen = false;

  bool get isOpen => _isOpen;

  set isOpen(bool value) {
    _isOpen = value;
    notifyListeners();
  }
}
