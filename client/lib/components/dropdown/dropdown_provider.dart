import 'package:hyper_tools/components/dropdown/dropdown_entry.dart';
import 'package:hyper_tools/components/provider/provider_base.dart';

class DropdownProvider<T> extends ProviderBase {
  DropdownProvider({
    required List<DropdownEntry<T>> entries,
    DropdownEntry<T>? initialValue,
  })  : _entries = entries,
        _isInitialized = true,
        _selectedValue = initialValue;

  DropdownProvider.lazy({DropdownEntry<T>? initialValue})
      : _entries = null,
        _isInitialized = false,
        _selectedValue = initialValue;

  DropdownEntry<T>? _selectedValue;

  DropdownEntry<T>? get selectedValue => _selectedValue;

  set selectedValue(DropdownEntry<T>? value) {
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

  bool _isOpen = false;

  bool get isOpen => _isOpen;

  set isOpen(bool value) {
    _isOpen = value;
    notifyListeners();
  }

  void setSuccessState(List<DropdownEntry<T>> entries) {
    _entries = entries;
    isLoading_ = false;
    _isInitialized = true;
    notifyListeners();
  }
}
