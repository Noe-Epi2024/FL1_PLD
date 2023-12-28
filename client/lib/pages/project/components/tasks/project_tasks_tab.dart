import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hyper_tools/components/texts/title_text.dart';
import 'package:hyper_tools/extensions/error_model_extension.dart';
import 'package:hyper_tools/global/navigation.dart';
import 'package:hyper_tools/helpers/role_helper.dart';
import 'package:hyper_tools/http/requests/project/task/post_task.dart';
import 'package:hyper_tools/models/error_model.dart';
import 'package:hyper_tools/models/project/task/task_preview_model.dart';
import 'package:hyper_tools/pages/home/home_provider.dart';
import 'package:hyper_tools/pages/project/components/tasks/project_task_preview.dart';
import 'package:hyper_tools/pages/project/project_provider.dart';
import 'package:hyper_tools/pages/task/task_page.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class ProjectTasksTab extends HookWidget {
  const ProjectTasksTab({required this.projectId, super.key});

  final String projectId;

  Future<void> _onClickCreateTask(BuildContext context) async {
    final HomeProvider homeProvider = context.read<HomeProvider>();
    final ProjectProvider projectProvider = context.read<ProjectProvider>();

    try {
      final String taskId = await PostTask(projectId: projectId).send();

      final TaskPreviewModel newTaskPreview = TaskPreviewModel(
        id: taskId,
        startDate: DateTime.now(),
        numberOfCompletedSubtasks: 0,
        numberOfSubtasks: 0,
      );

      projectProvider.addTaskPreview(newTaskPreview);

      await Navigation.push(
        MultiProvider(
          providers: <SingleChildWidget>[
            ChangeNotifierProvider<HomeProvider>.value(value: homeProvider),
            ChangeNotifierProvider<ProjectProvider>.value(
              value: projectProvider,
            ),
          ],
          child: TaskPage(projectId, taskId),
        ),
      );
    } on ErrorModel catch (e) {
      e.show();
    }
  }

  List<Widget> _taskPreviews(BuildContext context) {
    final List<TaskPreviewModel> taskPreviews =
        context.watch<ProjectProvider>().project!.taskPreviews;

    return taskPreviews
        .map(
          (TaskPreviewModel taskPreview) =>
              TaskPreview(projectId: projectId, taskId: taskPreview.id),
        )
        .toList();
  }

  Widget _buildCreateTaskButton() => Builder(
        builder: (BuildContext context) => FloatingActionButton(
          heroTag: 'create_task',
          onPressed: () async => _onClickCreateTask(context),
          child: const FaIcon(FontAwesomeIcons.plus),
        ),
      );

  @override
  Widget build(BuildContext context) {
    useAutomaticKeepAlive();

    final bool canCreateTask =
        RoleHelper.canCreateTask(context.read<ProjectProvider>().project!.role);

    return Scaffold(
      floatingActionButton: canCreateTask ? _buildCreateTaskButton() : null,
      body: ListView(
        padding:
            const EdgeInsets.only(left: 16, right: 16, top: 32, bottom: 128),
        children: <Widget>[
          const TitleText('Tâches'),
          ..._taskPreviews(context),
        ],
      ),
    );
  }
}
