import "package:flutter/material.dart";

import "../../components/layouts/authentication.layout.tablet.dart";
import "../../extensions/num.extension.dart";
import "landing.page.dart";

class LandingPageTablet extends LandingPage {
  const LandingPageTablet({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: AuthenticationLayoutTablet(
          children: [
            textTitle(context),
            64.ph,
            textBody(context),
            64.ph,
            SizedBox(width: 256, height: 56, child: letsGoButton(context)),
          ],
        ),
      );
}
