import "package:flutter/material.dart";

class TextGenerator {
  static Widget title(
    String text, {
    TextAlign textAlign = TextAlign.start,
    EdgeInsetsGeometry? padding,
  }) =>
      Padding(
        padding: padding ?? EdgeInsets.zero,
        child: Text(
          text,
          textAlign: textAlign,
          style: const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      );

  static Widget headline(
    context,
    String text, {
    TextAlign textAlign = TextAlign.start,
    EdgeInsetsGeometry? padding,
  }) =>
      Padding(
        padding: padding ?? EdgeInsets.zero,
        child: Text(
          text,
          textAlign: textAlign,
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      );
}
