import "package:flutter/material.dart";

import "../../components/generators/layout.generator.dart";
import "../../resources/resources.dart";
import "authentication.layout.dart";

class AuthenticationLayoutDesktop extends StatelessWidget
    with AuthenticationLayout {
  AuthenticationLayoutDesktop({super.key, this.children = const []});

  final List<Widget> children;

  Widget _bodyLeft(BuildContext context) => Center(
        child: Container(
          constraints: const BoxConstraints(minHeight: 700, maxWidth: 700),
          margin: const EdgeInsets.symmetric(vertical: 64),
          padding: const EdgeInsets.symmetric(horizontal: 64),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: children,
          ),
        ),
      );

  @override
  Widget build(BuildContext context) => ListView(
        children: [
          header(context),
          ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height -
                  AuthenticationLayout.kHeaderHeight,
            ),
            child: IntrinsicHeight(
              child: LayoutGenerator.evenlySpacedWidgets(
                children: [
                  _bodyLeft(context),
                  Resources.illustration(),
                ],
              ),
            ),
          ),
        ],
      );
}
