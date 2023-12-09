import "package:flutter/material.dart";

import "../../components/layouts/authentication_layout_desktop.dart";
import "register_page.dart";

class RegisterPageDekstop extends RegisterPage {
  RegisterPageDekstop({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: AuthenticationLayoutDesktop(child: form(context)),
      );
}
