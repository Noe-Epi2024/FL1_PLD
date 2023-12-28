part of 'login_page.dart';

class _LoginPageDesktop extends StatelessWidget {
  SizedBox _buildLoader() => const SizedBox(
        height: 300,
        child: Center(child: CircularProgressIndicator()),
      );

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: AuthenticationLayoutDesktop(
            child: ProviderResolver<LoginProvider>(
              loader: _buildLoader(),
              builder: (_) => _LoginPageForm(),
            ),
          ),
        ),
      );
}
