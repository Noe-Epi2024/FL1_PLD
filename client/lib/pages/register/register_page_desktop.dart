import 'package:flutter/material.dart';
import 'package:hyper_tools/components/layouts/authentication/authentication_layout_desktop.dart';
import 'package:hyper_tools/pages/register/register_page.dart';

class RegisterPageDekstop extends RegisterPage {
  RegisterPageDekstop({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body:
            SafeArea(child: AuthenticationLayoutDesktop(child: form(context))),
      );
}
