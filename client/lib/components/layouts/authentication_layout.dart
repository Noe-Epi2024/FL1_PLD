import 'package:flutter/material.dart';
import 'package:hyper_tools/global/navigation.dart';
import 'package:hyper_tools/pages/login/login_page.dart';
import 'package:hyper_tools/pages/register/register_page.dart';

mixin AuthenticationLayoutKit {
  @protected
  Widget get registerButton => ElevatedButton(
        onPressed: () async => Navigation.push(RegisterPage()),
        child: const Text('Inscription'),
      );

  @protected
  Widget get connectionButton => TextButton(
        onPressed: () async => Navigation.push(LoginPage()),
        child: const Text('Connexion'),
      );
}
