part of '../register_page.dart';

class _RegisterForm extends HookWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _onEmailChanged(BuildContext context, String value) {
    context.read<RegisterProvider>().email = value;
  }

  void _onPasswordChanged(BuildContext context, String value) {
    context.read<RegisterProvider>().password = value;
  }

  void _onConfirmPasswordChanged(BuildContext context, String value) {
    context.read<RegisterProvider>().confirmPassword = value;
  }

  Future<void> _onClickSubmit(BuildContext context) async {
    if (!_formKey.currentState!.validate()) return;

    final RegisterProvider provider = context.read<RegisterProvider>()
      ..isLoading = true;

    try {
      final AuthenticationModel authenticationModel = await PostRegister(
        email: provider.email,
        password: provider.password,
      ).post();

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

  Widget _buildConfirmPasswordField(TextEditingController controller) =>
      Builder(
        builder: (BuildContext context) => PasswordField(
          controller: controller,
          hint: 'Confirmez votre mot de passe',
          validator: (String? value) =>
              ValidatorHelper.isNullOrEmpty(
                value,
                'Veuillez confirmer votre mot de passe',
              ) ??
              ValidatorHelper.match(
                value,
                context.read<RegisterProvider>().confirmPassword,
                'Le mot de passe ne correspond pas',
              ),
        ),
      );

  Widget _buildRegisterButton() => Builder(
        builder: (BuildContext context) => ElevatedButton(
          onPressed: () async => _onClickSubmit(context),
          child: const Text('Inscription'),
        ),
      );

  Widget _buildStayLoggedIn() => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          const Text('Rester connecter'),
          Builder(
            builder: (BuildContext context) => Checkbox(
              value: context.select<RegisterProvider, bool>(
                (RegisterProvider provider) => provider.shouldStayLoggedIn,
              ),
              onChanged: (bool? value) =>
                  context.read<RegisterProvider>().shouldStayLoggedIn = value!,
            ),
          ),
        ],
      );

  Widget _buildLoginButton() => TextButton(
        onPressed: () async =>
            Navigation.push(const LoginPage(), replaceOne: true),
        child: const Text('Se connecter'),
      );

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = useTextEditingController();
    final TextEditingController passwordController = useTextEditingController();
    final TextEditingController confirmPasswordController =
        useTextEditingController();

    useEffect(
      () {
        emailController
            .onValueChanged((String value) => _onEmailChanged(context, value));
        passwordController.onValueChanged(
          (String value) => _onPasswordChanged(context, value),
        );
        confirmPasswordController.onValueChanged(
          (String value) => _onConfirmPasswordChanged(context, value),
        );

        return null;
      },
      <Object?>[],
    );

    return ProviderResolver<RegisterProvider>(
      loader: _buildLoader(),
      builder: (_) => Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const HeadlineText('Inscription à HyperTools'),
            32.height,
            const TitleText('Adresse email'),
            8.height,
            _buildEmailField(emailController),
            16.height,
            const TitleText('Mot de passe'),
            8.height,
            _buildPasswordField(passwordController),
            8.height,
            _buildConfirmPasswordField(confirmPasswordController),
            8.height,
            _buildStayLoggedIn(),
            16.height,
            SizedBox(height: 50, child: _buildRegisterButton()),
            8.height,
            const Center(child: Text('ou')),
            _buildLoginButton(),
          ],
        ),
      ),
    );
  }
}
