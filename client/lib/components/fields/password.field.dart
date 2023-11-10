import 'package:flutter/material.dart';

import '../../helpers/validator.helpers.dart';
import '../../theme/theme.dart';

class PasswordField extends StatefulWidget {
  const PasswordField({super.key, required this.controller});

  final TextEditingController controller;

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscureText = true;

  void _toggleObscureText() => setState(() => _obscureText = !_obscureText);

  @override
  Widget build(BuildContext context) => TextFormField(
        controller: widget.controller,
        obscureText: _obscureText,
        decoration: InputDecoration(
          label: Text("Entrez votre mot de passe"),
          prefixIcon: Icon(Icons.key),
          suffixIcon: TextButton(
            onPressed: _toggleObscureText,
            style: ButtonStyle(
              splashFactory: NoSplash.splashFactory,
              foregroundColor: MaterialStateProperty.all(
                !_obscureText
                    ? ThemeGenerator.kThemeColor
                    : Theme.of(context).inputDecorationTheme.labelStyle!.color,
              ),
            ),
            child: const Icon(Icons.remove_red_eye_rounded),
          ),
        ),
        validator: (value) => ValidatorHelper.isNullOrEmptyValidator(
          value,
          "Veuillez entrer votre mot de passe",
        ),
      );
}
