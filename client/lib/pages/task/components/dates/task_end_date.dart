import 'package:flutter/material.dart';
import 'package:hyper_tools/components/date_picker/date_picker.dart';
import 'package:hyper_tools/global/messenger.dart';
import 'package:hyper_tools/helpers/role_helper.dart';
import 'package:hyper_tools/http/requests/project/task/patch_task.dart';
import 'package:hyper_tools/models/error_model.dart';
import 'package:hyper_tools/pages/project/project_provider.dart';
import 'package:hyper_tools/pages/task/task_provider.dart';
import 'package:provider/provider.dart';

class TaskEndDate extends StatelessWidget {
  const TaskEndDate({
    required this.projectId,
    required this.taskId,
    super.key,
  });

  final String projectId;
  final String taskId;

  Future<bool> _onSelectedEndDate(BuildContext context, DateTime date) async {
    try {
      await PatchTask(projectId: projectId, taskId: taskId, endDate: date)
          .patch();

      Messenger.showSnackBarQuickInfo('Sauvegardé', context);

      context
          .read<ProjectProvider>()
          .setTaskEndDate(taskId: taskId, date: date);

      return true;
    } on ErrorModel catch (e) {
      Messenger.showSnackBarError(e.errorMessage);

      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final DateTime? initialDate = context.read<TaskProvider>().task?.endDate;

    return DatePicker(
      label: 'Fin',
      readonly: !RoleHelper.canEditTask(
        context.read<ProjectProvider>().project!.role,
      ),
      initialDate: initialDate,
      onSelected: (DateTime date) async => _onSelectedEndDate(context, date),
    );
  }
}
