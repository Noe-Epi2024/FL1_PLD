import 'package:flutter/material.dart';
import 'package:hyper_tools/components/layouts/authentication/authentication_layout.dart';
import 'package:hyper_tools/components/layouts/authentication/authentication_layout_mobile.dart';
import 'package:hyper_tools/extensions/num_extension.dart';
import 'package:hyper_tools/pages/landing/landing_page.dart';

class LandingPageMobile extends LandingPage with AuthenticationLayoutKit {
  const LandingPageMobile({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: AuthenticationLayoutMobile(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              textTitle(context, style: Theme.of(context).textTheme.titleLarge),
              64.ph,
              SizedBox(height: 56, child: registerButton),
              8.ph,
              connectionButton,
            ],
          ),
        ),
      );
}
