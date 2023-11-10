import 'dart:ui';
import 'package:flutter/material.dart';

import '../../components/generators/layer.generator.dart';
import '../../global/navigator.dart';
import '../../theme/theme.dart';
import '../login/login.page.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  Widget get _logo => SizedBox(
        height: 128,
        width: 128,
        child: Image.network(
          "https://upload.wikimedia.org/wikipedia/commons/thumb/f/ff/Wikimedia_Commons_logo_white.png/1200px-Wikimedia_Commons_logo_white.png",
        ),
      );

  Image get _backgroundImage => Image.network(
        "https://images.pexels.com/photos/1477199/pexels-photo-1477199.jpeg?cs=srgb&dl=pexels-artem-saranin-1477199.jpg&fm=jpg",
        fit: BoxFit.cover,
      );

  Widget get _welcomeText => Text.rich(
        TextSpan(
          style: TextStyle(color: Colors.white),
          children: [
            TextSpan(
              text: "Bienvenue sur\n",
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextSpan(
              text: "HyperTools,\n\n",
              style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextSpan(
              text: "la plateforme tout-en-un de gestion de VOTRE projet !",
              style: TextStyle(fontSize: 22),
            ),
          ],
        ),
        textAlign: TextAlign.center,
      );

  Widget _connectionButton(context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: ElevatedButton(
          style: ButtonStyle(
            textStyle: MaterialStatePropertyAll(
              TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          onPressed: () => Navigation.push(LoginPage()),
          child: Text("Connexion"),
        ),
      );

  Widget _registerButton(context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: ElevatedButton(
          onPressed: () => Navigation.push(LoginPage()),
          child: Text("Inscription"),
          style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(Colors.white),
            textStyle: MaterialStatePropertyAll(
              TextStyle(fontWeight: FontWeight.bold),
            ),
            foregroundColor:
                MaterialStatePropertyAll(ThemeGenerator.kThemeColor),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            _backgroundImage,
            LayerGenerator.blur,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 36),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _logo,
                  _welcomeText,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _connectionButton(context),
                      _registerButton(context),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}
