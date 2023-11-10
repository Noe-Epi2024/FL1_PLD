import 'package:flutter/material.dart';

import '../../theme/theme.dart';

class TextGenerator {
  static Widget title(
    String text, {
    TextAlign textAlign = TextAlign.start,
  }) =>
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Text(
          text,
          textAlign: textAlign,
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      );

  static Widget headline(
    String text, {
    TextAlign textAlign = TextAlign.start,
  }) =>
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Text(
          text,
          textAlign: textAlign,
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: ThemeGenerator.kThemeColor,
          ),
        ),
      );
}
