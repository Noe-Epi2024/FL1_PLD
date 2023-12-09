import "package:flutter/material.dart";

class HeadlineText extends StatelessWidget {
  const HeadlineText(
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
