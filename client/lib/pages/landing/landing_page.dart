import 'package:flutter/material.dart';
import 'package:hyper_tools/components/adaptative_layout.dart';
import 'package:hyper_tools/global/navigation.dart';
import 'package:hyper_tools/pages/landing/landing_page_desktop.dart';
import 'package:hyper_tools/pages/landing/landing_page_mobile.dart';
import 'package:hyper_tools/pages/login/login_page.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @protected
  Widget get letsGoButton => ElevatedButton(
        onPressed: () async => Navigation.push(LoginPage()),
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 32),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("C'est parti !"),
              Icon(Icons.arrow_forward_ios_rounded, size: 16),
            ],
          ),
        ),
      );

  @protected
  Widget textBody(BuildContext context) => RichText(
        text: TextSpan(
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(height: 1.5),
          children: const <TextSpan>[
            TextSpan(
              text:
                  "HyperTools a été conçu pour simplifier la planification, l'organisation et la collaboration au sein de votre équipe, afin de mener vos projets à bien de manière transparente.\n\n",
            ),
            TextSpan(
              text:
                  'Notre interface conviviale vous permet de créer facilement des tâches en quelques clics. Définissez les détails, attribuez des responsabilités et fixez des échéances, le tout en un seul endroit.\n\n',
            ),
            TextSpan(
              text:
                  "Restez informé de l'avancement de chaque tâche grâce à notre tableau de bord en temps réel. Visualisez les progrès, identifiez les éventuels obstacles et ajustez votre plan en conséquence.",
            ),
          ],
        ),
      );

  @protected
  Widget textTitle(BuildContext context, {TextStyle? style}) => Text(
        'Bienvenue dans une nouvelle ère de collaboration et de réussite professionnelle.',
        style: style ?? Theme.of(context).textTheme.displaySmall,
      );

  @override
  Widget build(BuildContext context) => const AdaptativeLayout(
        mobileLayout: LandingPageMobile(),
        desktopLayout: LandingPageDesktop(),
      );
}
