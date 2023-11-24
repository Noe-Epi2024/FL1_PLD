import "package:flutter/material.dart";

import "../../global/navigation.dart";
import "../../pages/login/login.page.dart";
import "../../pages/register/register.page.dart";
import "../generators/decoration.generator.dart";

mixin AuthenticationLayout {
  @protected
  static const double kHeaderHeight = 64.0;

  @protected
  Widget connectionButton(context) => TextButton(
        onPressed: () => Navigation.push(LoginPage()),
        child: const Text("Connexion"),
      );

  @protected
  Widget registerButton(context) => ElevatedButton(
        onPressed: () => Navigation.push(const RegisterPage()),
        child: const Text("Inscription"),
      );

  @protected
  Widget header(BuildContext context, {bool border = true}) => Container(
        height: 64,
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
                    child: registerButton(context),
                  ),
                  Container(
                    height: 36,
                    width: 128,
                    child: connectionButton(context),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}
