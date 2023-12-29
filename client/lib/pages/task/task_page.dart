import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hyper_tools/components/adaptative_layout.dart';
import 'package:hyper_tools/components/evenly_sized_children.dart';
import 'package:hyper_tools/components/layouts/app/app_layout_desktop.dart';
import 'package:hyper_tools/components/provider/provider_resolver.dart';
import 'package:hyper_tools/components/shimmer_placeholder.dart';
import 'package:hyper_tools/components/texts/title_text.dart';
import 'package:hyper_tools/extensions/error_model_extension.dart';
import 'package:hyper_tools/extensions/num_extension.dart';
import 'package:hyper_tools/extensions/text_editing_controller_extension.dart';
import 'package:hyper_tools/global/messenger.dart';
import 'package:hyper_tools/helpers/role_helper.dart';
import 'package:hyper_tools/http/requests/project/task/get_task.dart';
import 'package:hyper_tools/http/requests/project/task/patch_task.dart';
import 'package:hyper_tools/models/error_model.dart';
import 'package:hyper_tools/models/project/task/subtask/subtask_model.dart';
import 'package:hyper_tools/models/project/task/task_model.dart';
import 'package:hyper_tools/pages/project/project_provider.dart';
import 'package:hyper_tools/pages/task/components/dates/task_end_date.dart';
import 'package:hyper_tools/pages/task/components/dates/task_start_date.dart';
import 'package:hyper_tools/pages/task/components/description/task_description.dart';
import 'package:hyper_tools/pages/task/components/members/members_dropdown.dart';
import 'package:hyper_tools/pages/task/components/name/task_name_provider.dart';
import 'package:hyper_tools/pages/task/components/subtask/create_subtask_field.dart';
import 'package:hyper_tools/pages/task/components/subtask/subtask.dart';
import 'package:hyper_tools/pages/task/components/task_progress_bar.dart';
import 'package:hyper_tools/pages/task/task_provider.dart';
import 'package:provider/provider.dart';

part 'components/mobile/task_page_mobile.dart';
part 'components/desktop/task_page_desktop.dart';
part 'components/task_page_content.dart';
part 'components/name/task_name.dart';

class TaskPage extends StatelessWidget {
  const TaskPage(this.taskId, {super.key});

  final String taskId;

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider<TaskProvider>(
        create: (_) => TaskProvider(
          taskId: taskId,
          projectProvider: context.read<ProjectProvider>(),
        ),
        child: const _TaskPageBuilder(),
      );
}

class _TaskPageBuilder extends HookWidget {
  const _TaskPageBuilder();

  Future<void> _loadTask(BuildContext context) async {
    final TaskProvider provider = context.read<TaskProvider>();

    try {
      final TaskModel task =
          await GetTask(projectId: provider.projectId, taskId: provider.taskId)
              .send();

      provider.setSuccessState(task);
    } on ErrorModel catch (e) {
      provider.setErrorState(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    useEffect(
      () {
        unawaited(_loadTask(context));
        return null;
      },
      <Object?>[],
    );

    return const AdaptativeLayout(
      mobileLayout: _TaskPageMobile(),
      desktopLayout: _TaskPageDesktop(),
    );
  }
}
