import 'package:hyper_tools/components/dropdown/dropdown_entry.dart';
import 'package:hyper_tools/components/future_widget/provider_base.dart';

class DropdownProvider<T> extends ProviderBase {
  DropdownProvider({required List<DropdownEntry<T>> entries, T? initialValue})
      : _entries = entries,
        _isInitialized = true,
        _selectedValue = initialValue;

  DropdownProvider.lazy({T? initialValue})
      : _entries = null,
        _isInitialized = false,
        _selectedValue = initialValue;

  T? _selectedValue;

  T? get selectedValue => _selectedValue;

  set selectedValue(T? value) {
    _selectedValue = value;
    notifyListeners();
  }

  List<DropdownEntry<T>>? _entries;

  List<DropdownEntry<T>>? get entries => _entries;

  set entries(List<DropdownEntry<T>>? value) {
    _entries = value;
    notifyListeners();
  }

  bool _isInitialized;

  bool get isInitialized => _isInitialized;

  set isInitialized(bool value) {
    _isInitialized = value;
    notifyListeners();
  }

  String _filter = '';

  String get filter => _filter;

  set filter(String value) {
    _filter = value;
    notifyListeners();
  }
}
