import "package:flutter/material.dart";

import "../../components/layouts/authentication.layout.desktop.dart";
import "landing.page.dart";

class LandingPageDesktop extends LandingPage {
  const LandingPageDesktop({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: AuthenticationLayoutDesktop(
          children: [
            textTitle(context),
            const SizedBox(height: 64),
            textBody(context),
            const SizedBox(height: 64),
            SizedBox(width: 256, height: 56, child: letsGoButton(context)),
          ],
        ),
      );
}
