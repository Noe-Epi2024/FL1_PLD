import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:hyper_tools/components/future_widget/provider_resolver.dart';
import 'package:hyper_tools/http/requests/project/get_project.dart';
import 'package:hyper_tools/models/error_model.dart';
import 'package:hyper_tools/models/project/project_model.dart';
import 'package:hyper_tools/pages/project/components/members/project_members_tab.dart';
import 'package:hyper_tools/pages/project/components/project_page_loading.dart';
import 'package:hyper_tools/pages/project/components/tasks/project_tasks_tab.dart';
import 'package:hyper_tools/pages/project/project_provider.dart';
import 'package:provider/provider.dart';

class ProjectPage extends StatelessWidget {
  const ProjectPage({required this.projectId, super.key});

  final String projectId;

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider<ProjectProvider>(
        create: (_) => ProjectProvider(),
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

      provider
        ..project = project
        ..isLoading = false;
    } on ErrorModel catch (e) {
      provider
        ..error = e
        ..isLoading = false;
    }
  }

  AppBar _appBar(BuildContext context) => AppBar(
        title: Text(
          context.watch<ProjectProvider>().project!.name,
          style: const TextStyle(color: Colors.black),
        ),
      );

  Widget _navigationBar(BuildContext context) => DecoratedBox(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          border: Border(
            top: BorderSide(color: Theme.of(context).dividerColor),
          ),
        ),
        child: const TabBar(
          tabs: <Widget>[
            Tab(icon: Icon(Boxicons.bx_list_ul), text: 'Tâches'),
            Tab(icon: Icon(Boxicons.bx_group), text: 'Membres'),
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
