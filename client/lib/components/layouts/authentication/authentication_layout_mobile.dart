import 'package:flutter/material.dart';
import 'package:hyper_tools/components/generators/decoration_generator.dart';
import 'package:hyper_tools/resources/resources.dart';

class AuthenticationLayoutMobile extends StatelessWidget {
  const AuthenticationLayoutMobile({super.key, this.child});

  final Widget? child;

  @override
  Widget build(BuildContext context) => SafeArea(
        child: ListView(
          padding:
              const EdgeInsets.only(left: 20, right: 20, top: 16, bottom: 64),
          children: <Widget>[
            DecorationGenerator.logo(),
            Resources.illustration(fit: BoxFit.contain),
            if (child != null) child!,
          ],
        ),
      );
}
