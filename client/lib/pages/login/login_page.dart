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
import 'package:hyper_tools/http/requests/authentication/post_login.dart';
import 'package:hyper_tools/local_storage/local_storage.dart';
import 'package:hyper_tools/models/authentication/authentication_model.dart';
import 'package:hyper_tools/models/error_model.dart';
import 'package:hyper_tools/pages/home/home_page.dart';
import 'package:hyper_tools/pages/login/login_page_desktop.dart';
import 'package:hyper_tools/pages/login/login_page_mobile.dart';
import 'package:hyper_tools/pages/login/login_provider.dart';
import 'package:hyper_tools/pages/register/register_page.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _onClickSubmit(BuildContext context) async {
    if (!_formKey.currentState!.validate()) return;

    context.read<LoginProvider>().isLoading = true;

    try {
      final AuthenticationModel authenticationModel = await PostLogin(
        email: _emailController.text,
        password: _passwordController.text,
      ).post();

      Http.accessToken = authenticationModel.accessToken;

      if (context.read<LoginProvider>().shouldStayLoggedIn) {
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
      context.read<LoginProvider>().isLoading = false;
    }
  }

  @protected
  Widget get emailField => TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: _emailController,
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
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
  Widget loginButton(BuildContext context) => ElevatedButton(
        onPressed: () async => _onClickSubmit(context),
        child: const Text('Connexion'),
      );

  @protected
  Widget stayLoggedInCheckbox(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          const Text('Rester connecter'),
          Checkbox(
            value: context.watch<LoginProvider>().shouldStayLoggedIn,
            onChanged: (bool? value) =>
                context.read<LoginProvider>().shouldStayLoggedIn = value!,
          ),
        ],
      );

  @protected
  Widget get createAccountButton => TextButton(
        onPressed: () async =>
            Navigation.push(RegisterPage(), replaceOne: true),
        child: const Text('Créer un compte'),
      );

  @protected
  Form form(BuildContext context) => Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const HeadlineText('Connexion à HyperTools'),
            32.height,
            const TitleText('Adresse email'),
            8.height,
            emailField,
            16.height,
            const TitleText('Mot de passe'),
            8.height,
            passwordField,
            stayLoggedInCheckbox(context),
            8.height,
            SizedBox(height: 56, child: loginButton(context)),
            8.height,
            const Center(child: Text('ou')),
            createAccountButton,
          ],
        ),
      );

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider<LoginProvider>(
        create: (BuildContext context) => LoginProvider(),
        child: AdaptativeLayout(
          mobileLayout: LoginPageMobile(),
          desktopLayout: LoginPageDesktop(),
        ),
      );
}
