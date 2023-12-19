import 'package:flutter/material.dart';
import 'package:hyper_tools/components/layouts/authentication_layout_mobile.dart';
import 'package:hyper_tools/pages/register/register_page.dart';

class RegisterPageMobile extends RegisterPage {
  RegisterPageMobile({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: AuthenticationLayoutMobile(child: form(context)),
      );
}
