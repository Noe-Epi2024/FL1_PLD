import 'package:flutter/material.dart';
import 'package:hyper_tools/components/adaptative_layout.dart';
import 'package:hyper_tools/components/fields/password_field.dart';
import 'package:hyper_tools/components/texts/headline_text.dart';
import 'package:hyper_tools/components/texts/title_text.dart';
import 'package:hyper_tools/consts/consts.dart';
import 'package:hyper_tools/global/messenger.dart';
import 'package:hyper_tools/global/navigation.dart';
import 'package:hyper_tools/helpers/validator_helpers.dart';
import 'package:hyper_tools/http/http.dart';
import 'package:hyper_tools/http/requests/authentication/register_requests.dart';
import 'package:hyper_tools/local_storage/local_storage.dart';
import 'package:hyper_tools/models/authentication_model.dart';
import 'package:hyper_tools/models/error_model.dart';
import 'package:hyper_tools/pages/home/home_page.dart';
import 'package:hyper_tools/pages/login/login_page.dart';
import 'package:hyper_tools/pages/register/register_page_desktop.dart';
import 'package:hyper_tools/pages/register/register_page_mobile.dart';
import 'package:hyper_tools/pages/register/register_provider.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  Future<void> _onClickSubmit(BuildContext context) async {
    if (!_formKey.currentState!.validate()) return;

    context.read<RegisterProvider>().isLoading = true;

    try {
      final AuthenticationModel authenticationModel = await PostRegister(
        email: _emailController.text,
        password: _passwordController.text,
      ).post();

      Http.accessToken = authenticationModel.accessToken;

      if (context.read<RegisterProvider>().shouldStayLoggedIn) {
        await LocalStorage.write(
          Consts.accessTokenKey,
          authenticationModel.accessToken,
        );
      }

      await Navigation.push(const HomePage(), replaceAll: true);
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
            label: Text('Entrez votre adresse email'),
            prefixIcon: Icon(Icons.person),
          ),
          validator: (String? value) => ValidatorHelper.isNullOrEmptyValidator(
            value,
            'Veuillez entrer votre adresse email',
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
          label: 'Confirmez votre mot de passe',
          validator: (String? value) =>
              ValidatorHelper.isNullOrEmptyValidator(
                value,
                'Veuillez confirmer votre mot de passe',
              ) ??
              ValidatorHelper.matchValidator(
                value,
                _passwordController.text,
                'Le mot de passe ne correspond pas',
              ),
        ),
      );

  @protected
  Widget registerButton(BuildContext context) => Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: ElevatedButton(
          onPressed: () async => _onClickSubmit(context),
          child: const Text('Inscription'),
        ),
      );

  @protected
  Widget stayLoggedIn(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          const Text('Rester connecter'),
          Checkbox(
            value: context.watch<RegisterProvider>().shouldStayLoggedIn,
            onChanged: (bool? value) =>
                context.read<RegisterProvider>().shouldStayLoggedIn = value!,
          ),
        ],
      );

  @protected
  Widget get connect => TextButton(
        onPressed: () async => Navigation.push(LoginPage(), replaceOne: true),
        child: const Text('Se connecter'),
      );

  @protected
  Form form(BuildContext context) => Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const HeadlineText(
              'Inscription à HyperTools',
              textAlign: TextAlign.center,
              padding: EdgeInsets.only(bottom: 16),
            ),
            const TitleText(
              "Nom d'utilisateur",
              padding: EdgeInsets.symmetric(vertical: 8),
            ),
            emailField,
            const TitleText(
              'Mot de passe',
              padding: EdgeInsets.symmetric(vertical: 8),
            ),
            passwordField,
            confirmPasswordField,
            stayLoggedIn(context),
            SizedBox(height: 64, child: registerButton(context)),
            Center(
              child: Text(
                'ou',
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ),
            connect,
          ],
        ),
      );

  @override
  Widget build(BuildContext context) =>
      ChangeNotifierProvider<RegisterProvider>(
        create: (BuildContext context) => RegisterProvider(),
        child: AdaptativeLayout(
          mobileLayout: RegisterPageMobile(),
          desktopLayout: RegisterPageDekstop(),
        ),
      );
}
