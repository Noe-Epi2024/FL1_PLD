part of 'register_page.dart';

class _RegisterPageMobile extends RegisterPage {
  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body:
            SafeArea(child: AuthenticationLayoutMobile(child: _RegisterForm())),
      );
}
