import 'package:flutter/material.dart';
import 'package:hyper_tools/components/adaptative_layout.dart';
import 'package:hyper_tools/components/fields/password_field.dart';
import 'package:hyper_tools/components/texts/headline_text.dart';
import 'package:hyper_tools/components/texts/title_text.dart';
import 'package:hyper_tools/consts/consts.dart';
import 'package:hyper_tools/extensions/num_extension.dart';
import 'package:hyper_tools/global/messenger.dart';
import 'package:hyper_tools/global/navigation.dart';
import 'package:hyper_tools/helpers/validator_helpers.dart';
import 'package:hyper_tools/http/http.dart';
import 'package:hyper_tools/http/requests/authentication/post_register.dart';
import 'package:hyper_tools/local_storage/local_storage.dart';
import 'package:hyper_tools/models/authentication/authentication_model.dart';
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
  Widget get emailField => TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: _emailController,
        decoration: const InputDecoration(
          hintText: 'Entrez votre adresse email',
          prefixIcon: Icon(Icons.person),
        ),
        validator: (String? value) => ValidatorHelper.isNullOrEmptyValidator(
          value,
          'Veuillez entrer votre adresse email',
        ),
      );

  @protected
  Widget get passwordField => PasswordField(controller: _passwordController);

  @protected
  Widget get confirmPasswordField => PasswordField(
        controller: _confirmPasswordController,
        hint: 'Confirmez votre mot de passe',
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
      );

  @protected
  Widget registerButton(BuildContext context) => ElevatedButton(
        onPressed: () async => _onClickSubmit(context),
        child: const Text('Inscription'),
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
            const HeadlineText('Inscription à HyperTools'),
            32.height,
            const TitleText('Adresse email'),
            8.height,
            emailField,
            16.height,
            const TitleText('Mot de passe'),
            8.height,
            passwordField,
            8.height,
            confirmPasswordField,
            stayLoggedIn(context),
            8.height,
            SizedBox(height: 56, child: registerButton(context)),
            8.height,
            const Center(child: Text('ou')),
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
