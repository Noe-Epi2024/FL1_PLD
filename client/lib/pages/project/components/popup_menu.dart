part of '../project_page.dart';

class _ProjectPagePopupMenu extends StatelessWidget {
  const _ProjectPagePopupMenu();

  Future<void> _onClickLeaveProject(BuildContext context) async {
    if (!await confirmationDialog(
      context,
      title: 'Êtes-vous sûr(e) de vouloir quitter ce projet ?',
      subtitle:
          'Toutes les tâches qui vous sont attribuées seront désaffectées. Vous pourrez toujours être invité(e) à nouveau dans ce projet.',
    )) return;

    final HomeProvider homeProvider = context.read<HomeProvider>();
    final ProjectProvider projectProvider = context.read<ProjectProvider>();

    try {
      await QuitProject(projectId: projectProvider.projectId).send();

      homeProvider.removeProject(projectProvider.projectId);

      Navigation.pop();
    } on ErrorModel catch (e) {
      e.show();
    }
  }

  Future<void> _onClickDeleteProject(BuildContext context) async {
    if (!await confirmationDialog(
      context,
      title: 'Êtes-vous sûr(e) de vouloir supprimer définitivement ce projet ?',
      subtitle:
          "La suppression du projet est irreversible et entrainera une destruction permanente de toutes les données qu'il contient.",
    )) return;

    final HomeProvider homeProvider = context.read<HomeProvider>();
    final ProjectProvider projectProvider = context.read<ProjectProvider>();

    try {
      await DeleteProject(projectId: projectProvider.projectId).send();

      homeProvider.removeProject(projectProvider.projectId);

      Navigation.pop();
    } on ErrorModel catch (e) {
      e.show();
    }
  }

  PopupMenuItem<void> _buildLeaveProjectButton(BuildContext context) =>
      PopupMenuItem<void>(
        onTap: () async => _onClickLeaveProject(context),
        child: const Text(
          'Quitter le projet',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.red,
          ),
        ),
      );

  PopupMenuItem<void> _buildDeleteProjectButton(BuildContext context) =>
      PopupMenuItem<void>(
        onTap: () async => _onClickDeleteProject(context),
        child: const Text(
          'Supprimer le projet',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.red,
          ),
        ),
      );

  @override
  Widget build(BuildContext context) => PopupMenuButton<void>(
        itemBuilder: (BuildContext popupContext) => <PopupMenuItem<void>>[
          if (RoleHelper.canDeleteProject(
            context.read<ProjectProvider>().project!.role,
          ))
            _buildDeleteProjectButton(context),
          if (RoleHelper.canLeaveProject(
            context.read<ProjectProvider>().project!.role,
          ))
            _buildLeaveProjectButton(context),
        ],
        icon: const FaIcon(FontAwesomeIcons.ellipsisVertical),
      );
}
