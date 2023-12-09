import "package:flutter/material.dart";

import "../../components/layouts/authentication.layout.mobile.dart";
import "register.page.dart";

class RegisterPageMobile extends RegisterPage {
  RegisterPageMobile({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: AuthenticationLayoutMobile(child: form(context)),
      );
}
