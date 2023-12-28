import 'package:flutter/material.dart';
import 'package:hyper_tools/components/evenly_sized_children.dart';
import 'package:hyper_tools/components/generators/decoration_generator.dart';
import 'package:hyper_tools/extensions/num_extension.dart';
import 'package:hyper_tools/global/navigation.dart';
import 'package:hyper_tools/pages/login/login_page.dart';
import 'package:hyper_tools/pages/register/register_page.dart';
import 'package:hyper_tools/resources/resources.dart';

class AuthenticationLayoutDesktop extends StatelessWidget {
  const AuthenticationLayoutDesktop({super.key, this.child});

  final Widget? child;
  static const double kHeaderHeight = 64;

  @protected
  Widget _buildRegisterButton() => ElevatedButton(
        onPressed: () async => Navigation.push(RegisterPage()),
        child: const Text('Inscription'),
      );

  @protected
  Widget _buildLoginButton() => TextButton(
        onPressed: () async => Navigation.push(const LoginPage()),
        child: const Text('Connexion'),
      );

  Widget _buildHeader(BuildContext context) => Container(
        height: kHeaderHeight,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          border: Border(
            bottom: BorderSide(color: Theme.of(context).dividerTheme.color!),
          ),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              DecorationGenerator.logo(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  _buildRegisterButton(),
                  16.width,
                  _buildLoginButton(),
                ],
              ),
            ],
          ),
        ),
      );

  Widget _buildBodyLeft() => Center(
        child: Container(
          constraints: const BoxConstraints(minHeight: 700, maxWidth: 700),
          margin: const EdgeInsets.only(top: 128),
          padding: const EdgeInsets.symmetric(horizontal: 64),
          child: child,
        ),
      );

  @override
  Widget build(BuildContext context) => ListView(
        children: <Widget>[
          _buildHeader(context),
          ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height - kHeaderHeight,
            ),
            child: IntrinsicHeight(
              child: EvenlySizedChildren(
                children: <Widget>[
                  _buildBodyLeft(),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxHeight: 700),
                    child: Resources.illustration(fit: BoxFit.contain),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
}
