import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hyper_tools/components/adaptative_layout.dart';
import 'package:hyper_tools/components/confirmation_dialog.dart';
import 'package:hyper_tools/components/layouts/app/app_layout_desktop.dart';
import 'package:hyper_tools/extensions/error_model_extension.dart';
import 'package:hyper_tools/extensions/text_editing_controller_extension.dart';
import 'package:hyper_tools/global/messenger.dart';
import 'package:hyper_tools/global/navigation.dart';
import 'package:hyper_tools/helpers/role_helper.dart';
import 'package:hyper_tools/http/requests/project/delete_project.dart';
import 'package:hyper_tools/http/requests/project/get_project.dart';
import 'package:hyper_tools/http/requests/project/member/quit_project.dart';
import 'package:hyper_tools/http/requests/project/patch_project.dart';
import 'package:hyper_tools/models/error_model.dart';
import 'package:hyper_tools/models/project/project_model.dart';
import 'package:hyper_tools/pages/home/home_provider.dart';
import 'package:hyper_tools/pages/project/components/members/project_members_tab.dart';
import 'package:hyper_tools/pages/project/components/name/project_name_provider.dart';
import 'package:hyper_tools/pages/project/components/tasks/project_tasks_tab.dart';
import 'package:hyper_tools/pages/project/project_provider.dart';
import 'package:provider/provider.dart';

part 'components/desktop/project_page_desktop.dart';
part 'components/mobile/project_page_mobile.dart';
part 'components/project_page_content.dart';
part 'components/popup_menu.dart';
part 'components/name/project_name.dart';

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

class _ProjectPageBuilder extends HookWidget {
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
      desktopLayout: _ProjectPageDesktop(),
      mobileLayout: _ProjectPageMobile(),
    );
  }
}
