import 'package:flutter/material.dart';

class TextFieldIcon extends StatelessWidget {
  const TextFieldIcon(this.icon, {super.key});

  final IconData icon;

  @override
  Widget build(BuildContext context) => Icon(icon, size: 16);
}
