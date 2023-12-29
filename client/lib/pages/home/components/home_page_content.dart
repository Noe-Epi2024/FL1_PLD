part of '../home_page.dart';

class _HomePageContent extends StatelessWidget {
  const _HomePageContent();

  Widget _buildWelcomeText() => Builder(
        builder: (BuildContext context) => Text(
          'Bonjour, ${context.watch<HomeProvider>().projects?.name}',
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(fontWeight: FontWeight.bold),
        ),
      );

  @override
  Widget build(BuildContext context) => ListView(
        padding:
            const EdgeInsets.only(top: 32, bottom: 128, left: 16, right: 16),
        children: <Widget>[
          _buildWelcomeText(),
          32.height,
          const _HomePageSearchBar(),
          8.height,
          const _ProjectsList(),
        ],
      );
}
