import 'package:flutter/material.dart';
import 'package:hyper_tools/components/date_picker/date_picker.dart';
import 'package:hyper_tools/global/messenger.dart';
import 'package:hyper_tools/helpers/role_helper.dart';
import 'package:hyper_tools/http/requests/project/task/patch_task.dart';
import 'package:hyper_tools/models/error_model.dart';
import 'package:hyper_tools/pages/project/project_provider.dart';
import 'package:hyper_tools/pages/task/task_provider.dart';
import 'package:provider/provider.dart';

class TaskStartDate extends StatelessWidget {
  const TaskStartDate({super.key});

  Future<bool> _onSelectedStartDate(BuildContext context, DateTime date) async {
    final TaskProvider provider = context.read<TaskProvider>();

    try {
      await PatchTask(
        projectId: provider.projectId,
        taskId: provider.taskId,
        startDate: date,
      ).send();

      provider.setStartDate(date);

      if (context.mounted) {
        Messenger.showSnackBarQuickInfo('Sauvegardé', context);
      }

      return true;
    } on ErrorModel catch (e) {
      Messenger.showSnackBarError(e.errorMessage);

      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final DateTime? initialDate = context.read<TaskProvider>().task?.startDate;

    return DatePicker(
      label: 'Début',
      readonly: !RoleHelper.canEditTask(
        context.read<ProjectProvider>().project!.role,
      ),
      initialDate: initialDate,
      onSelected: (DateTime date) async => _onSelectedStartDate(context, date),
    );
  }
}
