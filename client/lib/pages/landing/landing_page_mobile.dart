part of 'landing_page.dart';

class _LandingPageMobile extends LandingPage {
  const _LandingPageMobile();

  @protected
  Widget _buildRegisterButton() => ElevatedButton(
        onPressed: () async => Navigation.push(const RegisterPage()),
        child: const Text('Inscription'),
      );

  @protected
  Widget _buildLoginButton() => TextButton(
        onPressed: () async => Navigation.push(const LoginPage()),
        child: const Text('Connexion'),
      );

  Widget _buildTextTitle({TextStyle? style}) => Builder(
        builder: (BuildContext context) => Text(
          'Bienvenue dans une nouvelle ère de collaboration et de réussite professionnelle.',
          style: style ?? Theme.of(context).textTheme.displaySmall,
        ),
      );

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: SafeArea(
          child: AuthenticationLayoutMobile(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _buildTextTitle(style: Theme.of(context).textTheme.titleLarge),
                64.height,
                SizedBox(height: 56, child: _buildRegisterButton()),
                8.height,
                _buildLoginButton(),
              ],
            ),
          ),
        ),
      );
}
