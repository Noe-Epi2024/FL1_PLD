import "package:flutter/material.dart";

import "../../components/layouts/authentication_layout_desktop.dart";
import "../../extensions/num_extension.dart";
import "landing_page.dart";

class LandingPageDesktop extends LandingPage {
  const LandingPageDesktop({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: AuthenticationLayoutDesktop(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              textTitle(context),
              64.ph,
              textBody(context),
              64.ph,
              SizedBox(width: 256, height: 56, child: letsGoButton),
            ],
          ),
        ),
      );
}
