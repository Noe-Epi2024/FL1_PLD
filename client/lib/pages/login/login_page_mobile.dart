part of 'login_page.dart';

class _LoginPageMobile extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: SafeArea(
          child: AuthenticationLayoutMobile(child: _LoginPageForm()),
        ),
      );
}
