import "package:flutter/material.dart";

import "../../resources/resources.dart";
import "../evenly_spaced_children.dart";
import "../generators/decoration_generator.dart";
import "authentication_layout.dart";

class AuthenticationLayoutDesktop extends StatelessWidget
    with AuthenticationLayoutKit {
  AuthenticationLayoutDesktop({super.key, this.child});

  final Widget? child;
  static const double kHeaderHeight = 64.0;

  Widget header(BuildContext context, {bool border = true}) => Container(
        height: kHeaderHeight,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          border: border
              ? Border(
                  bottom: BorderSide(
                    width: 0.5,
                    color: Theme.of(context).dividerTheme.color!,
                  ),
                )
              : null,
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DecorationGenerator.logo(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    height: 36,
                    width: 128,
                    child: registerButton,
                  ),
                  Container(
                    height: 36,
                    width: 128,
                    child: connectionButton,
                  ),
                ],
              ),
            ],
          ),
        ),
      );

  Widget get _bodyLeft => Center(
        child: Container(
          constraints: const BoxConstraints(minHeight: 700, maxWidth: 700),
          margin: const EdgeInsets.symmetric(vertical: 64),
          padding: const EdgeInsets.symmetric(horizontal: 64),
          child: child,
        ),
      );

  @override
  Widget build(BuildContext context) => ListView(
        children: [
          header(context),
          ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height - kHeaderHeight,
            ),
            child: IntrinsicHeight(
              child: EvenlySpacedChildren(
                children: [
                  _bodyLeft,
                  Resources.illustration(),
                ],
              ),
            ),
          ),
        ],
      );
}
