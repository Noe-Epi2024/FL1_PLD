import 'package:flutter/material.dart';

class SubtaskProvider with ChangeNotifier {
  SubtaskProvider({String? initialName}) : _currentName = initialName;

  String? _currentName;

  String? get currentName => _currentName;

  set currentName(String? value) {
    _currentName = value;
    notifyListeners();
  }
}
