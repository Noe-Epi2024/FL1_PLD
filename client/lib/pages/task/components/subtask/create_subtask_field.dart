import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hyper_tools/extensions/error_model_extension.dart';
import 'package:hyper_tools/extensions/text_editing_controller_extension.dart';
import 'package:hyper_tools/http/requests/project/task/subtask/post_subtask.dart';
import 'package:hyper_tools/models/error_model.dart';
import 'package:hyper_tools/models/project/task/subtask/subtask_model.dart';
import 'package:hyper_tools/pages/task/components/subtask/subtask_provider.dart';
import 'package:hyper_tools/pages/task/task_provider.dart';
import 'package:provider/provider.dart';

class CreateSubtaskField extends StatelessWidget {
  const CreateSubtaskField({super.key});

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider<SubtaskProvider>(
        create: (_) => SubtaskProvider(initialName: ''),
        child: const _CreateSubtaskFieldBuilder(),
      );
}

class _CreateSubtaskFieldBuilder extends HookWidget {
  const _CreateSubtaskFieldBuilder();

  void _onNameChanged(BuildContext context, String name) {
    context.read<SubtaskProvider>().currentName = name;
  }

  Future<void> _onClickCreate(
    BuildContext context,
    TextEditingController controller,
  ) async {
    final TaskProvider taskProvider = context.read<TaskProvider>();
    final SubtaskProvider subtaskProvider = context.read<SubtaskProvider>();

    try {
      final String subtaskId = await PostSubtask(
        projectId: taskProvider.projectId,
        taskId: taskProvider.taskId,
        name: subtaskProvider.currentName!,
      ).send();

      final SubtaskModel subtask =
          SubtaskModel(id: subtaskId, name: subtaskProvider.currentName!);

      taskProvider.addSubtask(subtask);
      controller.clear();
    } on ErrorModel catch (e) {
      e.show();
    }
  }

  Widget _buildCreateButton(TextEditingController controller) => Builder(
        builder: (BuildContext context) => TextButton(
          style: const ButtonStyle(
            shape: MaterialStatePropertyAll<OutlinedBorder>(CircleBorder()),
          ),
          onPressed: () async => _onClickCreate(context, controller),
          child: const Text('Ajouter'),
        ),
      );

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = useTextEditingController();

    useEffect(
      controller
          .onValueChanged((String value) => _onNameChanged(context, value)),
      <Object?>[],
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: 'Ajouter une sous-tâche',
          suffixIcon: context
                      .select<SubtaskProvider, String?>(
                        (SubtaskProvider provider) => provider.currentName,
                      )
                      ?.isNotEmpty ??
                  false
              ? _buildCreateButton(controller)
              : null,
        ),
      ),
    );
  }
}
