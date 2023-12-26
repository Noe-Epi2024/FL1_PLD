import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hyper_tools/components/prefix_icon.dart';
import 'package:hyper_tools/helpers/validator_helpers.dart';

class PasswordField extends StatefulWidget {
  const PasswordField({
    required this.controller,
    super.key,
    this.validator,
    this.hint,
  });

  final TextEditingController controller;
  final String? Function(String? value)? validator;
  final String? hint;

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscureText = true;

  void _toggleObscureText() => setState(() => _obscureText = !_obscureText);

  @override
  Widget build(BuildContext context) => TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: widget.controller,
        obscureText: _obscureText,
        decoration: InputDecoration(
          hintText: widget.hint ?? 'Entrez votre mot de passe',
          prefixIcon: const TextFieldIcon(FontAwesomeIcons.key),
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
            child: const TextFieldIcon(FontAwesomeIcons.solidEye),
          ),
        ),
        validator: widget.validator ??
            (String? value) => ValidatorHelper.isNullOrEmptyValidator(
                  value,
                  'Veuillez entrer votre mot de passe',
                ),
      );
}
