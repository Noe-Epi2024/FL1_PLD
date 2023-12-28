import 'package:flutter/material.dart';

class PasswordFieldProvider with ChangeNotifier {
  bool _obscureText = false;

  bool get obscureText => _obscureText;

  set obscureText(bool value) {
    _obscureText = value;
    notifyListeners();
  }

  void toggle() {
    _obscureText = !_obscureText;
    notifyListeners();
  }
}
