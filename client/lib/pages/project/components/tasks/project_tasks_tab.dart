import 'package:flutter/material.dart';
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
import 'package:nested/nested.dart';
import 'package:provider/provider.dart';

class ProjectTasksTab extends StatelessWidget {
  const ProjectTasksTab({required this.projectId, super.key});

  final String projectId;

  Future<void> _onClickCreateTask(BuildContext context) async {
    try {
      final String taskId = await PostTask(projectId: projectId).post();

      final TaskPreviewModel newTaskPreview = TaskPreviewModel(id: taskId);

      final HomeProvider homeProvider = context.read<HomeProvider>();
      final ProjectProvider projectProvider = context.read<ProjectProvider>()
        ..addTaskPreview(newTaskPreview);

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

  FloatingActionButton _createTaskButton(BuildContext context) =>
      FloatingActionButton(
        onPressed: () async => _onClickCreateTask(context),
        child: const Icon(Icons.add),
      );

  @override
  Widget build(BuildContext context) {
    final bool canCreateTask =
        RoleHelper.canCreateTask(context.read<ProjectProvider>().project!.role);

    return Scaffold(
      floatingActionButton: canCreateTask ? _createTaskButton(context) : null,
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
