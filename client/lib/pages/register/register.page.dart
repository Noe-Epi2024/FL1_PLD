import "package:flutter/material.dart";
import "package:provider/provider.dart";

import "../../components/adaptative_layout.dart";
import "../../components/fields/password.field.dart";
import "../../components/generators/text.generator.dart";
import "../../global/messenger.dart";
import "../../global/navigation.dart";
import "../../helpers/validator.helpers.dart";
import "../../http/http.dart";
import "../../http/requests/authentication/register_requests.dart";
import "../../models/authentication.model.dart";
import "../../models/error.model.dart";
import "../home/home.page.dart";
import "../login/login.page.dart";
import "register.page.desktop.dart";
import "register.page.mobile.dart";
import "register_provider.dart";

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  void _onClickSubmit(BuildContext context) async {
    if (!_formKey.currentState!.validate()) return;

    context.read<RegisterProvider>().isLoading = true;

    try {
      final AuthenticationModel authenticationModel = await PostRegister(
        email: _emailController.text,
        password: _passwordController.text,
      ).post();

      Http.accessToken = authenticationModel.accessToken;

      Navigation.push(const HomePage(), replaceAll: true);
    } on ErrorModel catch (e) {
      Messenger.showSnackBarError(e.errorMessage);
    } catch (_) {
    } finally {
      context.read<RegisterProvider>().isLoading = false;
    }
  }

  @protected
  Widget get emailField => Container(
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

  @protected
  Widget get passwordField => Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: PasswordField(
          controller: _passwordController,
        ),
      );

  @protected
  Widget get confirmPasswordField => Container(
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

  @protected
  Widget registerButton(BuildContext context) => Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: ElevatedButton(
          onPressed: () => _onClickSubmit(context),
          child: const Text("Inscription"),
        ),
      );

  @protected
  Widget stayLoggedIn(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Text("Rester connecter"),
          Checkbox(
            value: context.watch<RegisterProvider>().shouldStayLoggedIn,
            onChanged: (value) =>
                context.read<RegisterProvider>().shouldStayLoggedIn = value!,
          ),
        ],
      );

  @protected
  Widget get connect => TextButton(
        onPressed: () => Navigation.push(LoginPage(), replaceOne: true),
        child: const Text("Se connecter"),
      );

  @protected
  Form form(BuildContext context) => Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const HeadlineText(
              "Inscription à HyperTools",
              textAlign: TextAlign.center,
              padding: EdgeInsets.only(bottom: 16),
            ),
            const TitleText(
              "Nom d'utilisateur",
              padding: EdgeInsets.symmetric(vertical: 8),
            ),
            emailField,
            const TitleText(
              "Mot de passe",
              padding: EdgeInsets.symmetric(vertical: 8),
            ),
            passwordField,
            confirmPasswordField,
            stayLoggedIn(context),
            SizedBox(height: 64, child: registerButton(context)),
            Center(
              child: Text(
                "ou",
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ),
            connect,
          ],
        ),
      );

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => RegisterProvider(),
        child: AdaptativeLayout(
          mobileLayout: RegisterPageMobile(),
          desktopLayout: RegisterPageDekstop(),
        ),
      );
}
