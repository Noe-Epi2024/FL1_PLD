import "package:flutter/material.dart";
import "package:provider/provider.dart";

import "../../components/adaptative_layout.dart";
import "../../components/fields/password_field.dart";
import "../../components/texts/headline_text.dart";
import "../../components/texts/title_text.dart";
import "../../extensions/num_extension.dart";
import "../../global/messenger.dart";
import "../../global/navigation.dart";
import "../../helpers/validator_helpers.dart";
import "../../http/http.dart";
import "../../http/requests/authentication/login_requests.dart";
import "../../models/authentication_model.dart";
import "../../models/error_model.dart";
import "../home/home_page.dart";
import "../register/register_page.dart";
import "login_page_mobile.dart";
import "login_page_desktop.dart";
import "login_provider.dart";

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _onClickSubmit(BuildContext context) async {
    if (!_formKey.currentState!.validate()) return;

    context.read<LoginProvider>().isLoading = true;

    try {
      final AuthenticationModel authenticationModel = await PostLogin(
        email: _emailController.text,
        password: _passwordController.text,
      ).post();

      Http.accessToken = authenticationModel.accessToken;

      Navigation.push(const HomePage(), replaceAll: true);
    } on ErrorModel catch (e) {
      Messenger.showSnackBarError(e.errorMessage);
    } catch (_) {
    } finally {
      context.read<LoginProvider>().isLoading = false;
    }
  }

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
        onPressed: () => _onClickSubmit(context),
        child: const Text("Connexion"),
      );

  @protected
  Widget stayLoggedInCheckbox(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Text("Rester connecter"),
          Checkbox(
            value: context.watch<LoginProvider>().shouldStayLoggedIn,
            onChanged: (value) =>
                context.read<LoginProvider>().shouldStayLoggedIn = value!,
          ),
        ],
      );

  @protected
  Widget get createAccountButton => TextButton(
        onPressed: () => Navigation.push(RegisterPage(), replaceOne: true),
        child: const Text("Créer un compte"),
      );

  @protected
  Form form(BuildContext context) => Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const HeadlineText(
              "Connexion à HyperTools",
              textAlign: TextAlign.center,
            ),
            32.ph,
            const TitleText("Adresse email"),
            8.ph,
            emailField,
            16.ph,
            const TitleText("Mot de passe"),
            8.ph,
            passwordField,
            stayLoggedInCheckbox(context),
            8.ph,
            SizedBox(height: 64, child: loginButton(context)),
            8.ph,
            const Center(child: Text("ou")),
            createAccountButton,
          ],
        ),
      );

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => LoginProvider(),
        child: AdaptativeLayout(
          mobileLayout: LoginPageMobile(),
          desktopLayout: LoginPageDesktop(),
        ),
      );
}
