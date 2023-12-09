import "package:flutter/material.dart";

class RegisterProvider with ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  void set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool _shouldStayLoggedIn = false;
  bool get shouldStayLoggedIn => _shouldStayLoggedIn;
  void set shouldStayLoggedIn(bool value) {
    _shouldStayLoggedIn = value;
    notifyListeners();
  }
}
