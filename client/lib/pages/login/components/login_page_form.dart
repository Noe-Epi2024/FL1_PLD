part of '../login_page.dart';

class _LoginPageForm extends HookWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _onEmailChanged(BuildContext context, String value) {
    context.read<LoginProvider>().email = value;
  }

  void _onPasswordChanged(BuildContext context, String value) {
    context.read<LoginProvider>().password = value;
  }

  Future<void> _onClickSubmit(BuildContext context) async {
    if (!_formKey.currentState!.validate()) return;

    final LoginProvider provider = context.read<LoginProvider>()
      ..isLoading = true;

    try {
      final AuthenticationModel authenticationModel = await PostLogin(
        email: provider.email,
        password: provider.password,
      ).send();

      Http.accessToken = authenticationModel.accessToken;

      if (provider.shouldStayLoggedIn) {
        await LocalStorageHelper.write(
          Consts.accessTokenKey,
          authenticationModel.accessToken,
        );
      }

      await Navigation.push(const HomePage(), replaceAll: true);
    } on ErrorModel catch (e) {
      Messenger.showSnackBarError(e.errorMessage);
    } catch (_) {
    } finally {
      provider.isLoading = false;
    }
  }

  SizedBox _buildLoader() => const SizedBox(
        height: 300,
        child: Center(child: CircularProgressIndicator()),
      );

  Widget _buildEmailField(TextEditingController controller) => TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: controller,
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
        decoration: const InputDecoration(
          hintText: 'Entrez votre adresse email',
          prefixIcon: TextFieldIcon(FontAwesomeIcons.solidUser),
        ),
        validator: (String? value) => ValidatorHelper.isNullOrEmpty(
          value,
          'Veuillez entrer votre adresse email',
        ),
      );

  Widget _buildPasswordField(TextEditingController controller) =>
      PasswordField(controller: controller);

  Widget _buildLoginButton() => Builder(
        builder: (BuildContext context) => ElevatedButton(
          onPressed: () async => _onClickSubmit(context),
          child: const Text('Connexion'),
        ),
      );

  Widget _buildStayLoggedInCheckbox() => Builder(
        builder: (BuildContext context) => Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            const Text('Rester connecter'),
            Checkbox(
              value: context.select<LoginProvider, bool>(
                (LoginProvider provider) => provider.shouldStayLoggedIn,
              ),
              onChanged: (bool? value) =>
                  context.read<LoginProvider>().shouldStayLoggedIn = value!,
            ),
          ],
        ),
      );

  Widget _buildCreateAccountButton() => TextButton(
        onPressed: () async =>
            Navigation.push(const RegisterPage(), replaceOne: true),
        child: const Text('Créer un compte'),
      );

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = useTextEditingController();
    final TextEditingController passwordController = useTextEditingController();

    useEffect(
      () {
        emailController
            .onValueChanged((String value) => _onEmailChanged(context, value));
        passwordController.onValueChanged(
          (String value) => _onPasswordChanged(context, value),
        );

        return null;
      },
      <Object?>[],
    );

    return ProviderResolver<LoginProvider>(
      loader: _buildLoader(),
      builder: (BuildContext resolverContext) => Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const HeadlineText('Connexion à HyperTools'),
            32.height,
            const TitleText('Adresse email'),
            8.height,
            _buildEmailField(emailController),
            16.height,
            const TitleText('Mot de passe'),
            8.height,
            _buildPasswordField(passwordController),
            8.height,
            _buildStayLoggedInCheckbox(),
            16.height,
            SizedBox(height: 50, child: _buildLoginButton()),
            8.height,
            const Center(child: Text('ou')),
            _buildCreateAccountButton(),
          ],
        ),
      ),
    );
  }
}
