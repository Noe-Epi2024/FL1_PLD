import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

import "../../bloc/authentication/authentication.bloc.dart";
import "../../components/fields/password.field.dart";
import "../../components/generators/text.generator.dart";
import "../../components/layouts/authentication.layout.mobile.dart";
import "../../global/messenger.dart";
import "../../global/navigation.dart";
import "../../helpers/validator.helpers.dart";
import "../home/home.page.dart";
import "../login/login.page.dart";
import "register.page.dart";

class RegisterPageMobile extends RegisterPage {
  RegisterPageMobile({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
  }

  Widget get _emailField => Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: _emailController,
          decoration: const InputDecoration(
            label: Text("Entrez votre adresse email"),
            prefixIcon: Icon(Icons.person),
          ),
          validator: (value) => ValidatorHelper.isNullOrEmptyValidator(
            value,
            "Veuillez entrer votre adresse email",
          ),
        ),
      );

  Widget get _passwordField => Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: PasswordField(
          controller: _passwordController,
        ),
      );

  Widget get _confirmPasswordField => Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: PasswordField(
          controller: _confirmPasswordController,
          label: "Confirmez votre mot de passe",
          validator: (value) =>
              ValidatorHelper.isNullOrEmptyValidator(
                value,
                "Veuillez confirmer votre mot de passe",
              ) ??
              ValidatorHelper.matchValidator(
                value,
                _passwordController.text,
                "Le mot de passe ne correspond pas",
              ),
        ),
      );

  Widget get _registerButton => Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: ElevatedButton(
          onPressed: _submit,
          child: const Text("Inscription"),
        ),
      );

  Widget get _stayLoggedIn => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Text("Rester connecter"),
          Checkbox(value: false, onChanged: (value) {}),
        ],
      );

  Widget get _connect => TextButton(
        onPressed: () => Navigation.push(LoginPage(), replaceOne: true),
        child: const Text("Se connecter"),
      );

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: AuthenticationLayoutMobile(
          child: BlocConsumer<AuthenticationBloc, AuthenticationState>(
            listener: (context, state) {
              if (state is AuthenticationSuccessState)
                Navigation.push(const HomePage());
              if (state is AuthenticationFailureState)
                Messenger.showSnackBarError(state.error.errorMessage);
            },
            builder: (BuildContext context, AuthenticationState state) {
              if (state is AuthenticationLoadingState) {
                return const SizedBox(
                  height: 300,
                  child: CircularProgressIndicator(),
                );
              }
              return Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextGenerator.headline(
                      context,
                      "Inscription à HyperTools",
                      textAlign: TextAlign.center,
                      padding: const EdgeInsets.only(bottom: 16),
                    ),
                    TextGenerator.title(
                      "Nom d'utilisateur",
                      padding: const EdgeInsets.symmetric(vertical: 8),
                    ),
                    _emailField,
                    TextGenerator.title(
                      "Mot de passe",
                      padding: const EdgeInsets.symmetric(vertical: 8),
                    ),
                    _passwordField,
                    _confirmPasswordField,
                    _stayLoggedIn,
                    SizedBox(height: 64, child: _registerButton),
                    Center(
                      child: Text(
                        "ou",
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ),
                    _connect,
                  ],
                ),
              );
            },
          ),
        ),
      );
}
