part of 'login_page.dart';

class _LoginPageMobile extends StatelessWidget {
  SizedBox _buildLoader() => const SizedBox(
        height: 300,
        child: Center(child: CircularProgressIndicator()),
      );

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: AuthenticationLayoutMobile(
            child: ProviderResolver<LoginProvider>(
              loader: _buildLoader(),
              builder: (_) => _LoginPageForm(),
            ),
          ),
        ),
      );
}
