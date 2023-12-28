import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hyper_tools/components/fields/password_field_provider.dart';
import 'package:hyper_tools/components/prefix_icon.dart';
import 'package:hyper_tools/helpers/validator_helpers.dart';
import 'package:provider/provider.dart';

class PasswordField extends StatelessWidget {
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
  Widget build(BuildContext context) =>
      ChangeNotifierProvider<PasswordFieldProvider>(
        create: (_) => PasswordFieldProvider(),
        child: _PasswordFieldBuilder(
          controller: controller,
          validator: validator,
          hint: hint,
        ),
      );
}

class _PasswordFieldBuilder extends StatelessWidget {
  const _PasswordFieldBuilder({
    required this.controller,
    this.validator,
    this.hint,
  });

  final TextEditingController controller;
  final String? Function(String? value)? validator;
  final String? hint;

  void _toggleObscureText(BuildContext context) =>
      context.read<PasswordFieldProvider>().toggle();

  @override
  Widget build(BuildContext context) {
    final bool obscureText = context.watch<PasswordFieldProvider>().obscureText;

    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hint ?? 'Entrez votre mot de passe',
        prefixIcon: const TextFieldIcon(FontAwesomeIcons.key),
        suffixIcon: TextButton(
          onPressed: () => _toggleObscureText(context),
          style: ButtonStyle(
            splashFactory: NoSplash.splashFactory,
            foregroundColor: MaterialStateProperty.all(
              !obscureText
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).inputDecorationTheme.labelStyle!.color,
            ),
          ),
          child: const TextFieldIcon(FontAwesomeIcons.solidEye),
        ),
      ),
      validator: validator ??
          (String? value) => ValidatorHelper.isNullOrEmpty(
                value,
                'Veuillez entrer votre mot de passe',
              ),
    );
  }
}
