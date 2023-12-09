import "package:flutter/material.dart";

import "../../global/navigation.dart";
import "../../pages/login/login_page.dart";
import "../../pages/register/register_page.dart";

mixin AuthenticationLayoutKit {
  @protected
  Widget get registerButton => ElevatedButton(
        onPressed: () => Navigation.push(RegisterPage()),
        child: const Text("Inscription"),
      );

  @protected
  Widget get connectionButton => TextButton(
        onPressed: () => Navigation.push(LoginPage()),
        child: const Text("Connexion"),
      );
}
