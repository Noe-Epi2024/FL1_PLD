import 'package:flutter/material.dart';

extension InitializeTextEditingController on TextEditingController {
  void Function()? Function() onValueChanged(
    void Function(String) onValueChanged,
  ) {
    void listener() => onValueChanged(text);

    addListener(listener);
    return () => () => removeListener(listener);
  }
}
