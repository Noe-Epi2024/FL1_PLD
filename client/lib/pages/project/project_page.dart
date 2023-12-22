import 'package:flutter/material.dart';
import 'package:hyper_tools/components/future_widget/provider_resolver.dart';
import 'package:hyper_tools/components/texts/title_text.dart';
import 'package:hyper_tools/http/requests/project/get_project.dart';
import 'package:hyper_tools/models/error_model.dart';
import 'package:hyper_tools/models/project/project_model.dart';
import 'package:hyper_tools/pages/project/components/project_page_loading.dart';
import 'package:hyper_tools/pages/project/components/task_preview.dart';
import 'package:hyper_tools/pages/project/project_provider.dart';
import 'package:provider/provider.dart';

class ProjectPage extends StatelessWidget {
  const ProjectPage(this.id, {super.key});

  final String id;

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider<ProjectProvider>(
        create: (_) => ProjectProvider(),
        child: _ProjectPageBuilder(id),
      );
}

class _ProjectPageBuilder extends StatelessWidget {
  const _ProjectPageBuilder(this.id);

  final String id;

  Future<void> _loadProject(BuildContext context) async {
    final ProjectProvider provider = context.read<ProjectProvider>();

    try {
      final ProjectModel project = await GetProject(projectId: id).get();

      provider
        ..project = project
        ..isLoading = false;
    } on ErrorModel catch (e) {
      provider
        ..error = e
        ..isLoading = false;
    }
  }

  AppBar _appBar(BuildContext context) {
    final String name = context.select<ProjectProvider, String>(
      (ProjectProvider provider) => provider.project!.name,
    );

    return AppBar(
      title: Text(name, style: const TextStyle(color: Colors.black)),
    );
  }

  Widget _builder(BuildContext context) {
    final ProjectProvider provider = context.watch<ProjectProvider>();

    return Scaffold(
      appBar: _appBar(context),
      body: ListView(
        padding:
            const EdgeInsets.only(left: 16, right: 16, top: 30, bottom: 100),
        children: <Widget>[
          const TitleText('Tâches'),
          ...provider.project!.taskPreviews.map(TaskPreview.new),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) =>
      ProviderResolver<ProjectProvider>.future(
        future: () async => _loadProject(context),
        builder: _builder,
        loader: const ProjectPageLoading(),
      );
}
