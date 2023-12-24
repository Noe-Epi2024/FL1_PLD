import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hyper_tools/global/messenger.dart';
import 'package:hyper_tools/http/requests/project/task/subtask/delete_subtask.dart';
import 'package:hyper_tools/models/error_model.dart';
import 'package:hyper_tools/models/project/task/subtask/subtask_model.dart';
import 'package:hyper_tools/pages/task/components/subtask/subtask_provider.dart';
import 'package:hyper_tools/pages/task/task_provider.dart';
import 'package:provider/provider.dart';

class Subtask extends StatelessWidget {
  const Subtask({
    required this.projectId,
    required this.taskId,
    required this.subtask,
    super.key,
  });

  final String projectId;
  final String taskId;
  final SubtaskModel subtask;

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider<SubtaskProvider>(
        create: (_) => SubtaskProvider(),
        child: _SubtaskBuilder(
          projectId: projectId,
          taskId: taskId,
          subtask: subtask,
        ),
      );
}

class _SubtaskBuilder extends HookWidget {
  const _SubtaskBuilder({
    required this.projectId,
    required this.taskId,
    required this.subtask,
  });

  final String projectId;
  final String taskId;
  final SubtaskModel subtask;

  Future<void> _onClickDelete(BuildContext context) async {
    try {
      await DeleteSubtask(
        projectId: projectId,
        taskId: taskId,
        subtaskId: subtask.id,
      ).delete();

      Messenger.showSnackBarQuickInfo('Supprimé', context);

      context.read<TaskProvider>().deleteSubtask(subtaskId: subtask.id);
    } on ErrorModel catch (e) {
      Messenger.showSnackBarError(e.errorMessage);
    }
  }

  void _onNameChanged(
    BuildContext context,
    TextEditingController controller,
  ) {
    final String currentName = subtask.name;

    context.read<SubtaskProvider>().hasNameChanged =
        controller.text != currentName;
  }

  void Function() _initializeController(
    BuildContext context,
    TextEditingController controller,
  ) {
    void listener() => _onNameChanged(context, controller);

    controller.addListener(listener);

    return () => controller.removeListener(listener);
  }

  Future<void> _onCheckboxChanged(BuildContext context, bool value) async {
    context
        .read<TaskProvider>()
        .setSubtaskIsDone(subtaskId: subtask.id, value: value);
  }

  TextField _nameField(
    BuildContext context,
    TextEditingController controller,
  ) =>
      TextField(
        controller: controller,
        decoration: InputDecoration(
          filled: false,
          enabledBorder: InputBorder.none,
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
      );

  SlidableAction _deleteButton() => SlidableAction(
        onPressed: _onClickDelete,
        backgroundColor: const Color(0xFFFE4A49),
        foregroundColor: Colors.white,
        label: 'Supprimer',
      );

  TextButton _saveButton(BuildContext context) =>
      TextButton(onPressed: () {}, child: const Text('Sauvegarder'));

  Checkbox _checkbox(BuildContext context) => Checkbox(
        value: subtask.isDone,
        onChanged: (bool? value) async => _onCheckboxChanged(context, value!),
      );

  @override
  Widget build(BuildContext context) {
    final String name = subtask.name;

    final TextEditingController controller =
        useTextEditingController(text: name);

    final bool hasNameChanged = context.select<SubtaskProvider, bool>(
      (SubtaskProvider provider) => provider.hasNameChanged,
    );

    useEffect(() => _initializeController(context, controller));

    return Slidable(
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: <Widget>[_deleteButton()],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(child: _nameField(context, controller)),
          if (hasNameChanged) _saveButton(context),
          _checkbox(context),
        ],
      ),
    );
  }
}
