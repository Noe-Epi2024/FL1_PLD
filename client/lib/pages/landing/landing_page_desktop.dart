import 'package:flutter/material.dart';
import 'package:hyper_tools/components/layouts/authentication/authentication_layout_desktop.dart';
import 'package:hyper_tools/extensions/num_extension.dart';
import 'package:hyper_tools/pages/landing/landing_page.dart';

class LandingPageDesktop extends LandingPage {
  const LandingPageDesktop({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: SafeArea(
          child: AuthenticationLayoutDesktop(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                textTitle(context),
                64.height,
                textBody(context),
                64.height,
                SizedBox(width: 256, height: 56, child: letsGoButton),
              ],
            ),
          ),
        ),
      );
}
