import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hyper_tools/components/evenly_sized_children.dart';
import 'package:hyper_tools/components/texts/title_text.dart';
import 'package:hyper_tools/extensions/error_model_extension.dart';
import 'package:hyper_tools/extensions/num_extension.dart';
import 'package:hyper_tools/http/requests/project/task/subtask/post_subtask.dart';
import 'package:hyper_tools/models/error_model.dart';
import 'package:hyper_tools/models/project/task/subtask/subtask_model.dart';
import 'package:hyper_tools/pages/task/task_provider.dart';
import 'package:provider/provider.dart';

class CreateSubtaskModal extends HookWidget {
  const CreateSubtaskModal({
    required this.projectId,
    required this.taskId,
    super.key,
  });

  final String projectId;
  final String taskId;

  Future<void> _onClickCreate(
    BuildContext context,
    TextEditingController controller,
  ) async {
    try {
      final String subtaskId = await PostSubtask(
        projectId: projectId,
        taskId: taskId,
        name: controller.text,
      ).post();

      final SubtaskModel subtask =
          SubtaskModel(id: subtaskId, name: controller.text);

      context.read<TaskProvider>().addSubtask(subtask);

      Navigator.pop(context);
    } on ErrorModel catch (e) {
      e.show();
    }
  }

  TitleText get _title => const TitleText('Créer une sous-tâche');

  ElevatedButton _createButton(
    BuildContext context,
    TextEditingController controller,
  ) =>
      ElevatedButton(
        onPressed: () async => _onClickCreate(context, controller),
        child: const Text('Créer'),
      );

  TextButton _cancelButton(BuildContext context) => TextButton(
        onPressed: () => Navigator.pop(context),
        child: const Text('Annuler'),
      );

  TextField _nameField(TextEditingController controller) => TextField(
        textCapitalization: TextCapitalization.sentences,
        decoration: const InputDecoration(hintText: 'Nom de la sous-tâche'),
        controller: controller,
      );

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = useTextEditingController();

    return Dialog(
      child: Padding(
        padding: 32.all,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _title,
            16.height,
            _nameField(controller),
            16.height,
            EvenlySizedChildren(
              children: <Widget>[
                _cancelButton(context),
                _createButton(context, controller),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
