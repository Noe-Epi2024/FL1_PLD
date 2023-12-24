import 'package:flutter/material.dart';
import 'package:hyper_tools/components/layouts/authentication/authentication_layout_desktop.dart';
import 'package:hyper_tools/pages/login/login_page.dart';
import 'package:hyper_tools/pages/login/login_provider.dart';
import 'package:provider/provider.dart';

class LoginPageDesktop extends LoginPage {
  LoginPageDesktop({super.key});

  SizedBox get _loading => const SizedBox(
        height: 300,
        child: Center(child: CircularProgressIndicator()),
      );

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: SafeArea(
          child: AuthenticationLayoutDesktop(
            child: context.watch<LoginProvider>().isLoading
                ? _loading
                : form(context),
          ),
        ),
      );
}
