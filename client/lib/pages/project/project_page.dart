import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hyper_tools/components/adaptative_layout.dart';
import 'package:hyper_tools/http/requests/project/get_project.dart';
import 'package:hyper_tools/models/error_model.dart';
import 'package:hyper_tools/models/project/project_model.dart';
import 'package:hyper_tools/pages/home/home_provider.dart';
import 'package:hyper_tools/pages/project/project_page_desktop.dart';
import 'package:hyper_tools/pages/project/project_page_mobile.dart';
import 'package:hyper_tools/pages/project/project_provider.dart';
import 'package:provider/provider.dart';

class ProjectPage extends StatelessWidget {
  const ProjectPage({required this.projectId, super.key});

  final String projectId;

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider<ProjectProvider>(
        create: (_) => ProjectProvider(
          projectId: projectId,
          homeProvider: context.read<HomeProvider>(),
        ),
        child: const _ProjectPageBuilder(),
      );
}

class _ProjectPageBuilder extends StatelessWidget {
  const _ProjectPageBuilder();

  Future<void> _loadProject(BuildContext context) async {
    final ProjectProvider provider = context.read<ProjectProvider>();

    try {
      final ProjectModel project =
          await GetProject(projectId: provider.projectId).send();

      provider.setSuccessState(project);
    } on ErrorModel catch (e) {
      provider.setErrorState(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    useEffect(
      () {
        unawaited(_loadProject(context));
        return null;
      },
      <Object?>[],
    );

    return const AdaptativeLayout(
      desktopLayout: ProjectPageDesktop(),
      mobileLayout: ProjectPageMobile(),
    );
  }
}
