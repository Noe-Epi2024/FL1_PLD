import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hyper_tools/extensions/error_model_extension.dart';
import 'package:hyper_tools/global/messenger.dart';
import 'package:hyper_tools/helpers/role_helper.dart';
import 'package:hyper_tools/http/requests/project/task/patch_task.dart';
import 'package:hyper_tools/models/error_model.dart';
import 'package:hyper_tools/pages/project/project_provider.dart';
import 'package:hyper_tools/pages/task/components/description/task_description_provider.dart';
import 'package:hyper_tools/pages/task/task_provider.dart';
import 'package:provider/provider.dart';

class TaskDescription extends StatelessWidget {
  const TaskDescription({
    required this.projectId,
    required this.taskId,
    super.key,
  });

  final String projectId;
  final String taskId;

  @override
  Widget build(BuildContext context) =>
      ChangeNotifierProvider<TaskDescriptionProvider>(
        create: (_) => TaskDescriptionProvider(
          initialDescription: context.read<TaskProvider>().task?.description,
        ),
        child: _TaskDescriptionBuilder(
          projectId: projectId,
          taskId: taskId,
        ),
      );
}

class _TaskDescriptionBuilder extends HookWidget {
  const _TaskDescriptionBuilder({
    required this.projectId,
    required this.taskId,
  });

  final String projectId;
  final String taskId;

  void _onDescriptionChanged(
    BuildContext context,
    TextEditingController controller,
  ) {
    context.read<TaskDescriptionProvider>().currentDescription =
        controller.text;
  }

  void Function() _initializeController(
    BuildContext context,
    TextEditingController controller,
  ) {
    void listener() => _onDescriptionChanged(context, controller);

    controller.addListener(listener);

    return () => controller.removeListener(listener);
  }

  Future<void> _onClickSave(BuildContext context) async {
    try {
      final String? description =
          context.read<TaskDescriptionProvider>().currentDescription;

      await PatchTask(
        projectId: projectId,
        taskId: taskId,
        description: description,
      ).patch();

      context.read<TaskProvider>().setDescription(description);
      Messenger.showSnackBarQuickInfo('Sauvegardé', context);
      FocusScope.of(context).unfocus();
    } on ErrorModel catch (e) {
      e.show();
    }
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = useTextEditingController(
      text: context.read<TaskProvider>().task?.description,
    );

    useEffect(() => _initializeController(context, controller));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Description',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        TextField(
          readOnly: !RoleHelper.canEditTask(
            context.read<ProjectProvider>().project!.role,
          ),
          onTapOutside: (_) => FocusScope.of(context).unfocus(),
          textCapitalization: TextCapitalization.sentences,
          controller: controller,
          decoration: const InputDecoration(
            hintText: 'Écrire une description',
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
          ),
          minLines: 1,
          maxLines: 3,
        ),
        if (context.select<TaskDescriptionProvider, String?>(
              (TaskDescriptionProvider provider) => provider.currentDescription,
            ) !=
            context.watch<TaskProvider>().task?.description)
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () async => _onClickSave(context),
              child: const Text('Enregistrer'),
            ),
          ),
      ],
    );
  }
}
