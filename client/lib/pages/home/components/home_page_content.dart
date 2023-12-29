part of '../home_page.dart';

class _HomePageContent extends StatelessWidget {
  const _HomePageContent();

  Future<void> _onClickCreateProject(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (_) => ChangeNotifierProvider<HomeProvider>.value(
        value: context.read<HomeProvider>(),
        child: const CreateProjectDialog(),
      ),
    );
  }

  Widget _buildWelcomeText() => Builder(
        builder: (BuildContext context) => Text(
          'Bonjour, ${context.watch<HomeProvider>().projects?.name}',
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(fontWeight: FontWeight.bold),
        ),
      );

  Widget _buildNoProjectYet() => Builder(
        builder: (BuildContext context) => Text(
          "Vous ne faites pas encore partie d'un projet",
          textAlign: TextAlign.center,
          style: TextStyle(color: Theme.of(context).hintColor, fontSize: 16),
        ),
      );

  Widget _buildCreateFirstProjectButton() => Center(
        child: SizedBox(
          height: 50,
          width: 300,
          child: Builder(
            builder: (BuildContext context) => ElevatedButton(
              onPressed: () async => _onClickCreateProject(context),
              child: const Text('Créer mon premier projet !'),
            ),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    final HomeProvider provider = context.watch<HomeProvider>();

    return ListView(
      padding: const EdgeInsets.only(top: 32, bottom: 128, left: 16, right: 16),
      children: <Widget>[
        _buildWelcomeText(),
        32.height,
        if (provider.projects!.projects.isNotEmpty) ...<Widget>[
          const _HomePageSearchBar(),
          8.height,
          const _ProjectsList(),
        ],
        if (provider.projects!.projects.isEmpty) ...<Widget>[
          128.height,
          _buildNoProjectYet(),
          64.height,
          _buildCreateFirstProjectButton(),
        ],
      ],
    );
  }
}
