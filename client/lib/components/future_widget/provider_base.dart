import 'package:flutter/material.dart';
import 'package:hyper_tools/models/error_model.dart';

abstract class ProviderBase with ChangeNotifier {
  ProviderBase({bool isInitiallyLoading = false})
      : isLoading_ = isInitiallyLoading {
    isLoading_ = isInitiallyLoading;
  }

  @protected
  bool isLoading_;

  bool get isLoading => isLoading_;

  set isLoading(bool value) {
    isLoading_ = value;
    notifyListeners();
  }

  @protected
  ErrorModel? error_;

  ErrorModel? get error => error_;

  set error(ErrorModel? value) {
    error_ = value;
    notifyListeners();
  }

  void setErrorState(ErrorModel error) {
    isLoading_ = false;
    error_ = error;
    notifyListeners();
  }
}
