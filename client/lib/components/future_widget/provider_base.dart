import 'package:flutter/material.dart';
import 'package:hyper_tools/models/error_model.dart';

abstract class ProviderBase with ChangeNotifier {
  ProviderBase({bool isInitiallyLoading = false})
      : _isLoading = isInitiallyLoading {
    _isLoading = isInitiallyLoading;
  }

  bool _isLoading;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  ErrorModel? _error;

  ErrorModel? get error => _error;

  set error(ErrorModel? value) {
    _error = value;
    notifyListeners();
  }

  void setErrorState(ErrorModel error) {
    _isLoading = false;
    _error = error;
    notifyListeners();
  }
}
