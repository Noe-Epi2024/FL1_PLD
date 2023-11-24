import "package:flutter/material.dart";

import "../../components/layouts/authentication.layout.dart";
import "../../components/layouts/authentication.layout.mobile.dart";
import "landing.page.dart";

class LandingPageMobile extends LandingPage with AuthenticationLayout {
  const LandingPageMobile({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: AuthenticationLayoutMobile(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              textTitle(context, style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 64),
              SizedBox(height: 48, child: registerButton(context)),
              const SizedBox(height: 8),
              connectionButton(context),
            ],
          ),
        ),
      );
}
