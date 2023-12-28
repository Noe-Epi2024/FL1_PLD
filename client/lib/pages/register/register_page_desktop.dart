part of 'register_page.dart';

class _RegisterPageDekstop extends RegisterPage {
  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: SafeArea(
          child: AuthenticationLayoutDesktop(child: _RegisterForm()),
        ),
      );
}
