import "package:flutter/material.dart";
import "package:provider/provider.dart";

import "../../components/layouts/authentication.layout.desktop.dart";
import "login.page.dart";
import "login_provider.dart";

class LoginPageDesktop extends LoginPage {
  LoginPageDesktop({super.key});

  SizedBox get _loading => const SizedBox(
        height: 300,
        child: Center(child: CircularProgressIndicator()),
      );

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: AuthenticationLayoutDesktop(
          child: context.watch<LoginProvider>().isLoading
              ? _loading
              : form(context),
        ),
      );
}
