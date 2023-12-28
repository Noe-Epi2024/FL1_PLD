part of 'landing_page.dart';

class _LandingPageDesktop extends LandingPage {
  const _LandingPageDesktop();

  Widget _buildLetsGoButton() => ElevatedButton(
        onPressed: () async => Navigation.push(const LoginPage()),
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 32),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("C'est parti !"),
              FaIcon(FontAwesomeIcons.chevronRight, size: 16),
            ],
          ),
        ),
      );

  Widget _buildTextBody(BuildContext context) => RichText(
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

  Widget _buildTextTitle(BuildContext context, {TextStyle? style}) => Text(
        'Bienvenue dans une nouvelle ère de collaboration et de réussite professionnelle.',
        style: style ?? Theme.of(context).textTheme.displaySmall,
      );

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: SafeArea(
          child: AuthenticationLayoutDesktop(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _buildTextTitle(context),
                64.height,
                _buildTextBody(context),
                64.height,
                SizedBox(width: 256, height: 56, child: _buildLetsGoButton()),
              ],
            ),
          ),
        ),
      );
}
