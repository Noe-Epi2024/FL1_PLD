import "package:flutter/material.dart";

import "../../components/adaptative_layout.dart";
import "../../global/navigation.dart";
import "../login/login.page.dart";
import "landing.page.desktop.dart";
import "landing.page.mobile.dart";

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @protected
  Widget get letsGoButton => ElevatedButton(
        onPressed: () => Navigation.push(LoginPage()),
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 32),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
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
          children: [
            const TextSpan(
              text:
                  "HyperTools a été conçu pour simplifier la planification, l'organisation et la collaboration au sein de votre équipe, afin de mener vos projets à bien de manière transparente.\n\n",
            ),
            const TextSpan(
              text:
                  "Notre interface conviviale vous permet de créer facilement des tâches en quelques clics. Définissez les détails, attribuez des responsabilités et fixez des échéances, le tout en un seul endroit.\n\n",
            ),
            const TextSpan(
              text:
                  "Restez informé de l'avancement de chaque tâche grâce à notre tableau de bord en temps réel. Visualisez les progrès, identifiez les éventuels obstacles et ajustez votre plan en conséquence.",
            ),
          ],
        ),
      );

  @protected
  Widget textTitle(BuildContext context, {TextStyle? style}) => Text(
        "Bienvenue dans une nouvelle ère de collaboration et de réussite professionnelle.",
        style: style ?? Theme.of(context).textTheme.displaySmall,
      );

  @override
  Widget build(BuildContext context) => const AdaptativeLayout(
        mobileLayout: LandingPageMobile(),
        desktopLayout: LandingPageDesktop(),
      );
}
