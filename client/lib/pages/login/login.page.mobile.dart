import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

import "../../bloc/authentication/authentication.bloc.dart";
import "../../components/generators/text.generator.dart";
import "../../components/layouts/authentication.layout.mobile.dart";
import "login.page.dart";

class LoginPageMobile extends LoginPage {
  LoginPageMobile({super.key});

  Form _form(BuildContext context, AuthenticationState state) => Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextGenerator.headline(
              context,
              "Connexion à HyperTools",
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            TextGenerator.title("Adresse email"),
            const SizedBox(height: 8),
            emailField,
            const SizedBox(height: 16),
            TextGenerator.title("Mot de passe"),
            const SizedBox(height: 8),
            passwordField,
            stayLoggedIn(context, state.stayLoggedIn),
            const SizedBox(height: 8),
            SizedBox(height: 64, child: loginButton(context)),
            const SizedBox(height: 8),
            const Center(child: Text("ou")),
            createAccountButton,
          ],
        ),
      );

  SizedBox _loading() => const SizedBox(
        height: 300,
        child: Center(child: CircularProgressIndicator()),
      );

  Widget _builder(BuildContext context, AuthenticationState state) =>
      switch (state) {
        AuthenticationLoadingState() => _loading(),
        AuthenticationSuccessState() ||
        AuthenticationInitialState() ||
        AuthenticationFailureState() =>
          _form(context, state),
      };

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: AuthenticationLayoutMobile(
          child: BlocConsumer<AuthenticationBloc, AuthenticationState>(
            listener: listener,
            builder: _builder,
          ),
        ),
      );
}
