import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hyper_tools/global/messenger.dart';
import 'package:hyper_tools/http/requests/project/task/subtask/delete_subtask.dart';
import 'package:hyper_tools/models/error_model.dart';
import 'package:hyper_tools/models/project/task/subtask/subtask_model.dart';
import 'package:hyper_tools/pages/task/task_provider.dart';
import 'package:provider/provider.dart';

class Subtask extends HookWidget {
  const Subtask({
    required this.subtask,
    required this.projectId,
    required this.taksId,
    super.key,
  });

  final SubtaskModel subtask;
  final String projectId;
  final String taksId;

  Future<void> _onDelete(BuildContext context) async {
    try {
      await DeleteSubtask(
        projectId: projectId,
        taskId: taksId,
        subtaskId: subtask.id,
      ).delete();

      Messenger.showSnackBarQuickInfo('Supprimé', context);

      context.read<TaskProvider>()
        ..task!.substasks.remove(subtask)
        ..notifyListeners();
    } on ErrorModel catch (e) {
      Messenger.showSnackBarError(e.errorMessage);
    }
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

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller =
        useTextEditingController(text: subtask.name);

    return Slidable(
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: <Widget>[
          SlidableAction(
            onPressed: _onDelete,
            backgroundColor: const Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            label: 'Supprimer',
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(child: _nameField(context, controller)),
          if (true)
            TextButton(onPressed: () {}, child: const Text('Sauvegarder')),
          Checkbox(value: subtask.isDone, onChanged: (bool? v) {}),
        ],
      ),
    );
  }
}
