import 'package:flutter/material.dart';

class TitleText extends StatelessWidget {
  const TitleText(
    this.text, {
    super.key,
    this.textAlign = TextAlign.start,
    this.padding,
  });
  final String text;
  final TextAlign textAlign;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) => Padding(
        padding: padding ?? const EdgeInsets.symmetric(vertical: 4),
        child: Text(
          text,
          textAlign: textAlign,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
}
