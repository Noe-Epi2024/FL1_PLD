import 'package:flutter/material.dart';

class CreateProjectProvider with ChangeNotifier {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String _name = '';

  String get name => _name;

  set name(String value) {
    _name = value;
    notifyListeners();
  }
}
