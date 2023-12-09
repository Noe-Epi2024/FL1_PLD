import "package:flutter/material.dart";
import "package:provider/provider.dart";

import "../../components/layouts/authentication_layout_mobile.dart";
import "login_page.dart";
import "login_provider.dart";

class LoginPageMobile extends LoginPage {
  LoginPageMobile({super.key});

  SizedBox get _loading => const SizedBox(
        height: 300,
        child: Center(child: CircularProgressIndicator()),
      );

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: AuthenticationLayoutMobile(
          child: context.watch<LoginProvider>().isLoading
              ? _loading
              : form(context),
        ),
      );
}
