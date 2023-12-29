part of '../home_page.dart';

class _CreateProjectButton extends StatelessWidget {
  const _CreateProjectButton();

  Future<void> _onClickCreateProject(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (_) => ChangeNotifierProvider<HomeProvider>.value(
        value: context.read<HomeProvider>(),
        child: const CreateProjectDialog(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => FloatingActionButton(
        heroTag: 'create_project',
        onPressed: () async => _onClickCreateProject(context),
        child: const FaIcon(FontAwesomeIcons.plus),
      );
}
