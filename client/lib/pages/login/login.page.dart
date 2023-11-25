import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

import "../../bloc/authentication/authentication.bloc.dart";
import "../../components/fields/password.field.dart";
import "../../components/generators/layout.generator.dart";
import "../../global/messenger.dart";
import "../../global/navigation.dart";
import "../../helpers/validator.helpers.dart";
import "../home/home.page.dart";
import "../register/register.page.dart";
import "login.page.mobile.dart";

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  @protected
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _submit(BuildContext context) {
    if (!formKey.currentState!.validate()) return;

    context.read<AuthenticationBloc>().add(
          AuthenticationLoginEvent(
            _emailController.text,
            _passwordController.text,
          ),
        );
  }

  @protected
  void listener(BuildContext context, AuthenticationState state) =>
      switch (state) {
        AuthenticationSuccessState() =>
          Navigation.push(const HomePage(), replaceAll: true),
        AuthenticationFailureState() =>
          Messenger.showSnackBarError(state.error.errorMessage),
        AuthenticationLoadingState() || AuthenticationInitialState() => null,
      };

  @protected
  Widget get emailField => TextFormField(
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
      );

  @protected
  Widget get passwordField => PasswordField(controller: _passwordController);

  @protected
  Widget loginButton(BuildContext context) => ElevatedButton(
        onPressed: () => _submit(context),
        child: const Text("Connexion"),
      );

  @protected
  Widget stayLoggedIn(BuildContext context, bool value) => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Text("Rester connecter"),
          Checkbox(
            value: value,
            onChanged: (value) => context
                .read<AuthenticationBloc>()
                .add(AuthenticationSetStayLoggedInEvent(value!)),
          ),
        ],
      );

  @protected
  Widget get createAccountButton => TextButton(
        onPressed: () =>
            Navigation.push(const RegisterPage(), replaceOne: true),
        child: const Text("Créer un compte"),
      );

  @override
  Widget build(BuildContext context) => LayoutGenerator.adaptativeLayout(
        context,
        mobileLayout: LoginPageMobile(),
      );
}
