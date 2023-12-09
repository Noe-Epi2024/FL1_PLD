import "package:flutter/material.dart";

import "../generators/decoration_generator.dart";
import "../../extensions/num_extension.dart";
import "../../resources/resources.dart";

class AuthenticationLayoutMobile extends StatelessWidget {
  AuthenticationLayoutMobile({super.key, this.child});

  final Widget? child;

  @override
  Widget build(BuildContext context) => SafeArea(
        child: ListView(
          padding:
              const EdgeInsets.only(left: 20, right: 20, top: 16, bottom: 64),
          children: [
            DecorationGenerator.logo(),
            32.ph,
            Resources.illustration(height: 200),
            32.ph,
            if (child != null) child!,
          ],
        ),
      );
}
