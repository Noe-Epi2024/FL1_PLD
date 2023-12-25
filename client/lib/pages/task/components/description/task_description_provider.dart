import 'package:flutter/material.dart';

class TaskDescriptionProvider with ChangeNotifier {
  TaskDescriptionProvider({required String initialDescription})
      : _currentDescription = initialDescription;

  String _currentDescription;

  String get currentDescription => _currentDescription;

  set currentDescription(String value) {
    _currentDescription = value;
    notifyListeners();
  }
}
