import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hyper_tools/components/confirmation_dialog.dart';
import 'package:hyper_tools/components/provider/provider_resolver.dart';
import 'package:hyper_tools/extensions/error_model_extension.dart';
import 'package:hyper_tools/global/navigation.dart';
import 'package:hyper_tools/helpers/role_helper.dart';
import 'package:hyper_tools/http/requests/project/delete_project.dart';
import 'package:hyper_tools/http/requests/project/get_project.dart';
import 'package:hyper_tools/http/requests/project/member/quit_project.dart';
import 'package:hyper_tools/models/error_model.dart';
import 'package:hyper_tools/models/project/project_model.dart';
import 'package:hyper_tools/pages/home/home_provider.dart';
import 'package:hyper_tools/pages/project/components/members/project_members_tab.dart';
import 'package:hyper_tools/pages/project/components/name/project_name.dart';
import 'package:hyper_tools/pages/project/components/project_page_loading.dart';
import 'package:hyper_tools/pages/project/components/tasks/project_tasks_tab.dart';
import 'package:hyper_tools/pages/project/project_provider.dart';
import 'package:provider/provider.dart';

class ProjectPage extends StatelessWidget {
  const ProjectPage({required this.projectId, super.key});

  final String projectId;

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider<ProjectProvider>(
        create: (_) => ProjectProvider(context, projectId: projectId),
        child: _ProjectPageBuilder(projectId: projectId),
      );
}

class _ProjectPageBuilder extends StatelessWidget {
  const _ProjectPageBuilder({required this.projectId});

  final String projectId;

  Future<void> _loadProject(BuildContext context) async {
    final ProjectProvider provider = context.read<ProjectProvider>();

    try {
      final ProjectModel project = await GetProject(projectId: projectId).get();

      if (!context.mounted) return;

      provider.setSuccessState(project);
    } on ErrorModel catch (e) {
      if (!context.mounted) return;

      provider.setErrorState(e);
    }
  }

  AppBar _appBar(BuildContext context) => AppBar(
        title: ProjectName(projectId: projectId),
        actions: <Widget>[
          PopupMenuButton<void>(
            itemBuilder: (BuildContext popupContext) => <PopupMenuItem<void>>[
              if (RoleHelper.canDeleteProject(
                context.read<ProjectProvider>().project!.role,
              ))
                PopupMenuItem<void>(
                  onTap: () async => _onClickDeleteProject(context),
                  child: const Text(
                    'Supprimer le projet',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                ),
              if (RoleHelper.canLeaveProject(
                context.read<ProjectProvider>().project!.role,
              ))
                PopupMenuItem<void>(
                  onTap: () async => _onClickLeaveProject(context),
                  child: const Text(
                    'Quitter le projet',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                ),
            ],
            icon: const FaIcon(FontAwesomeIcons.ellipsisVertical),
          ),
        ],
      );

  Future<void> _onClickLeaveProject(BuildContext context) async {
    if (!await confirmationDialog(
      context,
      title: 'Êtes-vous sûr(e) de vouloir quitter ce projet ?',
      subtitle:
          'Toutes les tâches qui vous sont attribuées seront désaffectées. Vous pourrez toujours être invité(e) à nouveau dans ce projet.',
    )) return;

    try {
      await QuitProject(projectId: projectId).delete();

      if (!context.mounted) return;

      context.read<HomeProvider>().removeProject(projectId);

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

    try {
      await DeleteProject(projectId: projectId).delete();

      if (!context.mounted) return;

      context.read<HomeProvider>().removeProject(projectId);

      Navigation.pop();
    } on ErrorModel catch (e) {
      e.show();
    }
  }

  Widget _navigationBar(BuildContext context) => DecoratedBox(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          border: Border(
            top: BorderSide(color: Theme.of(context).dividerColor),
          ),
        ),
        child: const TabBar(
          tabs: <Widget>[
            Tab(
              text: 'Tâches',
              icon: FaIcon(FontAwesomeIcons.listCheck, size: 16),
            ),
            Tab(
              text: 'Membres',
              icon: FaIcon(FontAwesomeIcons.userGroup, size: 16),
            ),
          ],
        ),
      );

  Widget _builder(BuildContext context) => DefaultTabController(
        length: 2,
        child: Scaffold(
          bottomNavigationBar: _navigationBar(context),
          appBar: _appBar(context),
          body: SafeArea(
            child: TabBarView(
              children: <Widget>[
                ProjectTasksTab(projectId: projectId),
                ProjectMembersTab(projectId: projectId),
              ],
            ),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) =>
      ProviderResolver<ProjectProvider>.future(
        future: () async => _loadProject(context),
        builder: _builder,
        loader: const ProjectPageLoading(),
      );
}
