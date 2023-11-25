import "package:flutter/material.dart";

import "../../resources/resources.dart";
import "authentication.layout.dart";

class AuthenticationLayoutTablet extends StatelessWidget
    with AuthenticationLayout {
  AuthenticationLayoutTablet({super.key, this.children = const []});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) => SafeArea(
        child: ListView(
          padding:
              const EdgeInsets.only(left: 32, right: 32, top: 32, bottom: 64),
          children: [
            header(context, border: false),
            const SizedBox(height: 32),
            Resources.illustration(),
            const SizedBox(height: 32),
            ...children,
          ],
        ),
      );
}
