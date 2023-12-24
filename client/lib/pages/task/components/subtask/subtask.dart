import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hyper_tools/extensions/error_model_extension.dart';
import 'package:hyper_tools/global/messenger.dart';
import 'package:hyper_tools/http/requests/project/task/subtask/delete_subtask.dart';
import 'package:hyper_tools/http/requests/project/task/subtask/patch_subtask.dart';
import 'package:hyper_tools/models/error_model.dart';
import 'package:hyper_tools/pages/task/components/subtask/subtask_provider.dart';
import 'package:hyper_tools/pages/task/task_provider.dart';
import 'package:provider/provider.dart';

class Subtask extends StatelessWidget {
  const Subtask({
    required this.projectId,
    required this.taskId,
    required this.subtaskId,
    super.key,
  });

  final String projectId;
  final String taskId;
  final String subtaskId;

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider<SubtaskProvider>(
        create: (_) => SubtaskProvider(
          initialName: context.read<TaskProvider>().findSubtask(subtaskId).name,
        ),
        child: _SubtaskBuilder(
          projectId: projectId,
          taskId: taskId,
          subtaskId: subtaskId,
        ),
      );
}

class _SubtaskBuilder extends HookWidget {
  const _SubtaskBuilder({
    required this.projectId,
    required this.taskId,
    required this.subtaskId,
  });

  final String projectId;
  final String taskId;
  final String subtaskId;

  void Function() _initializeController(
    BuildContext context,
    TextEditingController controller,
  ) {
    void listener() => _onNameChanged(context, controller);

    controller.addListener(listener);

    return () => controller.removeListener(listener);
  }

  Future<void> _onClickDelete(BuildContext context) async {
    try {
      await DeleteSubtask(
        projectId: projectId,
        taskId: taskId,
        subtaskId: subtaskId,
      ).delete();

      Messenger.showSnackBarQuickInfo('Supprimé', context);

      context.read<TaskProvider>().deleteSubtask(subtaskId: subtaskId);
    } on ErrorModel catch (e) {
      e.show();
    }
  }

  void _onNameChanged(
    BuildContext context,
    TextEditingController controller,
  ) {
    context.read<SubtaskProvider>().currentName = controller.text;
  }

  Future<void> _onCheckboxChanged(BuildContext context, bool value) async {
    try {
      await PatchSubtask(
        projectId: projectId,
        taskId: taskId,
        subtaskId: subtaskId,
        isDone: value,
      ).patch();

      context
          .read<TaskProvider>()
          .setSubtaskIsDone(subtaskId: subtaskId, value: value);

      Messenger.showSnackBarQuickInfo('Sauvegardé', context);
    } on ErrorModel catch (e) {
      e.show();
    }
  }

  Future<void> _onPressSave(BuildContext context) async {
    try {
      final String name = context.read<SubtaskProvider>().currentName;

      await PatchSubtask(
        projectId: projectId,
        taskId: taskId,
        subtaskId: subtaskId,
        name: name,
      ).patch();

      context
          .read<TaskProvider>()
          .setSubtaskName(subtaskId: subtaskId, value: name);

      Messenger.showSnackBarQuickInfo('Sauvegardé', context);
    } on ErrorModel catch (e) {
      e.show();
    }
  }

  TextField _nameField(
    BuildContext context,
    TextEditingController controller,
  ) =>
      TextField(
        textCapitalization: TextCapitalization.sentences,
        controller: controller,
        decoration: const InputDecoration(
          filled: false,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
      );

  SlidableAction _deleteButton() => SlidableAction(
        onPressed: _onClickDelete,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.red,
        label: 'Supprimer',
        borderRadius: BorderRadius.circular(16),
      );

  TextButton _saveButton(BuildContext context) => TextButton(
        onPressed: () async => _onPressSave(context),
        child: const Text('Sauvegarder'),
      );

  Checkbox _checkbox(BuildContext context) => Checkbox(
        value: context.watch<TaskProvider>().findSubtask(subtaskId).isDone,
        onChanged: (bool? value) async => _onCheckboxChanged(context, value!),
      );

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = useTextEditingController(
      text: context.watch<TaskProvider>().findSubtask(subtaskId).name,
    );

    useEffect(() => _initializeController(context, controller));

    final String oldName =
        context.watch<TaskProvider>().findSubtask(subtaskId).name;

    final String currentName = context.select<SubtaskProvider, String>(
      (SubtaskProvider provider) => provider.currentName,
    );

    return Slidable(
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: <Widget>[_deleteButton()],
      ),
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _checkbox(context),
            Expanded(child: _nameField(context, controller)),
            if (oldName != currentName) _saveButton(context),
          ],
        ),
      ),
    );
  }
}
