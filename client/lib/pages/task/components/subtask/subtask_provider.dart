import 'package:flutter/material.dart';

class SubtaskProvider with ChangeNotifier {
  bool _hasNameChanged = false;

  bool get hasNameChanged => _hasNameChanged;

  set hasNameChanged(bool value) {
    _hasNameChanged = value;
    notifyListeners();
  }
}
