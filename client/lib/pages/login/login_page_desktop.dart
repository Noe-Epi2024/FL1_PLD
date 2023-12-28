part of 'login_page.dart';

class _LoginPageDesktop extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: SafeArea(
          child: AuthenticationLayoutDesktop(
            child: _LoginPageForm(),
          ),
        ),
      );
}
