import "package:flutter/material.dart";

import "../../helpers/validator.helpers.dart";

class PasswordField extends StatefulWidget {
  const PasswordField({
    super.key,
    required this.controller,
    this.validator,
    this.label,
  });

  final TextEditingController controller;
  final String? Function(String? value)? validator;
  final String? label;

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscureText = true;

  void _toggleObscureText() => setState(() => _obscureText = !_obscureText);

  @override
  Widget build(BuildContext context) => TextFormField(
        maxLines: 1,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: widget.controller,
        obscureText: _obscureText,
        decoration: InputDecoration(
          label: Text(widget.label ?? "Entrez votre mot de passe"),
          prefixIcon: const Icon(Icons.key),
          suffixIcon: TextButton(
            onPressed: _toggleObscureText,
            style: ButtonStyle(
              splashFactory: NoSplash.splashFactory,
              foregroundColor: MaterialStateProperty.all(
                !_obscureText
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).inputDecorationTheme.labelStyle!.color,
              ),
            ),
            child: const Icon(Icons.remove_red_eye_rounded),
          ),
        ),
        validator: widget.validator ??
            (value) => ValidatorHelper.isNullOrEmptyValidator(
                  value,
                  "Veuillez entrer votre mot de passe",
                ),
      );
}
